# EroGrabber 📥

EroGrabber is a lightweight Ruby tool designed to make downloading video content from EroThots simple and fast. Unlike traditional methods that require digging through browser developer tools, this script automatically "scrapes" the page to find the high-quality video source for you.

---

### 📝 Author's Note
> **Apologies to the community—this is my first time using GitHub!** I created this downloader because I wanted a simpler way to save videos without dealing with the Network tab every time, and I wanted to share it with everyone. I hope you find it useful!

---

## ✨ Features
- **No Developer Tools Required**: You don't need to open the "Network" tab or search for `.mp4` links manually.
- **High Quality**: Downloads the original stream directly from the CDN using `ffmpeg`.
- **Automated Path Fixing**: Automatically handles CDN formatting (adding hostnames and slashes) so you don't have to.

## 🛠 Prerequisites & Installation

To use this script, you need to have **Ruby**, **FFmpeg**, and **xclip** installed. Find your Operating System below for instructions:

### 🐧 Linux

**Arch / Artix Linux:**
```bash
sudo pacman -S ruby ffmpeg xclip
