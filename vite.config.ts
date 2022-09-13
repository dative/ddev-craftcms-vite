/* eslint-disable @typescript-eslint/no-explicit-any */
import { resolve } from 'path'
import { defineConfig, normalizePath } from 'vite'
import manifestSRI from 'vite-plugin-manifest-sri'
import critical from 'rollup-plugin-critical'
import legacy from '@vitejs/plugin-legacy'
import ViteRestart from 'vite-plugin-restart'
import { ViteFaviconsPlugin } from 'vite-plugin-favicon2'

const nPath = path => normalizePath(resolve(__dirname, path))

const criticalUrl = process.env.CRITICAL_URL || false
const ddevUrl = process.env.DDEV_PRIMARY_URL || 'http://localhost'
const ddevVitePort = parseInt(process.env.VITE_PRIMARY_PORT || '5173')

let plugins = [
  manifestSRI(),

  legacy({
    targets: ['defaults', 'not IE 11']
  }),

  ViteFaviconsPlugin({
    logo: nPath('./static/favicon.svg'),
    inject: false,
    outputPath: 'favicons',
    favicons: {
      start_url: '/'
    }
  }),

  /*
    Using undocumented "reload" prop instead "restart" for
    faster developement. Check:
    https://github.com/antfu/vite-plugin-restart/blob/main/src/index.ts#L25
  */
  (ViteRestart as any).default({ reload: ['./cms/templates/**/*'] })
]

if (criticalUrl !== false) {
  plugins = [
    ...plugins,
    (critical as any).default({
      criticalUrl: criticalUrl,
      criticalBase: nPath('./cms/web/dist/criticalcss/'),
      criticalPages: [
        {
          uri: '/',
          template: 'index'
        }
      ],
      criticalConfig: {
        base: nPath('./cms/web/dist/criticalcss/'),
        extract: true,
        dimensions: [
          { width: 1300, height: 900 },
          { width: 414, height: 896 },
          { width: 375, height: 667 }
        ]
      }
    })
  ]
}

export default defineConfig(({ command }) => ({
  base: command === 'serve' ? '' : `/dist/`,
  publicDir: nPath('./src/static'),
  build: {
    emptyOutDir: true,
    manifest: 'vite-manifest.json',
    outDir: nPath('./cms/web/dist'),
    rollupOptions: {
      input: {
        app: nPath('./src/js/app.ts'),
        'lazysizes-wrapper': nPath('./src/js/utils/lazysizes-wrapper.ts')
      },
      output: {
        sourcemap: true
      }
    }
  },
  plugins: [...plugins],
  server: {
    fs: {
      strict: false
    },
    origin: `${ddevUrl}:${ddevVitePort}`,
    host: '0.0.0.0',
    port: ddevVitePort,
    strictPort: true
  }
}))
