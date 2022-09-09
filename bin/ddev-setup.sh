#!/bin/bash

currentDir=${PWD##*/}
# Ask for the project name
echo -n "Project name [$currentDir]: "
read project_name

if [ "$project_name" == "" ];then
   project_name=$currentDir
else
  project_name=`echo $project_name | tr '[:upper:]' '[:lower:]'`
  project_name=`echo $project_name | tr -s '[:space:]' '-' | sed 's/.$//'`
fi

echo "Creating [$project_name] DDEV project"

# Genereta the config file
echo "Generating creating DDEV config.yaml file"
cp .ddev/template.config.yaml .ddev/config.yaml

sed -i '' -e "s/\PROJECT_NAME/$project_name/g"  .ddev/config.yaml

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

echo "Cleaning up"

echo "Installation completed!"