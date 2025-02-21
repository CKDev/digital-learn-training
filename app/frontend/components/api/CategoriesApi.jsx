import { sendRequest } from "./Api";

export async function updateCategory(
  categoryId,
  categoryParams,
  subcategoryIdsToDelete
) {
  let path = `/admin/categories/${categoryId}`;

  // Convert subcategory data into sub_categories_attributes
  // Add new subcategories
  let newSubcategoryData = categoryParams.subcategories.map((subcategory) => {
    if (subcategory.id == 0) {
      // Only add new subcategories (id defaulted to 0)
      return { title: subcategory.title };
    }
  });

  // Delete deleted subcategories
  let subcategoriesToDelete = subcategoryIdsToDelete.map((id) => {
    return { id: id, _destroy: true };
  });

  categoryParams.sub_categories_attributes = [
    ...newSubcategoryData,
    ...subcategoriesToDelete,
  ];

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
