import React from "react";
import { Box, Typography, Tabs, Tab } from "@mui/material";
import CourseMaterialList from "./CourseMaterialList";

const CategoryPanelContainer = ({ category, ...other }) => {
  const [selectedLanguage, setSelectedLanguage] = React.useState("en"); // TODO: Use site selected language?

  const handleChangeLanguage = (_event, selectedLanguage) =>
    setSelectedLanguage(selectedLanguage);

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
    <Box sx={{ p: 3 }}>
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
