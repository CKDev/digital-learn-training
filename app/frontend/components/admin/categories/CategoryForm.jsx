import React, { useState } from "react";

import {
  Box,
  Button,
  FormControl,
  Grid2 as Grid,
  IconButton,
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

// Placeholder for the CategoryForm component
const CategoryForm = ({ category }) => {
  const originalTitle = category.title;
  const originalDescription = category.description;
  const originalTag = category.tag;
  const originalSubcategories = category.subcategories;
  const [title, setTitle] = useState(category.title);
  const [description, setDescription] = useState(category.description);
  const [tag, setTag] = useState(category.tag);
  const [subcategories, setSubcategories] = useState(category.subcategories);

  const handleAddSubcategory = () => {
    setSubcategories([...subcategories, "New Subcategory"]);
  };

  const handleSubcategoryNameChange = (index, newName) => {
    const updatedSubcategories = [...subcategories];
    updatedSubcategories[index] = newName;
    setSubcategories(updatedSubcategories);
  };

  const handleRemoveSubcategory = (index) => {
    const updatedSubcategories = subcategories.filter((_, i) => i !== index);
    setSubcategories(updatedSubcategories);
  };

  return (
    <Box component="form" autoComplete="off">
      <Grid container direction="column" spacing={2}>
        <TextField
          id="category-title"
          label="Title"
          variant="outlined"
          key={`${category.id}-title`}
          fullWidth
          value={title}
          onChange={(event) => {
            setTitle(event.target.value);
          }}
        />
        <TextField
          id="category-description"
          label="Description"
          variant="outlined"
          key={`${category.id}-description`}
          fullWidth
          multiline
          value={description}
          onChange={(event) => setDescription(event.target.value)}
        />
        <FormControl fullWidth>
          <InputLabel id="category-tag-label">Tag</InputLabel>
          <Select
            id="category-tag"
            label="Tag"
            variant="outlined"
            key={`${category.id}-tag`}
            value={tag}
            onChange={(event) => setTag(event.target.value)}
          >
            {category.availableTags.map((tag) => (
              <MenuItem value={tag} key={tag}>
                {tag}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
        <Typography variant="h6">Subcategories</Typography>
        <List>
          {subcategories.map((subcategory, index) => (
            <ListItem
              key={index}
              disablePadding
              secondaryAction={
                <IconButton
                  edge="end"
                  aria-label="delete"
                  disableElevation
                  onClick={(e) => handleRemoveSubcategory(index)}
                >
                  <DeleteRoundedIcon />
                </IconButton>
              }
            >
              <TextField
                value={subcategory}
                onChange={(e) =>
                  handleSubcategoryNameChange(index, e.target.value)
                }
                variant="outlined"
                size="small"
                fullWidth
              />
            </ListItem>
          ))}
        </List>
        <Grid container justifyContent="flex-end">
          <Button
            size="small"
            variant="outlined"
            startIcon={<AddRoundedIcon />}
            disableElevation
            sx={{ my: 2 }}
            onClick={handleAddSubcategory}
          >
            Add New Subcategory
          </Button>
        </Grid>
      </Grid>
    </Box>
  );
};

export default CategoryForm;
