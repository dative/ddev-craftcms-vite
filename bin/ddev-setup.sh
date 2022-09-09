#!/bin/bash

# Ask for the project name
read -p "Project name (current)? " projectname

echo [projectname] = $projectname

# TODO: validate the project name

# Genereta the config file
echo "Generating creating DDEV config.yaml file"
cp .ddev/template.config.yaml .ddev/config.yaml

sed -i '' -e "s/\PROJECT_NAME/$projectname/g"  .ddev/config.yaml

# Initialize DDEV
echo "Copying ./cms/composer.ddev-installer.json to ./cms/composer.json"
cp ./cms/composer.ddev-installer.json ./cms/composer.json
ddev start

# Install Craft
echo "Installing Craft"
ddev composer post-ddev-install
ddev launch /admin
ddev describe

# Clean up