import React, { useEffect } from "react";
import { useDropzone } from "react-dropzone";
import { Grid2 as Grid, Icon, Typography } from "@mui/material";
import UploadFileRoundedIcon from "@mui/icons-material/UploadFileRounded";

const allowedFileTypes = {
  "application/pdf": [], // PDFs
  "application/vnd.ms-excel": [], // Excel 97-2003
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": [], // Modern Excel
  "text/csv": [], // CSV
  "application/vnd.ms-powerpoint": [], // PowerPoint 97-2003
  "application/vnd.openxmlformats-officedocument.presentationml.presentation":
    [], // Modern PowerPoint
  "application/msword": [], // Word 97-2003
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document": [], // Modern Word
  "application/zip": [], // ZIP
  "application/x-iwork-numbers-sffnumbers": [], // iWork Numbers (older versions)
  "application/x-iwork-pages-sffpages": [], // iWork Pages (older versions)
  "application/vnd.apple.pages": [], // Modern iWork Pages
  "application/vnd.apple.numbers": [], // Modern iWork Numbers
};

const FileDropzone = ({ onFileChange, onFilesRejected }) => {
  const maxSize = 50 * 1024 * 1024; // 50 MB

  const { getRootProps, getInputProps, fileRejections } = useDropzone({
    allowedFileTypes,
    maxSize,
    onDrop: (acceptedFiles) => {
      onFileChange(acceptedFiles);
    },
  });

  // Expose file failures to parent
  useEffect(() => {
    onFilesRejected(fileRejections);
  }, [fileRejections]);

  return (
    <div
      {...getRootProps()}
      style={{ border: "1px dashed #ccc", padding: "20px" }}
    >
      <input {...getInputProps()} />
      <Grid container direction="column" alignItems="center" gap={1}>
        <Icon color="primary">
          <UploadFileRoundedIcon />
        </Icon>
        <Typography variant="subtitle1">
          Drag & drop or click to select files
        </Typography>
        <Typography variant="body2">
          PDF, Excel, CSV, PowerPoint, Word, ZIP, iWork files (max. 50MB)
        </Typography>
      </Grid>
    </div>
  );
};

export default FileDropzone;
