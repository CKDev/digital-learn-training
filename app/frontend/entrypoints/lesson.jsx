import React from "react";

import Lesson from "../components/pages/Lesson";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".lesson");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <Lesson {...props} />
    </ThemedComponent>
  );
}
