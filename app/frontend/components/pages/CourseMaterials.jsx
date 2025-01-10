import React, { useState } from "react";

import { Box, Tab, Tabs, Typography } from "@mui/material";
import CategoryPanelContainer from "../category_panel/CategoryPanelContainer";

const NoMaterialsWidget = ({}) => (
  <Box
    sx={{
      flexGrow: 1,
      bgcolor: "background.paper",
      display: "flex",
      height: "100%",
    }}
  >
    <Typography variant="h6">
      No Course Materials available at this time
    </Typography>
  </Box>
);

const CourseMaterials = ({
  categories,
  initialCategoryFriendlyId,
  initialLanguage,
}) => {
  if (categories.length == 0) {
    return <NoMaterialsWidget />;
  } else {
    const [selectedCategoryFriendlyId, setSelectedCategoryFriendlyId] =
      useState(initialCategoryFriendlyId || categories[0].friendlyId);
    const [selectedLanguage, setSelectedLanguage] = useState(
      initialLanguage || "en"
    );

    const updateWindowSearchParams = (key, value) => {
      var searchParams = new URLSearchParams(window.location.search);

      searchParams.set(key, value); // Add or update a parameter
      const newUrl = `${window.location.pathname}?${searchParams.toString()}`;
      history.replaceState(null, "", newUrl);
    };

    const handleChangeCategory = (_event, selectedCategoryFriendlyId) => {
      updateWindowSearchParams("category", selectedCategoryFriendlyId);
      setSelectedCategoryFriendlyId(selectedCategoryFriendlyId);
    };

    const handleChangeLanguage = (selectedLanguage) => {
      updateWindowSearchParams("language", selectedLanguage);
      setSelectedLanguage(selectedLanguage);
    };

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
          gap: "24px",
          height: "100%",
        }}
      >
        <Tabs
          orientation="vertical"
          variant="scrollable"
          value={selectedCategoryFriendlyId}
          onChange={handleChangeCategory}
          aria-label="Course Material Category Tabs"
          sx={{
            borderRight: 1,
            borderColor: "divider",
            flexBasis: "33%",
            maxWidth: "271px",
          }}
        >
          {categories.map((category) => (
            <Tab
              label={category.title}
              value={category.friendlyId}
              {...a11yProps(category.friendlyId)}
              key={"category-tab-" + category.friendlyId}
            />
          ))}
        </Tabs>
        {categories.map((category) => (
          <Box
            role="tabpanel"
            hidden={selectedCategoryFriendlyId !== category.friendlyId}
            id={`category-tabpanel-${category.friendlyId}`}
            aria-labelledby={`category-tab-${category.friendlyId}`}
            key={`category-tab-${category.friendlyId}`}
            sx={{ flexBasis: "66%" }}
          >
            {selectedCategoryFriendlyId === category.friendlyId && (
              <CategoryPanelContainer
                category={category}
                selectedLanguage={selectedLanguage}
                panelIndex={category.friendlyId}
                onLanguageChange={handleChangeLanguage}
                key={"category-tab-content-" + category.friendlyId}
              />
            )}
          </Box>
        ))}
      </Box>
    );
  }
};

export default CourseMaterials;
