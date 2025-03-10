import React from "react";

import Header from "../components/Header";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".header");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);

  root.render(
    <ThemedComponent>
      <Header {...props} />
    </ThemedComponent>
  );
}
