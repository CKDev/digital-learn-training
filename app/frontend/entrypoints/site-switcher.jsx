import React from 'react';

import SiteSwitcher from '../components/SiteSwitcher';
import { createRoot } from 'react-dom/client';

const container = document.querySelector('.site-switcher')
if (container) {
  console.log(container.dataset.props);
  const props = JSON.parse(container.dataset.props);
  const root = createRoot(container);
  root.render(
    <React.StrictMode>
      <SiteSwitcher {...props} />
    </React.StrictMode>
  );
}