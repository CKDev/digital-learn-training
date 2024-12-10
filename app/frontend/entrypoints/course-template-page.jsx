import React from "react";

import CourseTemplate from "../components/pages/CourseTemplate";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".course-template-page");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <CourseTemplate {...props} />
    </ThemedComponent>
  );
}
