<?php

/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

use craft\config\GeneralConfig;
use craft\helpers\App;

return GeneralConfig::create()

    ->devMode(App::env('DEV_MODE') ?? false)

    ->aliases([
        '@assetsUrl' => App::env('ASSETS_URL'),
        '@assetsRoot' => App::env('ASSETS_ROOT'),
        '@web' => App::env('PRIMARY_SITE_URL'),
        '@webroot' => App::env('WEB_ROOT_PATH')
    ])

    ->errorTemplatePrefix('_errors/')

    ->maxUploadFileSize('100M')

    ->enableTemplateCaching(App::env('ENABLE_TEMPLATE_CACHING') ?? false)

    ->cacheDuration(false)

    ->defaultTokenDuration('P2W')

    ->enableCsrfProtection(true)

    ->resourceBasePath(App::env('WEB_ROOT_PATH') . '/cpresources')

    ->securityKey(App::env('CRAFT_SECURITY_KEY'))

    ->useEmailAsUsername(true)

    ->omitScriptNameInUrls(true)

    ->usePathInfo(true)

    ->defaultSearchTermOptions([
        'subLeft' => true,
        'subRight' => true,
    ])

    ->extraFileKinds([
        // merge .csv into list of text file kinds
        'text' => [
            'extensions' => ['csv'],
        ],
    ])

    // (0 = Sunday, 1 = Monday, etc.)
    ->defaultWeekStartDay(1)

    ->allowAdminChanges(App::env('ALLOW_ADMIN_CHANGES') ?? false)

    ->allowUpdates(App::env('ALLOW_UPDATES') ?? false)

    ->backupOnUpdate(App::env('BACKUP_ON_UPDATE') ?? true)

    ->runQueueAutomatically(App::env('RUN_QUEUE_AUTOMATICALLY') ?? true)

    ->disallowRobots(App::env('DISALLOW_ROBOTS') ?? false);
