import { Grid2, Button } from "@mui/material";
import React from "react";
import CourseHeader from "../course_material/CourseHeader";
import CourseDocuments from "../course_material/CourseDocuments";
import LessonList from "../course/LessonList";
import ArrowBackRoundedIcon from "@mui/icons-material/ArrowBackRounded";

const CourseOverview = ({
  lessons,
  supplementalAttachments,
  postCourseAttachments,
  ...courseProps
}) => (
  <Grid2>
    <Button
      variant="text"
      startIcon={<ArrowBackRoundedIcon />}
      href={`/trainings`}
    >
      Back to Instructional Design Training
    </Button>
    <CourseHeader {...courseProps} />
    <LessonList lessons={lessons} />
    <CourseDocuments
      title="Text Copies of Course"
      files={supplementalAttachments}
    />
    <CourseDocuments
      title="Additional Resources"
      files={postCourseAttachments}
    />
  </Grid2>
);

export default CourseOverview;
