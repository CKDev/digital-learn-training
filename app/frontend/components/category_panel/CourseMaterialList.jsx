import React from "react";
import CourseWidget from "../CourseWidget";
import { Box, Grid2, Typography } from "@mui/material";

const CourseMaterialList = ({ courseMaterials }) => {
  const groupedMaterials = Object.groupBy(
    courseMaterials,
    ({ subCategory }) => subCategory
  );

  return (
    <Box sx={{ pt: 3 }}>
      <Grid2
        container
        spacing={4}
        display="flex"
        direction="column"
        justifyContent="space-between"
      >
        {Object.keys(groupedMaterials).map((subCategory, index) => {
          return (
            <Box key={"sub-category-" + index}>
              <Grid2
                container
                spacing={2}
                display="flex"
                direction="column"
                justifyContent="space-between"
              >
                {subCategory !== "null" && (
                  <Typography>{subCategory}</Typography>
                )}
                {groupedMaterials[subCategory].map((material) => (
                  <CourseWidget
                    {...material}
                    key={"course-widget-" + material.id}
                  />
                ))}
              </Grid2>
            </Box>
          );
        })}
      </Grid2>
    </Box>
  );
};

export default CourseMaterialList;
