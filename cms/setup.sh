#!/bin/bash

############ Setup Craft ############
echo "Installing and Configuring CraftCMS"
[ ! -f ".env" ] && mv env.example .env

php craft setup/app-id
php craft setup/security-key
php craft setup/db --interactive=0 --driver=mysql --database=db --user=db --password=db --server=ddev-$DDEV_PROJECT-db --port=3306

chmod +x craft-install.exp && ./craft-install.exp

composer update --quiet --no-scripts --no-interaction --prefer-dist --optimize-autoloader --ignore-platform-reqs

php craft plugin/install mailgun
php craft plugin/install redactor
php craft plugin/install blur-hash
php craft plugin/install empty-coalesce
php craft plugin/install retour
php craft plugin/install seomatic
php craft plugin/install typogrify
php craft plugin/install vite
php craft plugin/install relax
php craft plugin/install typedlinkfield
php craft plugin/install dospaces
php craft plugin/install navigation
php craft plugin/install super-tabl



############ Clean up ############
echo "Cleaning up install and setup scripts"
# remove ./cms/craft-install.exp
[ -f "./setup.sh" ] && rm ./setup.sh
[ -f "./craft-install.exp" ] && rm ./craft-install.exp

exit 0