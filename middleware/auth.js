const jwt = require("jsonwebtoken")

// JWT Secret from environment variables
const JWT_SECRET = process.env.JWT_SECRET
if (!JWT_SECRET) {
  console.error("FATAL ERROR: JWT_SECRET is not defined.")
  process.exit(1)
}

// Middleware to verify JWT token
const verifyToken = (req, res, next) => {
  // Get token from Bearer TOKEN
  const authHeader = req.headers["authorization"]
  if (!authHeader) return res.status(401).json({ message: "Access Denied: No token provided!" })

  const token = authHeader.split(" ")[1] 
  if (!token) return res.status(401).json({ message: "Access Denied: Token malformed!" })

  try {
    const verified = jwt.verify(token, JWT_SECRET)
    req.user = verified // Attach user payload to the request
    next()
  } catch (err) {
    res.status(403).json({ message: "Access Denied: Invalid token!" })
  }
}

module.exports = { verifyToken, JWT_SECRET }
