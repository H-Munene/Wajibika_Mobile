// Load environment variables from .env file
require("dotenv").config()

const express = require("express")
const cors = require("cors")
const authRoutes = require("./routes/auth")
const reportRoutes = require("./routes/reports")

// Create an Express application instance
const app = express()

// Middleware
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// Routes
app.use("/api/auth", authRoutes)
app.use("/api/reports", reportRoutes)

// Define the port for the server to listen on
const PORT = process.env.PORT || 3000
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})
