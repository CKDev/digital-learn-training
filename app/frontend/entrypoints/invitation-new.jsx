import React from "react";

import InvitationNew from "../components/pages/InvitationNew";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".invitation-new");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <InvitationNew {...props} />
    </ThemedComponent>
  );
}
