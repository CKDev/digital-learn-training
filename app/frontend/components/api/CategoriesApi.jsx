import { sendRequest } from "./Api";

export async function updateCategory(categoryId, categoryParams) {
  let path = `/admin/categories/${categoryId}`;

  // Convert categories list into sub_categories_attributes
  categoryParams.sub_categories_attributes = categoryParams.subcategories.map(
    (category) => {
      return { title: category };
    }
  );

  delete categoryParams.subcategories; // remove unrecognized subcategories key

  let body = JSON.stringify(categoryParams);
  let response = await sendRequest(path, "PUT", body);
  return response;
}

export async function createCategory(categoryParams) {
  let path = "/admin/categories";

  // Convert categories list into sub_categories_attributes
  categoryParams.sub_categories_attributes = categoryParams.subcategories.map(
    (category) => {
      return { title: category };
    }
  );

  delete categoryParams.subcategories; // remove unrecognized subcategories key

  let body = JSON.stringify(categoryParams);
  let response = await sendRequest(path, "POST", body);
  return response;
}
