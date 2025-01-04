import React, { useState, useRef } from "react";

import {
  Box,
  FormControl,
  Grid2 as Grid,
  InputLabel,
  MenuItem,
  Select,
  TextField,
  Typography,
} from "@mui/material";
import { STATUS_MAP } from "./CourseMaterials";

const EditCourseMaterial = ({ courseMaterial, categories }) => {
  const tiptapRef = useRef(null);

  const initialFormData = {
    title: courseMaterial.title,
    summary: courseMaterial.summary,
    description: courseMaterial.description,
    contributor: courseMaterial.contributor,
    status: courseMaterial.status,
    categoryId: courseMaterial.categoryId,
    language: courseMaterial.language,
  };

  const [formData, setFormData] = useState(initialFormData);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = () => {
    let description = tiptapRef.current?.editor?.getHTML();
    console.log(description);
    console.log("Submitting Form");
  };

  return (
    <Box component="form" onSubmit={handleSubmit}>
      <Grid container direction="column" spacing={3}>
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
      </Grid>
    </Box>
  );
};

export default EditCourseMaterial;
