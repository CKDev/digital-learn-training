import { mount } from 'svelte';
import Test from '../components/Test.svelte';

console.log('attaching svelte')
const target = document.getElementById('test-component'); // Match the placeholder ID
console.log('target: ' + target)
if (target) {
  mount(Test, {
    target,
    props: {
      title: 'Dynamic Title',
      body: 'This is a dynamically passed body.',
    },
  });
}