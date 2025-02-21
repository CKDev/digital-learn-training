import React from "react";

import Categories from "../components/admin/pages/Categories";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".admin-categories");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <Categories {...props} />
    </ThemedComponent>
  );
}
