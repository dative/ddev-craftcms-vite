# ddev-craftcms-vite

This repository is a template for [DDEV](https://ddev.readthedocs.io/en/stable/) + [CraftCMS](https://craftcms.com/docs/4.x/) + [Vite](https://vitejs.dev) project for local development.

This implementation makes heavy use of default and added DDEV environment variables to configure the project. The following environment variables are used:

- `DDEV_PRIMARY_URL`: used both on `vite.config.ts` and `./cms/.env` to configure the CraftCMS `PRIMARY_SITE_URL` and in Vite's `server` configuration.
- `DDEV_PROJECT`: used to configure the CraftCMS `PRIMARY_SITE_NAME`
- `VITE_PRIMARY_PORT`: used to configure the port on Vite's `server`  and Vite Craft Plugin on `./cms/config/vite.php`


You can create a new repo from this one by clicking the template button in the top right corner of the page.

![template button](extras/template-preview.png)

## Components of the repository

- The base setup to run CraftCMS + Vite with DDEV
- [Github actions](https://github.com/dative/ddev-craftcms-vite/blob/main/.github/workflows/build-and-deploy.yml) for building an deploying the site in Forge.

## Requirements

DDEV installed and running on your machine. [Installation instructions](https://ddev.readthedocs.io/en/stable/#installation)

## Getting started

After cloning your new repo:

1. Create the new template repository by using the template button.
2. Clone the new repository to your local machine.
3. Replace `craft-vite` in `.ddev/confi.yaml` with your local project name.
4. Start DDEV with `ddev start`.
5. Run `ddev install-craft` to install CraftCMS.

The [`ddev install-craft`](https://github.com/dative/ddev-craftcms-vite/blob/main/.ddev/commands/web/install-craft) command will perform the following actions:

- Copy the `env.example` file to `.env`, if it doesn't exist.
- Create the `storage` directory, if it doesn't exist.
- Setup Craft's `CRAFT_APP_ID`, `CRAFT_SECURITY_KEY` and setup the database with DDEV's default configuration.
- Install CraftCMS with all defaults plus:
  - Email: `info@hellodative.com`
  - Password: `changeme`.
  - Site name: `$PRIMARY_SITE_NAME`
  - Site URL: `$PRIMARY_SITE_URL`
- Perform Craft Plugin installs.

## DDEV & Craft Configuration

DDEV is configured with the following settings:

- PHP 8.1
- MySQL 8.0
- Node 16

## Usage

Once installed and started, you can run `ddev yarn` to install the node dependencies and `ddev yarn dev` to start the dev server.

Other useful commands:

- `ddev yarn lint`: run the linter.
- `ddev yarn lint:fix`: run the linter and fix the errors.
- `ddev yarn build`: build the production assets.
- `ddev yarn build:critical`: build the production assets for CI. It uses `CRITICAL_URL` env variable to generate the critical CSS.


### Craft Setup:

The following Craft CMS plugins are used on this site:

- [Mailgun](https://github.com/craftcms/mailgun)
- [Redactor](https://github.com/craftcms/redactor)
- [BlurHash](https://github.com/dodecastudio/craft-blurhash)
- [Vite](https://github.com/nystudio107/craft-vite)
- [Empty Coalesce](https://github.com/nystudio107/craft-emptycoalesce)
- [Retour](https://github.com/nystudio107/craft-retour)
- [SEOmatic](https://github.com/nystudio107/craft-seomatic)
- [Typogrify](https://github.com/nystudio107/craft-typogrify)
- [Minify](https://github.com/nystudio107/craft-minify)
- [Relax](https://github.com/ostark/craft-relax)
- [Typed Link Field](https://github.com/sebastian-lenz/craft-linkfield)
- [DigitalOcean Spaces Volume](https://github.com/vaersaagod/dospaces)
- [Navigation](https://github.com/verbb/navigation)
- [Super Table](https://github.com/verbb/super-table)

### Frontend Setup:

The frontend is configured using [Vite](https://vitejs.dev), with Typescript, and [TailwindCSS](https://tailwindcss.com/).

The Vite configuration is located in `vite.config.ts` and has the following settings:

#### Vite Plugins:

- [manifestSRI](https://github.com/ElMassimo/vite-plugin-manifest-sri)
- [legacy](https://github.com/vitejs/vite/tree/main/packages/plugin-legacy#readme)
- [ViteRestart](https://github.com/antfu/vite-plugin-restart)
- [ViteFaviconsPlugin](https://github.com/khalwat/vite-plugin-favicon)
- [critical](https://github.com/nystudio107/rollup-plugin-critical)

## Thanks

Big thanks to Andrew Welch for his awesome [plugins](https://nystudio107.com/plugins) and [articles](https://nystudio107.com/blog) from which this repository is heavily based on.

## Roadmap

Brought to you by [Dative](https://hellodative.com)