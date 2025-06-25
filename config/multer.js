const multer = require("multer")

// Multer Storage Configuration for image uploads
const storage = multer.memoryStorage() 
const upload = multer({
  storage: storage,
  limits: { fileSize: 5 * 1024 * 1024 },
  fileFilter: (req, file, cb) => {
    if (file.mimetype === "image/jpeg" || file.mimetype === "image/png" || file.mimetype === "image/jpg") {
      cb(null, true)
    } else {
      cb(new Error("Only .jpeg, .jpg and .png formats allowed!"), false)
    }
  },
})

module.exports = upload
