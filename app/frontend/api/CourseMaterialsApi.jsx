import { sendRequest } from "./Api";

export async function updateCourseMaterial(courseMaterialId, data) {
  let path = `/admin/courses/${courseMaterialId}`;

  let body = data;
  let response = await sendRequest(path, "PUT", body, {});
  return response;
}
