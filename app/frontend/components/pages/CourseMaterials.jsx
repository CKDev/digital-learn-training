import React from "react";

import { Box, Tab, Tabs } from "@mui/material";
import CategoryPanelContainer from "../category_panel/CategoryPanelContainer";

const CourseMaterials = ({ categories }) => {
  const [selectedCategoryId, setSelectedCategoryId] = React.useState(
    categories[0].id
  );

  const handleChangeCategory = (_event, selectedCategoryId) =>
    setSelectedCategoryId(selectedCategoryId);

  function a11yProps(index) {
    return {
      id: `category-tab-${index}`,
      "aria-controls": `category-tabpanel-${index}`,
    };
  }

  return (
    <Box
      sx={{
        flexGrow: 1,
        bgcolor: "background.paper",
        display: "flex",
        height: "100%",
      }}
    >
      <Tabs
        orientation="vertical"
        variant="scrollable"
        value={selectedCategoryId}
        onChange={handleChangeCategory}
        aria-label="Course Material Category Tabs"
        sx={{ borderRight: 1, borderColor: "divider" }}
      >
        {categories.map((category) => (
          <Tab
            label={category.title}
            value={category.id}
            {...a11yProps(category.id)}
            key={"category-tab-" + category.id}
          />
        ))}
      </Tabs>
      {categories.map((category) => (
        <div
          role="tabpanel"
          hidden={selectedCategoryId !== category.id}
          id={`category-tabpanel-${category.id}`}
          aria-labelledby={`category-tab-${category.id}`}
          key={`category-tab-${category.id}`}
        >
          {selectedCategoryId === category.id && (
            <CategoryPanelContainer
              category={category}
              selectedCategoryId={selectedCategoryId}
              panelIndex={category.id}
              key={"category-tab-content-" + category.id}
            />
          )}
        </div>
      ))}
    </Box>
  );
};

export default CourseMaterials;
