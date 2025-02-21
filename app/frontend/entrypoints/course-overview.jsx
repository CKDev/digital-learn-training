import React from "react";

import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";
import CourseOverview from "../components/pages/CourseOverview";

const container = document.querySelector(".course-overview");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <CourseOverview {...props} />
    </ThemedComponent>
  );
}
