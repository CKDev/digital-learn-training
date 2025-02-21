export function getHumanReadableFileType(mimeType) {
  const mimeTypeMap = {
    "application/pdf": "PDF File",
    "image/png": "PNG Image",
    "image/jpeg": "JPEG Image",
    "image/gif": "GIF Image",
    "image/webp": "WebP Image",
    "application/vnd.ms-excel": "Excel File (Legacy)",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": "Excel File",
    "text/csv": "CSV File",
    "application/vnd.ms-powerpoint": "PowerPoint File (Legacy)",
    "application/vnd.openxmlformats-officedocument.presentationml.presentation": "PowerPoint File",
    "application/msword": "Word Document (Legacy)",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document": "Word Document",
    "application/zip": "ZIP Archive",
    "application/octet-stream": "Binary File",
    "application/x-iwork-numbers-sffnumbers": "iWork Numbers File (Legacy)",
    "application/x-iwork-pages-sffpages": "iWork Pages File (Legacy)",
    "application/vnd.apple.pages": "iWork Pages File",
    "application/vnd.apple.numbers": "iWork Numbers File",
    "text/plain": "Text File",
    "video/mp4": "MP4 Video",
    "audio/mpeg": "MP3 Audio",
  };

  return mimeTypeMap[mimeType] || "Unknown File Type";
}