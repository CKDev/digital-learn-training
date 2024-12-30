import { Box, Grid2, Typography } from "@mui/material";
import React from "react";
import CourseWidget from "../CourseWidget";

const CourseTemplate = ({ courseTemplateCourse }) => {
  return (
    <Box>
      <Grid2
        container
        spacing={4}
        display="flex"
        direction="column"
        justifyContent="space-between"
      >
        <Typography variant="h6">Instructional Design Training</Typography>
        <CourseWidget {...courseTemplateCourse} />
      </Grid2>
    </Box>
  );
};

export default CourseTemplate;
