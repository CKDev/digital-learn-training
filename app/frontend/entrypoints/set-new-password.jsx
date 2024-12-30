import React from "react";

import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";
import SetNewPassword from "../components/pages/SetNewPassword";

const container = document.querySelector(".set-new-password");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <SetNewPassword {...props} />
    </ThemedComponent>
  );
}
