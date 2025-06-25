const { v4: uuidv4 } = require("uuid")
const { supabase, supabaseUrl } = require("../config/supabase")

async function generateUniqueFilename(originalName) {
  const fileExtension = originalName.split(".").pop()
  const uniqueId = uuidv4()
  return `${uniqueId}.${fileExtension}`
}

async function uploadImageToSupabase(fileBuffer, fileName, bucketName) {
  const { data, error } = await supabase.storage.from(bucketName).upload(fileName, fileBuffer, {
    contentType: "image/jpeg", 
    upsert: false, 
  })

  if (error) {
    console.error("Supabase upload error:", error)
    throw new Error("Failed to upload image to storage.")
  }
  // Construct the public URL
  const publicURL = `${supabaseUrl}/storage/v1/object/public/${bucketName}/${fileName}`
  return publicURL
}

// Function to delete image from Supabase Storage
async function deleteImageFromSupabase(filePath, bucketName) {
  // Extract the path within the bucket
  const pathInBucket = filePath.split(`${bucketName}/`)[1]
  if (!pathInBucket) {
    console.warn(`Could not extract path from URL: ${filePath}`)
    return 
  }

  const { data, error } = await supabase.storage.from(bucketName).remove([pathInBucket])

  if (error) {
    console.error("Supabase delete error:", error)
    throw new Error("Failed to delete image from storage.")
  }
  console.log("Image deleted from Supabase:", data)
}

module.exports = {
  generateUniqueFilename,
  uploadImageToSupabase,
  deleteImageFromSupabase,
}
