import React from "react";
import { useDropzone } from "react-dropzone";
import { Grid2 as Grid, Icon, Typography } from "@mui/material";
import UploadFileRoundedIcon from "@mui/icons-material/UploadFileRounded";

const allowedImageTypes = {
  "image/png": [],
  "image/jpeg": [],
  "image/gif": [],
  "image/webp": [],
};

const ImageDropzone = ({ onImageChange }) => {
  const maxSize = 100 * 1024 * 1024; // 100 MB

  const { getRootProps, getInputProps } = useDropzone({
    allowedImageTypes,
    maxSize,
    onDrop: (acceptedFiles) => {
      onImageChange(acceptedFiles);
    },
  });

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
          Drag & drop or click to select images
        </Typography>
        <Typography variant="body2">
          PNG, JPEG, GIF or WebP files (max. 100MB)
        </Typography>
      </Grid>
    </div>
  );
};

export default ImageDropzone;
