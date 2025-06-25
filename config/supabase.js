const { createClient } = require("@supabase/supabase-js")

// Supabase Storage Setup (for images)
const supabaseUrl = process.env.SUPABASE_URL
const supabaseKey = process.env.SUPABASE_KEY

const supabase = createClient(supabaseUrl, supabaseKey, {
  auth: { persistSession: false }, // Prevent session from being stored in local storage
})

module.exports = { supabase, supabaseUrl }
