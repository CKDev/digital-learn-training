import React from "react";
import CourseMaterialForm from "../course_materials/CourseMaterialForm";
import { updateCourseMaterial } from "@api/CourseMaterialsApi";

const EditCourseMaterial = ({ courseMaterial, categories }) => {
  const initialFormData = {
    title: courseMaterial.title,
    summary: courseMaterial.summary,
    description: courseMaterial.description,
    contributor: courseMaterial.contributor,
    status: courseMaterial.status,
    categoryId: courseMaterial.categoryId,
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

  return (
    <CourseMaterialForm
      initialData={initialFormData}
      categories={categories}
      onSubmit={handleSubmit}
    />
  );
};

export default EditCourseMaterial;
