import React from 'react';

import CourseMaterialCard from '../components/CourseMaterialCard';
import { createRoot } from 'react-dom/client';

let root;
Array.prototype.slice.call(document.getElementsByClassName('course-material-card'))
  .forEach((container) => {
    if (container) {
      const props = JSON.parse(container.dataset.props);
      root = createRoot(container);
      root.render(
        <React.StrictMode>
          <CourseMaterialCard {...props} />
        </React.StrictMode>
      );
    }
  });