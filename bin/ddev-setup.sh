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
      exit 0;;

    a) # Use current directory name as project name
      project_name=$currentDir;;

    n) # Enter project name
      project_name=${OPTARG};;

    *) # If unknown (any other) option:
      usage
      exit 2;;
  esac
done

if [ "$project_name" == "" ];then
  echo -n "Project name [$currentDir]: "
  read project_name
  if [ "$project_name" == "" ];then
    project_name=$currentDir
  fi
fi

# get the start time of the script
start_time=`gdate +%s.%N`

project_name=`echo $project_name | tr '[:upper:]' '[:lower:]'`
project_name=`echo $project_name | tr -s '[:space:]' '-' | sed 's/.$//'`

echo "Creating [$project_name] DDEV project"

# Create DDEV config file with project name
echo "Generating creating DDEV config.yaml file"
mv .ddev/template.config.yaml .ddev/config.yaml
sed -i '' -e "s/\PROJECT_NAME/$project_name/g"  .ddev/config.yaml

# Prep installer composer.json
echo "Renaming ./cms/composer.ddev-installer.json to ./cms/composer.json"
mv ./cms/composer.ddev-installer.json ./cms/composer.json

echo "Starting DDEV"
ddev start -y >/dev/null

# Install Craft
echo "Installing Craft"
ddev composer post-ddev-install --quiet
# ddev launch /admin



############ Clean up ############
echo "Cleaning up install and "
# Remove ./bin
[ -d "./bin" ] && rm -rf ./bin
# remove ./cms/craft-install.exp
[ -f "./cms/craft-install.exp" ] && rm ./cms/craft-install.exp
# Remove .git
[ -d ".git" ] && rm -rf .git
# rename .gitignore
if [ -f "gitignore.example" ]; then
  rm .gitignore
  mv gitignore.example .gitignore
fi



# Finishing up
end_time=`gdate +%s.%N`
runtime=$(echo "$end_time - $start_time" | bc -l)
execution_time=`printf "%.2f seconds" $runtime`
echo "Installation completed in $execution_time!"
exit 0