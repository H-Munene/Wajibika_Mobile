const express = require("express")
const bcrypt = require("bcryptjs")
const jwt = require("jsonwebtoken")
const crypto = require("crypto")
const pool = require("../config/database")
const { JWT_SECRET } = require("../middleware/auth")

const router = express.Router()

// Secret for password reset tokens
const RESET_PASSWORD_SECRET = process.env.RESET_PASSWORD_SECRET
if (!RESET_PASSWORD_SECRET) {
  console.error("FATAL ERROR: RESET_PASSWORD_SECRET is not defined.")
  process.exit(1)
}

// User Registration
router.post("/register-user", async (req, res) => {
  let connection
  try {
    const { username, email, password } = req.body

    if (!username || !email || !password) {
      return res.status(400).json({ message: "Username, email, and password are required." })
    }

    connection = await pool.getConnection()

    // Check if user already exists
    const [users] = await connection.execute("SELECT user_id FROM Users WHERE email = ?", [email])
    if (users.length > 0) {
      return res.status(409).json({ message: "User with this email already exists." })
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10)

    // Insert new user
    await connection.execute(
      "INSERT INTO Users (username, email, password_hash, wajibika_points) VALUES (?, ?, ?, 0)",
      [username, email, hashedPassword],
    )

    res.status(201).json({ message: "User registered successfully." })
  } catch (error) {
    console.error("Error during user registration:", error)
    res.status(500).json({ message: "Server error during user registration." })
  } finally {
    if (connection) connection.release()
  }
})

// User Login
router.post("/login-user", async (req, res) => {
  let connection
  try {
    const { email, password } = req.body

    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required." })
    }

    connection = await pool.getConnection()

    // Retrieve user
    const [users] = await connection.execute(
      "SELECT user_id, username, email, password_hash, wajibika_points FROM Users WHERE email = ?",
      [email],
    )
    const user = users[0]

    if (!user) {
      return res.status(401).json({ message: "Invalid credentials." })
    }

    // Compare password
    const isMatch = await bcrypt.compare(password, user.password_hash)
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials." })
    }

    // Generate JWT
    const token = jwt.sign(
      { user_id: user.user_id, email: user.email, username: user.username, type: "user" },
      JWT_SECRET,
      { expiresIn: "1h" }, // Token expires in 1 hour
    )

    res.status(200).json({
      message: "Logged in successfully!",
      token,
      user: {
        userId: user.user_id,
        username: user.username,
        email: user.email,
        wajibikaPoints: user.wajibika_points,
      },
    })
  } catch (error) {
    console.error("Error during user login:", error)
    res.status(500).json({ message: "Server error during user login." })
  } finally {
    if (connection) connection.release()
  }
})

// Request Password Reset
router.post("/request-password-reset", async (req, res) => {
  let connection
  try {
    const { email } = req.body
    if (!email) {
      return res.status(400).json({ message: "Email is required." })
    }

    connection = await pool.getConnection()
    const [users] = await connection.execute("SELECT user_id FROM Users WHERE email = ?", [email])
    const user = users[0]

    if (!user) {
      // For security, don't reveal if the email doesn't exist
      return res.status(200).json({ message: "If a user with that email exists, a password reset link has been sent." })
    }

    // Generate a unique, secure token
    const resetToken = crypto.randomBytes(32).toString("hex")
    const expiresAt = new Date(Date.now() + 3600000) // 1 hour from now

    // Store the token and expiry in the database
    await connection.execute(
      "UPDATE Users SET reset_password_token = ?, reset_password_expires = ? WHERE user_id = ?",
      [resetToken, expiresAt, user.user_id],
    )

    // In a real application, you would send this token via email to the user.
    // For demonstration, we'll just log it.
    console.log(`Password reset token for ${email}: ${resetToken}`)
    console.log(`Token expires at: ${expiresAt.toISOString()}`)

    res.status(200).json({ message: "If a user with that email exists, a password reset link has been sent." })
  } catch (error) {
    console.error("Error requesting password reset:", error)
    res.status(500).json({ message: "Server error during password reset request." })
  } finally {
    if (connection) connection.release()
  }
})

// Reset Password
router.post("/reset-password", async (req, res) => {
  let connection
  try {
    const { token, newPassword } = req.body
    if (!token || !newPassword) {
      return res.status(400).json({ message: "Token and new password are required." })
    }

    connection = await pool.getConnection()

    // Find the user with the valid token that hasn't expired
    const [users] = await connection.execute(
      "SELECT user_id FROM Users WHERE reset_password_token = ? AND reset_password_expires > NOW()",
      [token],
    )
    const user = users[0]

    if (!user) {
      return res.status(400).json({ message: "Invalid or expired password reset token." })
    }

    // Hash the new password
    const hashedPassword = await bcrypt.hash(newPassword, 10)

    // Update the user's password and clear the reset token fields
    await connection.execute(
      "UPDATE Users SET password_hash = ?, reset_password_token = NULL, reset_password_expires = NULL WHERE user_id = ?",
      [hashedPassword, user.user_id],
    )

    res.status(200).json({ message: "Password has been reset successfully." })
  } catch (error) {
    console.error("Error resetting password:", error)
    res.status(500).json({ message: "Server error during password reset." })
  } finally {
    if (connection) connection.release()
  }
})

module.exports = router
