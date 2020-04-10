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

#init() {
#  if [[ ! -d $ROOT_DIR_PATH ]]; then
#    mkdir $ROOT_DIR_PATH
#    touch $CONFIG_FILE_PATH
#    echo "version:1.0.0" >>$CONFIG_FILE_PATH
#  fi
#  localVersion=$(grep -i version ${CONFIG_FILE_PATH} | cut -f 2 -d :)
#  echo "当前版本为$localVersion"
#
#  code=$(shasum -a 256 ${KAE_FILE_PATH} | cut -f 1 -d " ")
#  echo "当前文件的abs256值为: ${code}"
#
#  content=$(curl -fsSL https://raw.githubusercontent.com/pepperer/shelljs/master/dist/kae -o ${TEMP_FILE_PATH})
#  tempCode=$(shasum -a 256 ${TEMP_FILE_PATH} | cut -f 1 -d " ")
#  echo "远程文件的abs256值为: ${tempCode}"
#
#  #remoteCode=$(echo ${content} | shasum -a 256 | cut -f 1 -d " " )
#  #echo  "远程文件的abs256值为${remoteCode}"
#
#  if [[ $code != $tempCode ]]; then
#    echo "当前版本不一致, 将开始进行更新。。。"
#    return 1
#  fi
#
#  echo "当前版本一致, 将不进行更新"
#  return 0
#}

env=$(egrep 'env' ./config | cut -f2 -d :)
path=$(pwd)
echo "当前的环境是${env}, 当前的工作路径为${path}"
if [[ $env != "dev" ]]; then
  echo '进入正式环境'
  source /usr/local/kae/upload.sh
  source /usr/local/kae/android.sh
else
  echo '进入开发环境'
  source ./upload.sh
  source ./android.sh
fi

case $1 in
'upload')
  upload
  ;;
'position')
  sh ./position.sh "${2}"
  ;;
'adb')
  android "${2}"
  ;;
'help')
  sh ./help.sh
  ;;
'upgrade')
  sh ./upgrade.sh
  ;;
*)
  echo "当前为选择功能或该功能暂不支持"
  ;;
esac