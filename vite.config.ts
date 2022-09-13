/* eslint-disable @typescript-eslint/no-explicit-any */
import { resolve } from 'path';
import { defineConfig, normalizePath } from 'vite';
import manifestSRI from 'vite-plugin-manifest-sri';
import critical from 'rollup-plugin-critical';
import legacy from '@vitejs/plugin-legacy';
import ViteRestart from 'vite-plugin-restart';

const nPath = (path) => normalizePath(resolve(__dirname, path));

const criticalUrl = process.env.CRITICAL_URL || false;
const ddevUrl = process.env.DDEV_PRIMARY_URL || 'http://localhost';
const ddevVitePort = 5173;

let plugins = [
  manifestSRI(),

  legacy({
    targets: ['defaults', 'not IE 11'],
  }),

  (ViteRestart as any).default({ restart: ['./cms/templates/**/*'] }),
];

if (criticalUrl !== false) {
  plugins = [
    ...plugins,
    (critical as any).default({
      criticalUrl: criticalUrl,
      criticalBase: nPath('./cms/web/dist/criticalcss/'),
      criticalPages: [
        {
          uri: '/',
          template: '_base/_pages/_home',
        },
        {
          uri: '/education',
          template: '_base/_pages/_default_page',
        },
        {
          uri: '/attractions',
          template: '_base/_pages/_attractionsListing',
        },
        {
          uri: '/news',
          template: '_base/_pages/_newsListing',
        },
        {
          uri: '/news/a-bright-and-exciting-future',
          template: '_base/_pages/_newsEntry',
        },
        {
          uri: '/errors/404',
          template: 'errors/404',
        },
        {
          uri: '/errors/offline',
          template: 'errors/offline',
        },
        {
          uri: '/errors/error',
          template: 'errors/error',
        },
      ],
      criticalConfig: {
        base: nPath('./cms/web/dist/criticalcss/'),
        extract: true,
        dimensions: [
          { width: 1300, height: 900 },
          { width: 414, height: 896 },
          { width: 375, height: 667 },
        ],
      },
    }),
  ];
}

export default defineConfig(({ command }) => ({
  base: command === 'serve' ? '' : `${ddevUrl}/dist/`,
  publicDir: nPath('./src/static'),
  build: {
    emptyOutDir: true,
    manifest: true,
    outDir: nPath('./cms/web/dist'),
    rollupOptions: {
      input: {
        app: nPath('./src/js/app.ts'),
        'blk-gallery': nPath('./src/js/blk-gallery.ts'),
        'website-styles': nPath('./src/js/website-styles.js'),
        'cms-site-theme': nPath('./src/js/cms-site-theme.ts'),
        'lazysizes-wrapper': nPath('./src/js/utils/lazysizes-wrapper.ts'),
      },
      output: {
        sourcemap: false,
      },
    },
  },
  plugins: [...plugins],
  server: {
    fs: {
      strict: false,
    },
    origin: `${ddevUrl}:${ddevVitePort}`,
    host: '0.0.0.0',
    port: ddevVitePort,
    strictPort: true,
  },
}));
