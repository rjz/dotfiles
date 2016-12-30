#!/bin/bash

DOWNLOAD_DIR=${HOME}/Downloads

DESKTOP_LINK=${HOME}/Desktop/android-studio.desktop

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CWD=$(pwd)

BUNDLE_PATH=$(ls -t ${DOWNLOAD_DIR} \
  | grep android-studio*.zip \
  | head -n1
)

[[ -z "${BUNDLE_PATH}" ]] || {
  echo "Download latest Android studio from:
  https://developer.android.com/studio/index.html"
  exit 1
}

[[ -d ${DOWNLOAD_DIR}/android-studio ]] || {
  cd $DOWNLOAD_DIR
  unzip ${BUNDLE_PATH}
}

[[ -f ${DESKTOP_LINK} ]] || {
  cat <<EOF > "${DESKTOP_LINK}"
[Desktop Entry]
Name=Android Studio
Exec=env GRADLE_OPTS=-Dorg.gradle.daemon=true ${DOWNLOAD_DIR}/android-studio/bin/studio.sh
Icon=/usr/share/icons/Humanity/categories/48/applications-development.svg
Terminal=false
Type=Application
Categories=Application;
EOF

  chmod +x "${DESKTOP_LINK}"
}
