import React from "react";

import AdditionalResources from "../components/pages/AdditionalResources";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".additional-resources-page");
if (container) {
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <AdditionalResources />
    </ThemedComponent>
  );
}
