import { Box, Grid2 as Grid, Link, Typography } from "@mui/material";
import React from "react";
import LessonList from "../course/LessonList";
import CourseDocuments from "../course_material/CourseDocuments";

const Lesson = ({ course, lesson }) => (
  <Grid container direction="column" spacing={2}>
    <Grid container direction="row" spacing={1}>
      <Link href={"/trainings"}>Instructional Design Training</Link>
      <Typography variant="body1">{">"}</Typography>
      <Link href={lesson.coursePath}>{lesson.courseTitle}</Link>
      <Typography variant="body1">{">"}</Typography>
      <Link href={lesson.lessonPath}>{lesson.title}</Link>
    </Grid>
    <Box
      sx={{
        position: "relative",
        width: "100%",
        paddingTop: `${(716 / 1024) * 100}%`,
      }}
    >
      <iframe
        src={lesson.storylineUrl}
        title={lesson.summary}
        style={{
          position: "absolute",
          top: 0,
          left: 0,
          width: "100%",
          height: "100%",
          border: "none",
        }}
      ></iframe>
    </Box>
    <Grid container direction="row" spacing={2}>
      <Grid size={6}>
        <LessonList lessons={course.lessons} currentLessonId={lesson.id} />
      </Grid>
      <Grid size={6}>
        <CourseDocuments
          title="Text Copies of Course"
          files={course.supplementalAttachments}
        />
      </Grid>
    </Grid>
  </Grid>
);

export default Lesson;
