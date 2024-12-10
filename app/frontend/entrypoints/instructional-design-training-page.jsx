import React from "react";

import InstructionalDesignTraining from "../components/pages/InstructionalDesignTraining";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".instructional-design-training-page");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <InstructionalDesignTraining {...props} />
    </ThemedComponent>
  );
}
