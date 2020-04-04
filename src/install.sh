#!/usr/bin/env bash

cd /usr/local/

have_sudo_access() {
  if [[ -z "${HAVE_SUDO_ACCESS-}" ]]; then
    /usr/bin/sudo -l mkdir &>/dev/null
    HAVE_SUDO_ACCESS="$?"
  fi

  if [[ -z "${HOMEBREW_ON_LINUX-}" ]] && [[ "$HAVE_SUDO_ACCESS" -ne 0 ]]; then
    abort "Need sudo access on macOS!"
  fi

  return "$HAVE_SUDO_ACCESS"
}

createRootDir() {
  if [[ ! -d "/usr/local/kae" ]];
  then
    echo "创建kae目录"
    sudo mkdir -v /usr/local/kae 
 fi
}

#installKae() {
#  cd kae
#  sudo curl https://raw.githubusercontent.com/pepperer/shelljs/master/dist/kae -O --progress
#  sudo chmod 555 kae
#  ln -sf /usr/local/kae/kae /usr/local/bin/kae
#}

if have_sudo_access;
then
  echo "获取到sudo权限"
  createRootDir
  installKae
else
  echo "未获取到sudo权限"
fi
#  



