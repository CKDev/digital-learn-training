import React from "react";

import AdminSidebar from "../components/AdminSidebar";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".admin-sidebar");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <AdminSidebar {...props} />
    </ThemedComponent>
  );
}
