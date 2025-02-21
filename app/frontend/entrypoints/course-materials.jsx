import React from "react";

import CourseMaterials from "../components/pages/CourseMaterials";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector("#course-materials");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <CourseMaterials {...props} />
    </ThemedComponent>
  );
}
