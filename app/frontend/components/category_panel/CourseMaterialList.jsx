import React from "react";
import CourseWidget from "../CourseWidget";
import { Box, Grid2, Typography } from "@mui/material";
import _ from "lodash";

const CourseMaterialList = ({ courseMaterials }) => {
  const groupedMaterials = Object.groupBy(
    courseMaterials,
    ({ subcategory }) => subcategory
  );

  const nonSubcategoryMaterials = groupedMaterials[null];
  const subcategoryMaterials = _.pickBy(
    groupedMaterials,
    (_materials, subcategory) => {
      return subcategory !== "null";
    }
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
        {nonSubcategoryMaterials.map((material) => (
          <CourseWidget {...material} key={"course-widget-" + material.id} />
        ))}
        {Object.keys(subcategoryMaterials).map((subcategory, index) => {
          return (
            <Box key={"sub-category-" + index}>
              <Grid2
                container
                spacing={2}
                display="flex"
                direction="column"
                justifyContent="space-between"
              >
                <Typography>{subcategory}</Typography>
                {subcategoryMaterials[subcategory].map((material) => (
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
