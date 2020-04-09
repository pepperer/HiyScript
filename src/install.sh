#!/usr/bin/env bash
# 进入到 /usr/local 目录
cd /usr/local/

have_sudo_access() {
  if [[ -z "${HAVE_SUDO_ACCESS-}" ]]; then
    /usr/bin/sudo -l mkdir &>/dev/null
    HAVE_SUDO_ACCESS="$?"
  fi

  if [[ "$HAVE_SUDO_ACCESS" -ne 0 ]]; then
    abort "Need sudo access on macOS!"
  fi

  return "$HAVE_SUDO_ACCESS"
}

create_root_dir() {
  if [[ ! -d "/usr/local/kae" ]]; then
    echo "正在创建kae目录"
    sudo mkdir -v /usr/local/kae
    install_script shell
  fi
}

install_script() {
  cd kae
  echo "准备开始安装脚本$1"
  case $1 in
  'shell')
    echo "开始更新壳"
    sudo curl https://raw.githubusercontent.com/pepperer/shelljs/master/dist/kae -O --progress
    sudo chmod 555 kae
    ln -sf /usr/local/kae/kae /usr/local/bin/kae
    ;;
  'upload')
    echo "开始更新上传"
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/upload.sh -O --progress
    sudo
    ;;
  'position')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/position.sh -O --progress
    ;;
  'adb')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/android.sh -O --progress
    ;;
  'upgrade')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/update.sh -O --progress
    ;;
  esac
}
#  cd kae

if have_sudo_access; then
  echo "获取到sudo权限"
  create_root_dir
  install_script $1
else
  echo "未获取到sudo权限"
fi
#
