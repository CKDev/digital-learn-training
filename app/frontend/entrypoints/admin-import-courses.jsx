import React from "react";

import ImportCourses from "../components/admin/pages/ImportCourses";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".admin-import-courses");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <ImportCourses {...props} />
    </ThemedComponent>
  );
}
