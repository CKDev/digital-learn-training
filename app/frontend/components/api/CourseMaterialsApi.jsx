import { sendRequest } from "./Api";

export async function updateCourseMaterial(
  courseMaterialId,
  data,
  multipart = true
) {
  let path = `/admin/courses/${courseMaterialId}`;

  let body = data;
  let response;

  if (multipart) {
    response = await sendRequest(path, "PUT", body, {}); // Unset content-type header
  } else {
    response = await sendRequest(path, "PUT", body); // Use default API headers
  }
  return response;
}

export async function createCourseMaterial(data) {
  let path = "/admin/courses";

  let body = data;
  let response = await sendRequest(path, "POST", body, {});
  return response;
}

export async function importCourseMaterial(courseMaterialId) {
  let path = "/admin/course_material_imports";
  let body = JSON.stringify({ course_material_id: courseMaterialId });
  let response = await sendRequest(path, "POST", body);
  return response;
}

export async function unimportCourseMaterial(courseMaterialId) {
  let path = `/admin/course_material_imports/${courseMaterialId}`;
  let response = await sendRequest(path, "DELETE");
  return response;
}
