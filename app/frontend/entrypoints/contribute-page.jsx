import React from "react";

import Contribute from "../components/pages/Contribute";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".contribute-page");
if (container) {
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <Contribute />
    </ThemedComponent>
  );
}
