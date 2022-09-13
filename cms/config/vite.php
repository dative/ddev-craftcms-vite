<?php

use craft\helpers\App;

return [
  'useDevServer' => App::env('CRAFT_ENVIRONMENT') === 'dev',
  'devServerPublic' => App::env('PRIMARY_SITE_URL') . ':' . App::env('VITE_PRIMARY_PORT'),
  'devServerInternal' => 'http://localhost:' . App::env('VITE_PRIMARY_PORT'),
  'manifestPath' => '@webroot/dist/vite-manifest.json',
  'serverPublic' => '/dist/',
  'errorEntry' => '',
  'cacheKeySuffix' => '',
  'checkDevServer' => App::env('CRAFT_ENVIRONMENT') === 'dev',
  'includeReactRefreshShim' => false,
  'includeModulePreloadShim' => true,
  'criticalPath' => '@webroot/dist/criticalcss',
  'criticalSuffix' => '_critical.min.css',
];
