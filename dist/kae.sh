#!/usr/bin/env bash
# 定义常量
# config的根目录
ROOT_DIR_PATH="${HOME}/.kae"
# 环境配置文件
ENV_CONFIG_PATH="${ROOT_DIR_PATH}/env_config"

env=$(cat "${ENV_CONFIG_PATH}" | cut -f2 -d '=')
path=$(pwd)
echo "当前的环境是${env}, 当前的工作路径为${path}"

if [[ $env == "dev" ]]; then
  echo '进入开发环境'
  source ${path}/upload.sh
  source ${path}/android.sh
  source ${path}/position.sh
  source ${path}/upgrade.sh
  source ${path}/vsc.sh
  source ${path}/tools.sh
else
  echo '进入正式环境'
  source /usr/local/kae/upload.sh
  source /usr/local/kae/android.sh
  source /usr/local/kae/position.sh
  source /usr/local/kae/upgrade.sh
  source /usr/local/kae/vsc.sh
  source /usr/local/kae/tools.sh
fi

case $1 in
'upload')
  upload
  ;;
'position')
  position "${2}"
  ;;
'adb')
  android "${2}"
  ;;
  #'help')
  #  sh ./help.sh
  #  ;;
'upgrade')
  upgrade
  ;;
'vsc')
  vsc ${2}
  ;;
'tools')
  tools ${2} // 参数
  ;;
'switch')
  cat ${ENV_CONFIG_PATH}
  echo "env=${2}" >${ENV_CONFIG_PATH}
  echo "切换环境为${2}"
  ;;
*)
  echo "当前为选择功能或该功能暂不支持"
  ;;
esac
