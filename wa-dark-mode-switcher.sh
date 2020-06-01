#!/usr/bin/env bash
# Usage: ./wa-dark-mode-switch.sh (see README.md for other commands)
# After executing this script restart Whatsapp for changes to take effect.
# Adopted from https://gist.github.com/a7madgamal/c2ce04dde8520f426005e5ed28da8608

case "$(uname -s)" in
  Darwin|darwin )
    WA_RESOURCES_DIR="/Applications/WhatsApp.app/Contents/Resources"
    ;;
  * )
    echo "System not supported"
    exit 1
    # WA_RESOURCES_DIR="/usr/lib/whatsapp/resources"
    ;;
esac

if [[ -z $WA_RESOURCES_DIR ]]; then echo "Please make sure WhatsApp is installed at $WA_RESOURCES_DIR" && exit 1; fi

echo && echo "This script requires sudo privileges." && echo "You'll need to provide your password."

NPX_PATH=$(type -P npx)
if [[ "$?" != "0" ]]; then
  echo "Please install node.js for your OS."
  if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "macOS users will also need to install Homebrew from https://brew.sh"
  fi
  exit 1
fi

WA_EVENT_LISTENER="event-listener.html"
WA_FILEPATH="$WA_RESOURCES_DIR/app.de-asar/index.html"

if [[ -z $HOME ]]; then HOME=$(ls -d ~); fi

# Unpack Asar Archive for WhatsApp
sudo "PATH=$PATH" $NPX_PATH asar extract $WA_RESOURCES_DIR/app.asar $WA_RESOURCES_DIR/app.de-asar

lead='<!-- BEGIN CUSTOM LISTENER SWITCH -->'
tail='<!--  END  CUSTOM LISTENER SWITCH -->'

if [[ "$(cat "$WA_FILEPATH")" != *"$lead"* ]]; then
  echo && echo "Adding Dark Theme switch to WhatsApp... "
else
  echo && echo "Replacing Dark Theme switch to WhatsApp... "
  sed -i "" -e '/'"$lead"'/,/'"$tail"'/d' "$WA_FILEPATH"
fi

lead='script>'
tail='<\/body>'

# Inserting or replacing script
sed -i "" -e '/'"$lead"'/,/'"$tail"'/{ /'"$lead"'/{p; r '"$WA_EVENT_LISTENER"'' -e' }; /'"$tail"'/p; d;} ' "$WA_FILEPATH"

# Add JS Code to WhatsApp
# sudo tee -a "$WA_FILEPATH" > /dev/null < $WA_EVENT_LISTENER

read -n 1 -r -s -p $'Press enter to continue...\n'

# Pack the Asar Archive for WhatsApp
sudo "PATH=$PATH" $NPX_PATH asar pack $WA_RESOURCES_DIR/app.de-asar $WA_RESOURCES_DIR/app.asar

sudo rm -r $WA_RESOURCES_DIR/app.de-asar

echo && echo "Done! After executing this script restart WhatsApp for changes to take effect."
