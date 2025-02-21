import React from "react";
import CourseMaterialForm from "../course_materials/CourseMaterialForm";
import { updateCourseMaterial } from "@api/CourseMaterialsApi";
import { Box, Breadcrumbs, Link, Paper, Typography } from "@mui/material";

const EditCourseMaterial = ({ courseMaterial, categories }) => {
  const initialFormData = {
    title: courseMaterial.title,
    summary: courseMaterial.summary,
    description: courseMaterial.description,
    contributor: courseMaterial.contributor,
    status: courseMaterial.status,
    categoryId: courseMaterial.categoryId,
    subcategoryId: courseMaterial.subcategoryId,
    language: courseMaterial.language,
    files: courseMaterial.files,
    images: courseMaterial.images,
  };

  const handleSubmit = async (formData) => {
    let response = await updateCourseMaterial(courseMaterial.id, formData);

    if (response.success) {
      // Set flash message
      localStorage.setItem("flash_message", response.data.message);

      // Reload page to pick up changes
      window.location.reload();
    } else {
      console.error("Error submitting form:", response);
      throw new Error(response.message);
    }
  };

  const breadcrumbs = [
    <Link underline="hover" key="1" color="inherit" href="/admin/courses">
      All Courses
    </Link>,
    <Typography key="2">{courseMaterial.title}</Typography>,
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

export default EditCourseMaterial;
