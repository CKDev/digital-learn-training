import React from "react";

import InvitationEdit from "../components/pages/InvitationEdit";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";

const container = document.querySelector(".invitation-edit");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <InvitationEdit {...props} />
    </ThemedComponent>
  );
}
