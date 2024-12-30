import React from "react";

import SignIn from "../components/pages/SignIn";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".sign-in");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <SignIn {...props} />
    </ThemedComponent>
  );
}
