import React, { useState, useEffect } from "react";

import {
  Alert,
  Box,
  Button,
  FormControl,
  Grid2 as Grid,
  InputLabel,
  MenuItem,
  Select,
  TextField,
  Typography,
} from "@mui/material";
import { STATUS_MAP } from "../pages/CourseMaterials";
import ContentUploadTabs from "./ContentUploadTabs";
import _ from "lodash";

const CourseMaterialForm = ({
  initialData,
  categories,
  onSubmit,
  isNew = false,
}) => {
  const [formData, setFormData] = useState(initialData);
  const [isDirty, setIsDirty] = useState(false);
  const [files, setFiles] = useState(initialData.files);
  const [images, setImages] = useState(initialData.images);
  const [filesToDelete, setFilesToDelete] = useState([]);
  const [imagesToDelete, setImagesToDelete] = useState([]);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState(null);

  // Check if the form has changed
  useEffect(() => {
    setIsDirty(JSON.stringify(formData) !== JSON.stringify(initialData));
  }, [formData]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleFileChange = (newFiles) => {
    setIsDirty(true);
    setFiles([...files, ...newFiles]);
  };

  const handleImageChange = (newImages) => {
    setIsDirty(true);
    setImages([...images, ...newImages]);
  };

  const handleFileDelete = (fileToDelete) => {
    setIsDirty(true);

    if (!(fileToDelete instanceof File)) {
      // Existing file that we need to tell the server to delete
      setFilesToDelete([...filesToDelete, fileToDelete]);
    }

    // Update displayed file list
    const newFiles = files.filter((file) => !_.isEqual(file, fileToDelete));
    setFiles(newFiles);
  };

  const handleImageDelete = (imageToDelete) => {
    setIsDirty(true);

    if (!(imageToDelete instanceof File)) {
      // Existing file that we need to tell the server to delete
      setImagesToDelete([...imagesToDelete, imageToDelete]);
    }

    // Update displayed file list
    const newImages = images.filter(
      (image) => !_.isEqual(image, imageToDelete)
    );
    setImages(newImages);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);

    const form = e.target;
    if (form.checkValidity()) {
      // Build form data
      const data = new FormData();

      ["title", "summary", "description", "contributor", "language"].forEach(
        (key) => data.append(`course_material[${key}]`, formData[key])
      );

      data.append("course_material[category_id]", formData.categoryId);
      data.append("course_material[pub_status]", formData.status);

      // Append course_material_files
      files.forEach((file, index) => {
        // Only use newly attached File objects
        if (file instanceof File) {
          data.append(
            `course_material[course_material_files_attributes][${index}][file]`,
            file,
            file.name
          );
        }
      });

      // Append files to destroy
      filesToDelete.forEach((file, index) => {
        const newIndex = files.length + index; // Start index after all added files
        data.append(
          `course_material[course_material_files_attributes][${newIndex}][id]`,
          file.id
        );
        data.append(
          `course_material[course_material_files_attributes][${newIndex}][_destroy]`,
          true
        );
      });

      // Append course_material_medias
      images.forEach((image, index) => {
        // Only use newly attached File objects
        if (image instanceof File) {
          data.append(
            `course_material[course_material_medias_attributes][${index}][media][]`,
            image,
            image.name
          );
        }
      });

      // Append images to destroy
      imagesToDelete.forEach((image, index) => {
        const newIndex = images.length + index; // Start index after all added images
        data.append(
          `course_material[course_material_medias_attributes][${newIndex}][id]`,
          image.id
        );
        data.append(
          `course_material[course_material_medias_attributes][${newIndex}][_destroy]`,
          true
        );
      });

      try {
        await onSubmit(data);
      } catch (error) {
        console.error("Error submitting form:", error);

        // Show error
        error = error.message;
        setError(error);
      } finally {
        setSubmitting(false);
      }
    }
  };

  const handleCancel = () => {
    if (isNew) {
      // Redirect to list view
      window.location = "/admin/courses";
    } else {
      setFormData(initialData);
      setFiles(initialData.files);
      setImages(initialData.images);
    }
  };

  return (
    <Box component="form" onSubmit={handleSubmit}>
      <Grid container direction="column" spacing={3}>
        {error && (
          <Alert severity="error" sx={{ mb: 2 }}>
            {error}
          </Alert>
        )}
        <Typography variant="h6">Course Information</Typography>
        <TextField
          label="Title"
          name="title"
          variant="outlined"
          fullWidth
          value={formData.title}
          onChange={handleInputChange}
          required
          helperText={`${formData.title.length} / 90 characters`}
          slotProps={{
            htmlInput: {
              maxLength: 90,
            },
          }}
        />
        <TextField
          label="Summary"
          name="summary"
          variant="outlined"
          fullWidth
          value={formData.summary}
          onChange={handleInputChange}
          required
          helperText={`${formData.summary.length} / 74 characters`}
          slotProps={{
            htmlInput: {
              maxLength: 74,
            },
          }}
        />
        <TextField
          label="Description"
          name="description"
          variant="outlined"
          fullWidth
          multiline
          value={formData.description}
          onChange={handleInputChange}
        />

        <Typography variant="h6">Details and Status</Typography>
        <TextField
          label="Contributors"
          name="contributor"
          variant="outlined"
          fullWidth
          required
          value={formData.contributor}
          onChange={handleInputChange}
          helperText={`${formData.contributor.length} / 156 characters`}
          slotProps={{
            htmlInput: {
              maxLength: 156,
            },
          }}
        />
        <FormControl fullWidth>
          <InputLabel id="course-material-status-label">Status</InputLabel>
          <Select
            label="Status"
            name="status"
            variant="outlined"
            value={formData.status}
            onChange={handleInputChange}
          >
            {Object.keys(STATUS_MAP).map((key) => (
              <MenuItem value={key} key={key}>
                {STATUS_MAP[key]}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
        <FormControl fullWidth>
          <InputLabel id="course-material-category-label">Category</InputLabel>
          <Select
            label="Category"
            name="category"
            variant="outlined"
            value={formData.categoryId}
            onChange={handleInputChange}
          >
            {categories.map((category) => (
              <MenuItem
                value={category.id}
                key={`category-option-${category.id}`}
              >
                {category.title}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
        <FormControl fullWidth>
          <InputLabel id="course-material-language-label">Language</InputLabel>
          <Select
            label="Language"
            name="language"
            variant="outlined"
            value={formData.language}
            onChange={handleInputChange}
          >
            <MenuItem value={"en"} key={`language-option-en`}>
              {"English"}
            </MenuItem>
            <MenuItem value={"es"} key={`language-option-es`}>
              {"Español"}
            </MenuItem>
          </Select>
        </FormControl>

        <Typography variant="h6">Attach Content</Typography>
        <ContentUploadTabs
          files={files}
          images={images}
          onFileChange={handleFileChange}
          onImageChange={handleImageChange}
          onFileDelete={handleFileDelete}
          onImageDelete={handleImageDelete}
        />

        <Grid container justifyContent="flex-start" sx={{ py: 2 }}>
          <Button
            type="submit"
            variant="contained"
            disabled={!(isNew || isDirty) || submitting}
          >
            {submitting ? "Saving..." : "Save Category"}
          </Button>
          {(isNew || isDirty) && (
            <Button variant="text" onClick={handleCancel}>
              Cancel
            </Button>
          )}
        </Grid>
      </Grid>
    </Box>
  );
};

export default CourseMaterialForm;
