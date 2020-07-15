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
  source /Users/zhishui/sync/Whale-fall/src/upload.sh
  source /Users/zhishui/sync/Whale-fall/src/android.sh
  source /Users/zhishui/sync/Whale-fall/src/position.sh
  source /Users/zhishui/sync/Whale-fall/src/upgrade.sh
  source /Users/zhishui/sync/Whale-fall/src/vsc.sh
else
  echo '进入正式环境'
  source /usr/local/kae/upload.sh
  source /usr/local/kae/android.sh
  source /usr/local/kae/position.sh
  source /usr/local/kae/upgrade.sh
  source /usr/local/kae/vsc.sh
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
'switch')
  echo "env=${2}" >"${ENV_CONFIG_PATH}"
  cat "${ENV_CONFIG_PATH}"
  ;;
*)
  echo "当前为选择功能或该功能暂不支持"
  ;;
esac
