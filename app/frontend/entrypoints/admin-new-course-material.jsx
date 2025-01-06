import React from "react";

import NewCourseMaterial from "../components/admin/pages/NewCourseMaterial";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".admin-new-course-material");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <NewCourseMaterial {...props} />
    </ThemedComponent>
  );
}
