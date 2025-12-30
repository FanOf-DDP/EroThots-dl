#!/usr/bin/env ruby
require 'open-uri'

# 1. Get the Page URL from argument or clipboard
page_url = ARGV[0] || `xclip -selection clipboard -o`.strip

if !page_url.start_with?("https://erothots1.com/video/")
  puts "❌ Error: Please provide the standard webpage URL."
  exit 1
end

puts "🔍 Scraping page for hidden video source..."

# 2. Fetch the page and find the CDN stub
# We use a real User-Agent to avoid the 'Connection Reset'
user_agent = "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0"
begin
  html = `curl -s -L -A "#{user_agent}" "#{page_url}"`
  
  # Search for the CDN link pattern in the HTML
  # This regex looks for erocdn.co links ending in .mp4
  match = html.match(/https:\/\/[a-z0-9.]+\.erocdn\.co\/[^"']+\.mp4/)
  
  if match
    cdn_url = match[0]
  else
    # Fallback: Look for the 'contentUrl' inside the JSON-LD metadata
    json_match = html.match(/"contentUrl":\s*"([^"]+)"/)
    cdn_url = json_match ? json_match[1] : nil
  end
rescue => e
  puts "❌ Error fetching page: #{e.message}"
  exit 1
end

if cdn_url.nil?
  puts "❌ Could not find the source. The site might be blocking the scraper."
  exit 1
end

# 3. Process Host and Filename
host = cdn_url.split('/')[2]
filename = cdn_url.split('/').last

puts "------------------------------------------"
puts "🌐 Host:     #{host}"
puts "📄 Filename: #{filename}"
puts "🔗 Found:    #{cdn_url}"
puts "------------------------------------------"

# 4. Download via FFmpeg (most reliable for your Artix setup)
puts "📥 Starting download..."
referer = "https://erothots1.com/"

cmd = [
  "ffmpeg", "-hide_banner", "-loglevel", "error", "-stats",
  "-user_agent", "'#{user_agent}'",
  "-headers", "'Referer: #{referer}\r\n'",
  "-i", "'#{cdn_url}'",
  "-c", "copy",
  "-y", "'#{filename}'"
].join(" ")

if system(cmd)
  puts "✅ Success! Saved to your current folder."
else
  puts "❌ Download failed. The link may be session-locked."
end
