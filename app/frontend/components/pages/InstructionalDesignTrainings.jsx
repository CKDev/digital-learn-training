import { Box, Grid2, Typography } from "@mui/material";
import React from "react";
import CourseWidget from "../CourseWidget";

const InstructionalDesignTrainings = ({ courses }) => {
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
        {courses.map((course) => (
          <CourseWidget
            key={`course-widget=${course.id}`}
            title={course.title}
            descripton={course.description}
            courseMaterialUrl={course.courseUrl}
            fileCount={0}
            imageCount={0}
            videoCount={0}
          />
        ))}
      </Grid2>
    </Box>
  );
};

export default InstructionalDesignTrainings;
