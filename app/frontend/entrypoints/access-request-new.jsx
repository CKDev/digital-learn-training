import React from "react";

import AccessRequestNew from "../components/pages/AccessRequestNew";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".access-request-new");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <AccessRequestNew {...props} />
    </ThemedComponent>
  );
}
