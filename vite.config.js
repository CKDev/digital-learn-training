import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import react from '@vitejs/plugin-react';
import path from 'path'

export default defineConfig({
  plugins: [RubyPlugin(), react()],
  resolve: {
    alias: {
      '@utils': path.resolve(__dirname, 'app/frontend/components/utils'),
      '@api': path.resolve(__dirname, 'app/frontend/components/api'),
    },
  },
});
