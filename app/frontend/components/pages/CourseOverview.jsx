import { Grid2 } from "@mui/material";
import React from "react";
import CourseHeader from "../course_material/CourseHeader";
import CourseDocuments from "../course_material/CourseDocuments";
import LessonList from "../course/LessonList";

const CourseOverview = ({
  lessons,
  supplementalAttachments,
  postCourseAttachments,
  ...courseProps
}) => (
  <Grid2>
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
