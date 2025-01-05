import React from "react";
import CourseMaterialForm from "../course_materials/CourseMaterialForm";
import { createCourseMaterial } from "@api/CourseMaterialsApi";
import { Box, Breadcrumbs, Link, Paper, Typography } from "@mui/material";

const NewCourseMaterial = ({ categories }) => {
  const initialFormData = {
    title: "",
    summary: "",
    contributor: "",
    status: "D",
    language: "en",
    categoryId: categories[0].id,
    files: [],
    images: [],
  };

  const handleSubmit = async (formData) => {
    let response = await createCourseMaterial(formData);

    if (response.success) {
      // Set flash message
      localStorage.setItem("flash_message", response.data.message);

      // Load edit page for new course
      console.log(response.data);
      let newCourseId = response.data["course_material_id"];
      if (!!newCourseId) {
        window.location = `/admin/courses/${newCourseId}/edit`;
      } else {
        window.location = "/admin/courses";
      }
    } else {
      console.error("Error submitting form:", response);
      throw new Error(response.message);
    }
  };

  const breadcrumbs = [
    <Link underline="hover" key="1" color="inherit" href="/admin/courses">
      All Courses
    </Link>,
    <Typography key="2">New Course</Typography>,
  ];

  return (
    <Box>
      <Paper elevation={0} sx={{ p: 1, bgcolor: "primary.light" }}>
        <Breadcrumbs separator="›" aria-label="breadcrumb">
          {breadcrumbs}
        </Breadcrumbs>
      </Paper>
      <CourseMaterialForm
        initialData={initialFormData}
        categories={categories}
        onSubmit={handleSubmit}
      />
    </Box>
  );
};

export default NewCourseMaterial;
