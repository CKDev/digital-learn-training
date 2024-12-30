import React from "react";

import UserSidebar from "../components/UserSidebar";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".user-sidebar");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <UserSidebar {...props} />
    </ThemedComponent>
  );
}
