import React from "react";

import TermsOfUse from "../components/pages/TermsOfUse";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".terms-of-use-page");
if (container) {
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <TermsOfUse />
    </ThemedComponent>
  );
}
