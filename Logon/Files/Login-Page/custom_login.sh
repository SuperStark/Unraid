#!/bin/bash
TYPE="retro-terminal"
THEME="white.css"
BASE_URL="https://raw.githubusercontent.com/SuperStark/Unraid/main/Logon/Files"
ADD_JS="true"
JS="custom_text_header.js"
DISABLE_THEME="false"

## FAQ

  # If you update variables after the script has been run,
  # you must disable the whole theme with the DISABLE_THEME="true" env first and re-run it again after with "false".

  # If you are on an Unraid version older than 6.10 you need to update the LOGIN_PAGE variable to "/usr/local/emhttp/login.php"

echo -e "Variables set:\n\
TYPE          = ${TYPE}\n\
THEME         = ${THEME}\n\
BASE_URL      = ${BASE_URL}\n\
ADD_JS        = ${ADD_JS}\n\
JS            = ${JS}\n\
DISABLE_THEME = ${DISABLE_THEME}\n"

echo "NOTE: Change the LOGIN_PAGE variable to /usr/local/emhttp/login.php if you are on a version older than 6.10"
LOGIN_PAGE="/usr/local/emhttp/webGui/include/.login.php"


IFS='"'
set $(cat /etc/unraid-version)
UNRAID_VERSION="$2"
IFS=$' \t\n'
echo "Unraid version: ${UNRAID_VERSION}"

# Restore login.php
if [ ${DISABLE_THEME} = "true" ]; then
  echo "Restoring backup of login.php" 
  cp -p ${LOGIN_PAGE}.backup ${LOGIN_PAGE}
  exit 0
fi

# Backup login page if needed.
if [ ! -f ${LOGIN_PAGE}.backup ]; then
  echo "Creating backup of login.php" 
  cp -p ${LOGIN_PAGE} ${LOGIN_PAGE}.backup
fi

# Adding stylesheets
if ! grep -q "SuperStark" ${LOGIN_PAGE}; then
  echo "Adding stylesheet"
  sed -i -e "\@<style>@i\    <link data-tp='theme' rel='stylesheet' href='${BASE_URL}/${TYPE}/${THEME}'>" ${LOGIN_PAGE}
  sed -i -e "\@<style>@i\    <link data-tp='base' rel='stylesheet' href='${BASE_URL}/${TYPE}/${TYPE}-base.css'>" ${LOGIN_PAGE}
  echo 'Stylesheet set to' ${THEME}
fi

# Adding/Removing javascript
if [ "${ADD_JS}" = "true" ]; then
  if ! grep -q "${JS}" ${LOGIN_PAGE}; then
    if grep -q "<script type='text/javascript' src='${BASE_URL}" ${LOGIN_PAGE}; then
      echo "Replacing Javascript"
      sed -i "\@<script type='text/javascript' src='${BASE_URL}@c\    <script type='text/javascript' src='${BASE_URL}/${TYPE}/js/${JS}'></script>" ${LOGIN_PAGE}
    else
      echo "Adding javascript"
      sed -i -e "\@</body>@i\    <script type='text/javascript' src='${BASE_URL}/${TYPE}/js/${JS}'></script>" ${LOGIN_PAGE}
    fi
  fi
else
  if grep -q "${JS}" ${LOGIN_PAGE}; then
    echo "Removing javascript.."
    sed -i "\@<script type='text/javascript' src='${BASE_URL}@d" ${LOGIN_PAGE}
  fi
fi

# Changing stylesheet
if ! grep -q "${TYPE}/${THEME}" ${LOGIN_PAGE}; then
  echo "Changing existing custom stylesheet.." 
  sed -i "\@<link data-tp='theme'@c\    <link data-tp='theme' rel='stylesheet' href='${BASE_URL}/${TYPE}/${THEME}'>" ${LOGIN_PAGE}
  sed -i "\@<link data-tp='base'@c\    <link data-tp='base' rel='stylesheet' href='${BASE_URL}/${TYPE}/${TYPE}-base.css'>" ${LOGIN_PAGE}
  echo 'Stylesheet set to' ${THEME}
fi
