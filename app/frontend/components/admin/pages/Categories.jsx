import React, { useState } from "react";

import {
  Button,
  Grid2 as Grid,
  List,
  ListItem,
  ListItemButton,
  ListItemText,
} from "@mui/material";
import AddRoundedIcon from "@mui/icons-material/AddRounded";
import CategoryForm from "../categories/CategoryForm";

const Categories = ({ categories }) => {
  const [selectedCategory, setSelectedCategory] = useState(categories[0]);

  const handleCategorySelect = (category) => {
    setSelectedCategory(category);
  };

  return (
    <Grid container columnSpacing={2}>
      <Grid size={6}>
        <Button
          variant="outlined"
          startIcon={<AddRoundedIcon />}
          disableElevation
        >
          Add New Category
        </Button>
        <List>
          {categories.map((category, index) => (
            <ListItem key={index} disablePadding>
              <ListItemButton
                selected={selectedCategory.id === category.id}
                onClick={() => handleCategorySelect(category)}
              >
                <ListItemText primary={category.title} />
              </ListItemButton>
            </ListItem>
          ))}
        </List>
      </Grid>
      <Grid size={6}>
        <CategoryForm category={selectedCategory} key={selectedCategory.id} />
      </Grid>
    </Grid>
  );
};

export default Categories;
