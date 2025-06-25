const express = require("express")
const pool = require("../config/database")
const upload = require("../config/multer")
const { verifyToken } = require("../middleware/auth")
const { generateUniqueFilename, uploadImageToSupabase } = require("../utils/fileHelpers")

const router = express.Router()

// Submit Report
router.post("/", verifyToken, upload.single("image"), async (req, res) => {
  let connection
  try {
    if (req.user.type !== "user") {
      return res.status(403).json({ message: "Access Denied: Only users can submit reports." })
    }

    const { description, latitude, longitude, category, address_text } = req.body
    const userId = req.user.user_id

    if (!description || !latitude || !longitude || !category) {
      return res.status(400).json({ message: "Description, location, and category are required." })
    }
    if (!req.file) {
      return res.status(400).json({ message: "Image file is required." })
    }

    const imageUrl = await uploadImageToSupabase(
      req.file.buffer,
      await generateUniqueFilename(req.file.originalname),
      "report-images",
    )

    connection = await pool.getConnection()
    await connection.execute(
      "INSERT INTO Reports (user_id, description, latitude, longitude, category, image_url, address_text) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [userId, description, latitude, longitude, category, imageUrl, address_text || null],
    )

    res.status(201).json({ message: "Report submitted successfully!", imageUrl })
  } catch (error) {
    console.error("Error submitting report:", error)
    if (error.message.includes("file size")) {
      return res.status(413).json({ message: "File size too large. Max 5MB allowed." })
    }
    res.status(500).json({ message: "Server error while submitting report." })
  } finally {
    if (connection) connection.release()
  }
})

// Get Home Feed
router.get("/home-feed", verifyToken, async (req, res) => {
  let connection
  try {
    if (req.user.type !== "user") {
      return res.status(403).json({ message: "Access Denied: Only users can view the home feed." })
    }

    const userId = req.user.user_id
    connection = await pool.getConnection()

    // Fetch user's current Wajibika points
    const [userPointsRows] = await connection.execute("SELECT wajibika_points FROM Users WHERE user_id = ?", [userId])
    const wajibikaPoints = userPointsRows[0] ? userPointsRows[0].wajibika_points : 0

    // Fetch approved reports with their latest volunteer event details
    // and check if the current user is a volunteer for the event
    const [reports] = await connection.execute(
      `
            SELECT
                r.report_id,
                r.description,
                r.latitude,
                r.longitude,
                r.category,
                r.image_url AS before_image_url,
                r.status,
                r.created_at,
                r.address_text,
                u.username AS reporter_username,
                ve.event_id,
                ve.event_date,
                ve.is_completed,
                ve.resolved_image_url AS after_image_url,
                CASE WHEN vu.user_id IS NOT NULL THEN TRUE ELSE FALSE END AS is_volunteer_for_event
            FROM
                Reports r
            JOIN
                Users u ON r.user_id = u.user_id
            LEFT JOIN
                VolunteerEvents ve ON r.report_id = ve.report_id
            LEFT JOIN
                VolunteerParticipants vu ON ve.event_id = vu.event_id AND vu.user_id = ?
            WHERE
                r.status = 'approved'
            ORDER BY
                r.created_at DESC;
        `,
      [userId],
    )

    // Separate reports by category
    const categorizedReports = {
      "Clogged Drain": [],
      "Negligent Dumping": [],
    }

    reports.forEach((report) => {
      const reportData = {
        reportId: report.report_id,
        description: report.description,
        latitude: report.latitude,
        longitude: report.longitude,
        category: report.category,
        beforeImageUrl: report.before_image_url,
        status: report.status,
        createdAt: report.created_at,
        addressText: report.address_text,
        reporterUsername: report.reporter_username,
        volunteerEvent: report.event_id
          ? {
              eventId: report.event_id,
              eventDate: report.event_date,
              isCompleted: report.is_completed === 1,
              afterImageUrl: report.after_image_url,
              isVolunteerForEvent: report.is_volunteer_for_event === 1,
            }
          : null,
      }
      if (categorizedReports[report.category]) {
        categorizedReports[report.category].push(reportData)
      }
    })

    res.status(200).json({
      wajibikaPoints,
      homeFeed: categorizedReports,
    })
  } catch (error) {
    console.error("Error fetching home feed:", error)
    res.status(500).json({ message: "Server error while fetching home feed." })
  } finally {
    if (connection) connection.release()
  }
})

// Register for Volunteer Event
router.post("/:reportId/volunteer/register", verifyToken, async (req, res) => {
  let connection
  try {
    if (req.user.type !== "user") {
      return res.status(403).json({ message: "Access Denied: Only users can register for volunteer events." })
    }

    const reportId = req.params.reportId
    const userId = req.user.user_id

    connection = await pool.getConnection()

    // 1. Check if the report exists and is approved
    const [reports] = await connection.execute("SELECT report_id, status FROM Reports WHERE report_id = ?", [reportId])
    if (reports.length === 0) {
      return res.status(404).json({ message: "Report not found." })
    }
    if (reports[0].status !== "approved") {
      return res
        .status(400)
        .json({ message: "Cannot register for a volunteer event on a report that is not approved." })
    }

    // 2. Check if there's an existing volunteer event for this report
    const [events] = await connection.execute(
      "SELECT event_id, is_completed FROM VolunteerEvents WHERE report_id = ?",
      [reportId],
    )
    const event = events[0]

    if (event && event.is_completed === 1) {
      return res.status(400).json({ message: "This report has already been resolved by a completed volunteer event." })
    }

    let eventId
    if (!event) {
      // No existing event, create one for the next immediate Saturday
      const today = new Date()
      const dayOfWeek = today.getDay() // 0 = Sunday, 6 = Saturday
      let daysUntilSaturday = 6 - dayOfWeek
      if (daysUntilSaturday <= 0) {
        // If today is Saturday or Sunday, schedule for next Saturday
        daysUntilSaturday += 7
      }

      const eventDate = new Date(today)
      eventDate.setDate(today.getDate() + daysUntilSaturday)
      eventDate.setHours(9, 0, 0, 0) // Set to 9:00 AM

      const [result] = await connection.execute("INSERT INTO VolunteerEvents (report_id, event_date) VALUES (?, ?)", [
        reportId,
        eventDate,
      ])
      eventId = result.insertId
    } else {
      eventId = event.event_id
    }

    // 3. Check if user is already a participant
    const [participants] = await connection.execute(
      "SELECT user_id FROM VolunteerParticipants WHERE event_id = ? AND user_id = ?",
      [eventId, userId],
    )
    if (participants.length > 0) {
      return res.status(409).json({ message: "User is already registered for this volunteer event." })
    }

    // 4. Register the user for the event
    await connection.execute("INSERT INTO VolunteerParticipants (event_id, user_id) VALUES (?, ?)", [eventId, userId])

    res.status(200).json({ message: "Successfully registered for the volunteer event.", eventId: eventId })
  } catch (error) {
    console.error("Error registering for volunteer event:", error)
    res.status(500).json({ message: "Server error while registering for volunteer event." })
  } finally {
    if (connection) connection.release()
  }
})

// Unregister from Volunteer Event
router.delete("/:reportId/volunteer/unregister", verifyToken, async (req, res) => {
  let connection
  try {
    if (req.user.type !== "user") {
      return res.status(403).json({ message: "Access Denied: Only users can unregister from volunteer events." })
    }

    const reportId = req.params.reportId
    const userId = req.user.user_id

    connection = await pool.getConnection()
    await connection.beginTransaction() // Start a transaction

    // 1. Find the volunteer event associated with the report
    const [events] = await connection.execute(
      "SELECT event_id, is_completed FROM VolunteerEvents WHERE report_id = ?",
      [reportId],
    )
    const event = events[0]

    if (!event) {
      await connection.rollback()
      return res.status(404).json({ message: "No volunteer event found for this report." })
    }

    if (event.is_completed === 1) {
      await connection.rollback()
      return res.status(400).json({ message: "Cannot unregister from a completed volunteer event." })
    }

    // 2. Check if the user is actually a participant
    const [participants] = await connection.execute(
      "SELECT user_id FROM VolunteerParticipants WHERE event_id = ? AND user_id = ?",
      [event.event_id, userId],
    )
    if (participants.length === 0) {
      await connection.rollback()
      return res.status(404).json({ message: "User is not registered for this volunteer event." })
    }

    // 3. Delete the participation entry
    await connection.execute("DELETE FROM VolunteerParticipants WHERE event_id = ? AND user_id = ?", [
      event.event_id,
      userId,
    ])

    // 4. Check if there are any remaining participants for this event
    const [remainingParticipants] = await connection.execute(
      "SELECT COUNT(*) AS count FROM VolunteerParticipants WHERE event_id = ?",
      [event.event_id],
    )
    if (remainingParticipants[0].count === 0) {
      // If no more participants, delete the volunteer event itself
      await connection.execute("DELETE FROM VolunteerEvents WHERE event_id = ?", [event.event_id])
      console.log(`Volunteer event ${event.event_id} deleted as it has no more participants.`)
    }

    await connection.commit() // Commit the transaction
    res.status(200).json({ message: "Successfully unregistered from the volunteer event." })
  } catch (error) {
    await connection.rollback() // Rollback on error
    console.error("Error unregistering from volunteer event:", error)
    res.status(500).json({ message: "Server error while unregistering from volunteer event." })
  } finally {
    if (connection) connection.release()
  }
})

module.exports = router
