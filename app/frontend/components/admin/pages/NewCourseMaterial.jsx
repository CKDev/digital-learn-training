import React from "react";
import CourseMaterialForm from "../course_materials/CourseMaterialForm";
import { createCourseMaterial } from "@api/CourseMaterialsApi";

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

  return (
    <CourseMaterialForm
      initialData={initialFormData}
      categories={categories}
      onSubmit={handleSubmit}
    />
  );
};

export default NewCourseMaterial;
