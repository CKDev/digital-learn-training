import { mount } from 'svelte';
import CourseMaterialCard from '../components/CourseMaterialCard.svelte';

Array.prototype.slice.call(document.getElementsByClassName('course-material-card'))
.forEach((target: HTMLElement) => {
  if (target) {
    mount(CourseMaterialCard, {
      target,
      props: {
        title: target.dataset['title'],
        body: target.dataset['body'],
        destination: target.dataset['destination']
      },
    });
  }}
);