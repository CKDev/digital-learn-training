import React from "react";

import ForgotPassword from "../components/pages/ForgotPassword";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".forgot-password");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <ForgotPassword {...props} />
    </ThemedComponent>
  );
}
