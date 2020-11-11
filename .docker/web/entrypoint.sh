#! /bin/bash
set  -e

if ! diff -q Gemfile.lock $GEM_HOME/last_Gemfile.lock; then
  echo -e "\e[33mChanges detected on Gemfile... Running 'bundle install'\e[0m"
  bundle install
  cp Gemfile.lock $GEM_HOME/last_Gemfile.lock
fi
echo -e "\e[32mGems installed\e[0m"
# Detect changes in package.json...
if ! diff -q package.json $GEM_HOME/last_package.json; then
echo -e "\e[33mChanges detected on package.json... Running 'npm install'\e[0m"
  npm install
  cp package.json $GEM_HOME/last_package.json
fi
echo -e "\e[32mNode packages installed\e[0m"

exec "$@"