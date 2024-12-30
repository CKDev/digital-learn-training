import { Grid2 } from "@mui/material";
import React from "react";
import ReturnToCategoryLink from "../course_material/ReturnToCategoryLink";
import CourseHeader from "../course_material/CourseHeader";
import CourseDocuments from "../course_material/CourseDocuments";
import CourseImages from "../course_material/CourseImages";

const CourseMaterial = ({
  category,
  categoryId,
  files,
  images,
  videos,
  language,
  ...courseMaterialProps
}) => (
  <Grid2>
    <ReturnToCategoryLink
      category={category}
      categoryId={categoryId}
      language={language}
    />
    <CourseHeader {...courseMaterialProps} />
    <CourseDocuments files={files} />
    <CourseImages images={images} />
  </Grid2>
);

export default CourseMaterial;
