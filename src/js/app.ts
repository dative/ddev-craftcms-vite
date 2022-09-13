// Accept HMR as per: https://vitejs.dev/guide/api-hmr.html
if (import.meta.hot) {
  import.meta.hot.accept(() => {
    console.log('HMR')
  })
}

import 'vite/modulepreload-polyfill'

import '../img/sprite.svg'
import '../css/app.css'
