import React from "react";

import PrivacyPolicy from "../components/pages/PrivacyPolicy";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".privacy-policy-page");
if (container) {
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <PrivacyPolicy />
    </ThemedComponent>
  );
}
