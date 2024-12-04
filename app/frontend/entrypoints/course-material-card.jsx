import React from 'react';

import CourseMaterialCard from '../components/CourseMaterialCard';
import { createRoot } from 'react-dom/client';
import ThemedComponent from '../components/ThemedComponent';

let root;
Array.prototype.slice.call(document.getElementsByClassName('course-material-card'))
  .forEach((container) => {
    if (container) {
      const props = JSON.parse(container.dataset.props);
      root = createRoot(container);
      root.render(
        <ThemedComponent>
          <CourseMaterialCard {...props} />
        </ThemedComponent>
      );
    }
  });