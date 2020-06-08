#!/usr/bin/env bash
# 定义常量

#### 配置文件相关
ROOT_DIR_PATH="${HOME}/.kae"               # config的根目录
CONFIG_FILE_PATH="${ROOT_DIR_PATH}/config" # 配置文件路径
TEMP_FILE_PATH="${ROOT_DIR_PATH}/.temp"    # 原厂配置临时文件用于和config做比较

#### 脚本根目录
SCRIPT_ROOT_PATH="/usr/local/kae/"

# 脚本路径
KAE_FILE_PATH=''

env=$(egrep 'env' ./config | cut -f2 -d :)
path=$(pwd)
echo "当前的环境是${env}, 当前的工作路径为${path}"
if [[ $env == "dev" ]]; then
  echo '进入开发环境'
  source ./upload.sh
  source ./android.sh
  source ./position.sh
  source ./upgrade.sh
  source ./vsc.sh
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
  vsc ${1}
  ;;
*)
  echo "当前为选择功能或该功能暂不支持"
  ;;
esac
