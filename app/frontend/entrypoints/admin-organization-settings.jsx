import React from "react";
import { createRoot } from "react-dom/client";
import ThemedComponent from "../components/ThemedComponent";
import OrganizationSettings from "../components/admin/pages/OrganizationSettings";

const container = document.querySelector(".admin-organization-settings");
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <OrganizationSettings {...props} />
    </ThemedComponent>
  );
}
