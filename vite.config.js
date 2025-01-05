import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import react from '@vitejs/plugin-react';
import path from 'path'

export default defineConfig({
  plugins: [RubyPlugin(), react()],
  build: {
    rollupOptions: {
      input: [
        'app/frontend/entrypoints',
        'app/frontend/assets',
        'app/frontend/components',
        'app/frontend/utils',
        'app/frontend/api',
      ],
    },
  },
  resolve: {
    alias: {
      '@utils': path.resolve(__dirname, 'app/frontend/utils'),
      '@api': path.resolve(__dirname, 'app/frontend/api'),
    },
  },
});
