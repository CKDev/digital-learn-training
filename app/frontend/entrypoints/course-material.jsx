import React from "react";

import CourseMaterial from "../components/pages/CourseMaterial";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector("#course-material");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <CourseMaterial {...props} />
    </ThemedComponent>
  );
}
