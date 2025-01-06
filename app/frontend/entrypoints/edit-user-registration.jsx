import React from "react";

import EditUserRegistration from "../components/pages/EditUserRegistration";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".edit-user-registration");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <EditUserRegistration {...props} />
    </ThemedComponent>
  );
}
