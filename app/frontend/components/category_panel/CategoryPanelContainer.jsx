import React from "react";
import { Box, Tabs, Tab, Typography } from "@mui/material";
import CourseMaterialList from "./CourseMaterialList";

const CategoryPanelContainer = ({
  category,
  selectedLanguage,
  onLanguageChange,
}) => {
  const handleChangeLanguage = (_event, selectedLanguage) => {
    onLanguageChange(selectedLanguage);
  };

  const languageNames = {
    en: "English",
    es: "Spanish",
  };

  const languageGroupedMaterials = Object.groupBy(
    category.courseMaterials,
    ({ language }) => language
  );

  function a11yProps(language) {
    return {
      id: `language-tab-${language}`,
      "aria-controls": `language-tabpanel-${language}`,
    };
  }

  return (
    <Box sx={{ px: 3 }}>
      <Typography sx={{ mb: 2 }}>{category.description}</Typography>
      <Tabs
        value={selectedLanguage}
        onChange={handleChangeLanguage}
        aria-label="Course Language Tabs"
      >
        <Tab label="English" value={"en"} elevation={0} {...a11yProps("en")} />
        <Tab label="Spanish" value={"es"} elevation={0} {...a11yProps("es")} />
      </Tabs>
      {["en", "es"].map((language) => (
        <div
          role="tabpanel"
          hidden={selectedLanguage !== language}
          id={`language-tabpanel-${language}`}
          aria-labelledby={`language-tab-${language}`}
          key={`language-tab-${language}`}
        >
          {languageGroupedMaterials[language] == undefined ? (
            <Box sx={{ pt: 3 }}>
              No {languageNames[language]} materials for this category
            </Box>
          ) : (
            <CourseMaterialList
              courseMaterials={languageGroupedMaterials[language]}
            />
          )}
        </div>
      ))}
    </Box>
  );
};

export default CategoryPanelContainer;
