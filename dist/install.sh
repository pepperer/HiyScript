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
  else
     echo "/usr/local/kae 目录已创建"
  fi
}

install_shell() {
  echo "开始安装壳"
  sudo curl https://raw.githubusercontent.com/pepperer/shelljs/master/dist/kae -O --progress
  sudo chmod 555 kae
  ln -sf /usr/local/kae/kae /usr/local/bin/kae
}

install_script() {
  echo "准备开始安装脚本$1"
  case $1 in
  'shell')
    install_shell
    ;;
  'upload')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/upload.sh -O --progress
    ;;
  'position')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/position.sh -O --progress
    ;;
  'adb')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/android.sh -O --progress
    ;;
  'upgrade')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/upgrade.sh -O --progress
    ;;
  'vsc')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/vsc.sh -O --progress
    ;;
  'install')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/tools/install.sh -O --progress
    ;;
  'uninstall')
    sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/tools/uninstall.sh -O --progress
    ;;
  '')
    echo "默认"
    install_script shell
    install_script upload
    install_script adb
    install_script upgrade
    install_script position
    install_script install
    install_script uninstall
    install_script vsc
    ;;
  esac
}
#  cd kae


installConfig() {
  # 配置文件
  ROOT_DIR_PATH="${HOME}/.kae"
  # 版本配置文件
  VERSION_CONFIG_PATH="${ROOT_DIR_PATH}/config"
  # 配置文件
  GIT_CONFIG_PATH="${ROOT_DIR_PATH}/git_config"
  # 环境配置文件
  ENV_CONFIG_PATH="${ROOT_DIR_PATH}/env_config"

  if [[ ! -d ${ROOT_DIR_PATH} ]]; then
      echo "kea 配置根目录开始构建"
       mkdir "${ROOT_DIR_PATH}"
    else
      echo "kea 配置根目录已生成"
  fi

  if [[ ! -f ${ENV_CONFIG_PATH} ]]; then
    touch "${ENV_CONFIG_PATH}"
    echo 'env=on' > "${ENV_CONFIG_PATH}"
  else
    echo "环境配置文件已生成"
  fi

  if [[ ! -f ${VERSION_CONFIG_PATH} ]]; then
    touch "${VERSION_CONFIG_PATH}"
  else
    echo "版本配置文件已生成"
  fi

  if [[ ! -f ${GIT_CONFIG_PATH} ]]; then
    touch "${GIT_CONFIG_PATH}"
  else
    echo "git配置文件已生成"
  fi
}

if have_sudo_access; then
  echo "获取到sudo权限"
  create_root_dir
  # 进入到kae 根目录
  cd /usr/local/kae
  pwd
  # 开始安装脚本
  install_script $1
  # 同步配置和版本信息
  echo "准备开始安装版本信息"
  installConfig
#  sudo curl https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/config -O --progress
else
  echo "未获取到sudo权限"
fi
#
