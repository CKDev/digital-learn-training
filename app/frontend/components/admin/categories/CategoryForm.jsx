import React, { useState, useEffect } from "react";

import {
  Alert,
  Box,
  Button,
  FormControl,
  Grid2 as Grid,
  IconButton,
  InputAdornment,
  InputLabel,
  List,
  ListItem,
  MenuItem,
  Select,
  TextField,
  Typography,
} from "@mui/material";
import DeleteRoundedIcon from "@mui/icons-material/DeleteRounded";
import AddRoundedIcon from "@mui/icons-material/AddRounded";
import { createCategory, updateCategory } from "../../api/CategoriesApi";

// Placeholder for the CategoryForm component
const CategoryForm = ({
  category,
  categoryTags,
  isNewCategory,
  onRemoveNewCategory,
}) => {
  const initialFormData = {
    title: category.title,
    description: category.description,
    tag: category.tag,
    subcategories: category.subcategories,
  };

  const [formData, setFormData] = useState(initialFormData);
  const [isDirty, setIsDirty] = useState(false);
  const [errors, setErrors] = useState({
    submitError: "",
    subcategories: "",
  });

  // Handle form change
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  // Check if the form has changed
  useEffect(() => {
    setIsDirty(JSON.stringify(formData) !== JSON.stringify(initialFormData));

    if (errors.subcategories !== "") {
      // Re-validate subcategories
      validateSubcategories();
    }
  }, [formData]);

  const handleAddSubcategory = () => {
    let updatedSubcategories = [...formData.subcategories, "New Subcategory"];
    setFormData((prev) => ({
      ...prev,
      ["subcategories"]: updatedSubcategories,
    }));
  };

  const handleSubcategoryNameChange = (index, newName) => {
    let updatedSubcategories = [...formData.subcategories];
    updatedSubcategories[index] = newName;
    setFormData((prev) => ({
      ...prev,
      ["subcategories"]: updatedSubcategories,
    }));
  };

  const handleRemoveSubcategory = (index) => {
    const updatedSubcategories = formData.subcategories.filter(
      (_, i) => i !== index
    );
    setFormData((prev) => ({
      ...prev,
      ["subcategories"]: updatedSubcategories,
    }));
  };

  const validateSubcategories = () => {
    let subcategories = formData.subcategories.filter(
      (subcat) => subcat.replace(/ /g, "") !== ""
    );

    // Remove empty categories from list
    setFormData((prev) => ({
      ...prev,
      ["subcategories"]: subcategories,
    }));

    let uniqueSubcategories = [...new Set(subcategories)];

    if (subcategories.length != uniqueSubcategories.length) {
      setErrors({ subcategories: "Subcategories must be unique values" });
    } else {
      setErrors({ subcategories: "" });
      return true;
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    setErrors(); // Clear errors

    const form = e.target;

    if (form.checkValidity() && validateSubcategories()) {
      let result;

      if (isNewCategory) {
        result = await createCategory(formData);
      } else {
        result = await updateCategory(category.id, formData);
      }

      if (result.success) {
        // Set flash message
        localStorage.setItem("flash_message", result.data.message);

        // Reload categories page to pick up changes
        window.location.reload();
      } else {
        setErrors({ submitError: result.message });
      }
    }
  };

  const handleCancel = () => {
    if (isNewCategory) {
      console.log("removing new category");
      onRemoveNewCategory(category.id);
    } else {
      setFormData(initialFormData);
    }
  };

  return (
    <Box component="form" onSubmit={handleSubmit} autoComplete="off">
      {errors.submitError && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {errors.submitError}
        </Alert>
      )}
      <Grid container direction="column" spacing={2}>
        <TextField
          id="category-title"
          label="Title"
          name="title"
          variant="outlined"
          key={`${category.id}-title`}
          fullWidth
          value={formData.title}
          onChange={handleInputChange}
          required
        />
        <TextField
          id="category-description"
          label="Description"
          variant="outlined"
          name="description"
          key={`${category.id}-description`}
          fullWidth
          multiline
          value={formData.description}
          onChange={handleInputChange}
        />
        <FormControl fullWidth>
          <InputLabel id="category-tag-label">Tag</InputLabel>
          <Select
            id="category-tag"
            label="Tag"
            name="tag"
            variant="outlined"
            key={`${category.id}-tag`}
            value={formData.tag}
            onChange={handleInputChange}
          >
            {categoryTags.map((tag) => (
              <MenuItem value={tag} key={tag}>
                {tag}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
        <Typography variant="h6">Subcategories</Typography>
        <List>
          {formData.subcategories.map((subcategory, index) => (
            <ListItem key={index} disablePadding sx={{ pb: 2 }}>
              <Box sx={{ flexGrow: 1, display: "flex", alignItems: "center" }}>
                <TextField
                  value={subcategory}
                  onChange={(e) =>
                    handleSubcategoryNameChange(index, e.target.value)
                  }
                  variant="outlined"
                  size="small"
                  fullWidth
                  error={!!errors.subcategories}
                  helperText={errors.subcategories}
                  InputProps={{
                    endAdornment: (
                      <InputAdornment position="end">
                        <IconButton
                          edge="end"
                          aria-label="delete"
                          onClick={(e) => handleRemoveSubcategory(index)}
                        >
                          <DeleteRoundedIcon />
                        </IconButton>
                      </InputAdornment>
                    ),
                  }}
                />
              </Box>
            </ListItem>
          ))}
        </List>
        <Grid container justifyContent="flex-end">
          <Button
            size="small"
            variant="outlined"
            startIcon={<AddRoundedIcon />}
            disableElevation
            onClick={handleAddSubcategory}
          >
            Add New Subcategory
          </Button>
        </Grid>
        <Grid container justifyContent="flex-start" sx={{ py: 2 }}>
          <Button
            type="submit"
            variant="contained"
            disabled={!(isNewCategory || isDirty)}
          >
            Save Category
          </Button>
          {isNewCategory ||
            (isDirty && (
              <Button variant="text" onClick={handleCancel}>
                Cancel
              </Button>
            ))}
        </Grid>
      </Grid>
    </Box>
  );
};

export default CategoryForm;
