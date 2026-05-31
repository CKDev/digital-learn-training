import { sendRequest } from "./Api";

export async function updateOrganizationSettings(data) {
  return await sendRequest("/admin/organization_settings", "PATCH", data, {});
}
