import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import pluginRewriteAll from "vite-plugin-rewrite-all";
import tsconfigPaths from "vite-tsconfig-paths";

export default defineConfig({
  plugins: [
    react(),
    tsconfigPaths(),
    pluginRewriteAll(),
  ],
  server: {
    fs: {
      allow: [
        ".",
        "../hello-wasm/pkg",
      ],
    },
  },
});
