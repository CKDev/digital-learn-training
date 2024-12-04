import React from 'react';

import SiteSwitcher from '../components/SiteSwitcher';
import { createRoot } from 'react-dom/client';
import ThemedComponent from '../components/ThemedComponent';

const container = document.querySelector('.site-switcher')
if (container) {
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <ThemedComponent>
      <SiteSwitcher {...props} />
    </ThemedComponent>
  );
}