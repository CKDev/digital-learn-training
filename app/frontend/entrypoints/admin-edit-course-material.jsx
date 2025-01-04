import React from "react";

import EditCourseMaterial from "../components/admin/pages/EditCourseMaterial";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".admin-edit-course-material");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <EditCourseMaterial {...props} />
    </ThemedComponent>
  );
}
