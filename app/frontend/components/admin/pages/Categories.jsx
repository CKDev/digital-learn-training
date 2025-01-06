import React, { useState } from "react";

import {
  Button,
  Grid2 as Grid,
  List,
  ListItem,
  ListItemButton,
  Typography,
} from "@mui/material";
import AddRoundedIcon from "@mui/icons-material/AddRounded";
import CategoryForm from "../categories/CategoryForm";

const Categories = ({ categories, categoryTags }) => {
  const [selectedCategory, setSelectedCategory] = useState(categories[0]);
  const [categoriesList, setCategoriesList] = useState(categories);

  const handleCategorySelect = (category) => {
    setSelectedCategory(category);
  };

  const handleAddCategory = () => {
    let newCategory = {
      title: "New Category",
      description: "",
      subcategories: [],
      tag: "Getting Started",
      id: -categoriesList.length,
    }; // Use non-conflicting ID that supports multiple new categories
    setCategoriesList([...categoriesList, newCategory]);

    setSelectedCategory(newCategory);
  };

  const handleRemoveNewCategory = (idToRemove) => {
    let newCategoriesList = categoriesList.filter(
      (category) => category.id !== idToRemove
    );
    setSelectedCategory(categories[0]);
    setCategoriesList(newCategoriesList);
  };

  return (
    <Grid container columnSpacing={2}>
      <Grid size={6}>
        <Button
          variant="outlined"
          startIcon={<AddRoundedIcon />}
          onClick={handleAddCategory}
          disableElevation
        >
          Add New Category
        </Button>
        <List>
          {categoriesList.map((category, index) => (
            <ListItem key={index} disablePadding>
              <ListItemButton
                selected={selectedCategory.id === category.id}
                onClick={() => handleCategorySelect(category)}
              >
                <Typography variant="body1">{category.title}</Typography>
              </ListItemButton>
            </ListItem>
          ))}
        </List>
      </Grid>
      <Grid size={6} sx={{ py: 2 }}>
        <CategoryForm
          category={selectedCategory}
          categoryTags={categoryTags}
          key={selectedCategory.id}
          isNewCategory={selectedCategory.id < 0}
          onRemoveNewCategory={handleRemoveNewCategory}
        />
      </Grid>
    </Grid>
  );
};

export default Categories;
