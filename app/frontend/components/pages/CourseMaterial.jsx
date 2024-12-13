import { Grid2 } from "@mui/material";
import React from "react";
import ReturnToCategoryLink from "../course_material/ReturnToCategoryLink";
import CourseHeader from "../course_material/CourseHeader";

const CourseMaterial = ({
  category,
  categoryId,
  files,
  images,
  videos,
  ...courseMaterialProps
}) => (
  <Grid2>
    <ReturnToCategoryLink category={category} categoryId={categoryId} />
    <CourseHeader {...courseMaterialProps} />
    {/* <CourseDocuments files={files} />
    <CourseImages images={images} />
    <CourseVideos videos={videos} /> */}
  </Grid2>
);

export default CourseMaterial;
