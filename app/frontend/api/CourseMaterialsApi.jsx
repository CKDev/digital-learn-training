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
  let path = `/admin/courses`;

  let body = data;
  let response = await sendRequest(path, "POST", body, {});
  return response;
}
