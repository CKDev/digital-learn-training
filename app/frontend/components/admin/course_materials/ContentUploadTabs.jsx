import { Box, Grid2 as Grid, Tab, Tabs } from "@mui/material";
import React, { useState } from "react";
import ImageDropzone from "./ImageDropzone";
import FileDropzone from "./FileDropZone";
import FileAttachment from "./FileAttachment";
import RejectedFileAttachment from "./RejectedFileAttachment";
import ImageAttachment from "./ImageAttachment";
import { getHumanReadableFileType } from "@utils/mime_translator";

const ContentUploadTabs = ({
  files,
  images,
  onFileChange,
  onImageChange,
  onFileDelete,
  onImageDelete,
}) => {
  const [selectedUploadTab, setSelectedUploadTab] = useState("files");
  const [rejectedFiles, setRejectedFiles] = useState([]);

  const handleChangeUploadTab = (_event, newValue) => {
    setSelectedUploadTab(newValue);
  };

  const handleFileChange = (newFiles) => {
    // Populate display attributes
    for (let i = 0; i < newFiles.length; i++) {
      newFiles[i].fileName = newFiles[i].name;
      newFiles[i].fileType = getHumanReadableFileType(newFiles[i].type);
    }

    onFileChange(newFiles);
  };

  const handleImageChange = (newImages) => {
    // Populate display attributes
    for (let i = 0; i < newImages.length; i++) {
      newImages[i].thumbnailUrl = URL.createObjectURL(newImages[i]);
      newImages[i].fileName = newImages[i].name;
      newImages[i].fileType = getHumanReadableFileType(newImages[i].type);
    }

    onImageChange(newImages);
  };

  const handleFileDelete = (file) => {
    onFileDelete(file);
  };

  const handleImageDelete = (image) => {
    onImageDelete(image);
  };

  function a11yProps(tab) {
    return {
      id: `upload-tab-${tab}`,
      "aria-controls": `uploads-tabpanel-${tab}`,
    };
  }

  return (
    <Box>
      <Tabs
        value={selectedUploadTab}
        onChange={handleChangeUploadTab}
        aria-label="basic tabs example"
      >
        <Tab
          label={`Course Documents (${files.length})`}
          value={"files"}
          {...a11yProps("files")}
        />
        <Tab
          label={`Course Images (${images.length})`}
          value={"images"}
          {...a11yProps("images")}
        />
      </Tabs>
      <Box
        role="tabpanel"
        hidden={selectedUploadTab !== "files"}
        id="uploads-tabpanel-files"
        aria-labelledby="upload-tab-files"
        key="upload-tab-files"
        sx={{ py: 2, flexGrow: 1 }}
      >
        <Box sx={{ mb: 2 }}>
          <FileDropzone
            onFileChange={handleFileChange}
            onFilesRejected={setRejectedFiles}
          />
        </Box>
        <Grid container direction="column" gap={2}>
          {rejectedFiles.map((file, index) => (
            <RejectedFileAttachment
              key={`rejected-file-${index}`}
              file={file}
            />
          ))}
          {files.map((file, index) => (
            <FileAttachment
              key={`file-attachment-${index}`}
              file={file}
              onDelete={handleFileDelete}
            />
          ))}
        </Grid>
      </Box>
      <Box
        role="tabpanel"
        hidden={selectedUploadTab !== "images"}
        id="uploads-tabpanel-images"
        aria-labelledby="upload-tab-images"
        key="upload-tab-images"
        sx={{ py: 2, flexGrow: 1 }}
      >
        <Box sx={{ mb: 2 }}>
          <ImageDropzone onImageChange={handleImageChange} />
        </Box>
        <Grid container direction="column" gap={2}>
          {images.map((image, index) => (
            <ImageAttachment
              key={`image-attachment-${index}`}
              image={image}
              onDelete={handleImageDelete}
            />
          ))}
        </Grid>
      </Box>
    </Box>
  );
};

export default ContentUploadTabs;
