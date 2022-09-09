#!/bin/bash

usage()
{
   # Display Help
   echo "DDEV / CraftCMS setup script"
   echo
   echo "Syntax: ddev-setup.sh [-h|n|V]"
   echo "options:"
   echo "-h                 Print this Help."
   echo "-n PROJECT_NAME    Initialize the project with the given name."
   echo "-a                 Initialize the project with current directoy name."
   echo
}

currentDir=${PWD##*/}

while getopts ":han:" option; do
  case "${option}" in
    h) # display Help
      usage
      exit;;

    a) # Use current directory name as project name
      project_name=$currentDir;;

    n) # Enter project name
      project_name=${OPTARG};;

    *) # If unknown (any other) option:
      usage
      exit 1;;
  esac
done

if [ "$project_name" == "" ];then
  echo -n "Project name [$currentDir]: "
  read project_name
  if [ "$project_name" == "" ];then
    project_name=$currentDir
  fi
fi

project_name=`echo $project_name | tr '[:upper:]' '[:lower:]'`
project_name=`echo $project_name | tr -s '[:space:]' '-' | sed 's/.$//'`

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