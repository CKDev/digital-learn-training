import React, { useEffect } from "react";
import { useDropzone } from "react-dropzone";
import { Grid2 as Grid, Icon, Typography } from "@mui/material";
import UploadFileRoundedIcon from "@mui/icons-material/UploadFileRounded";

const FileDropzone = ({ allowedFileTypes, onFileChange, onFilesRejected }) => {
  const maxSize = 50 * 1024 * 1024; // 50 MB
  const accept = Object.fromEntries(allowedFileTypes.map((type) => [type, []]));

  const { getRootProps, getInputProps, fileRejections } = useDropzone({
    accept,
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
