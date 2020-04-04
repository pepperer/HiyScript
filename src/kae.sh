#!/usr/bin/env bash
# 定义常量

#### 配置文件相关
ROOT_DIR_PATH="${HOME}/.kae"                     # config的根目录
CONFIG_FILE_PATH="${ROOT_DIR_PATH}/config"       # 配置文件路径
TEMP_FILE_PATH="${ROOT_DIR_PATH}/.temp"          # 原厂配置临时文件用于和config做比较

#### 脚本根目录
SCRIPT_ROOT_PATH="/usr/local/kae/"

# 脚本路径
KAE_FILE_PATH=''

help() {
  echo "当前支持的工功能有:"
  echo "kae upload           用户模块上传, 仅支持settings.gradle 带:的模块"
  echo "kae grep [module]    查看appshell匹配module的内容"
  echo "kae adb  [fubc]      支持部分adb操作:activity, layout-on, layout-off"
}

update() {
  echo "开始更新......"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/pepperer/shelljs/master/src/install.sh)"
}

init() {
  if [[ ! -d $ROOT_DIR_PATH ]];
  then
    mkdir $ROOT_DIR_PATH
    touch $CONFIG_FILE_PATH
    echo "version:1.0.0" >> $CONFIG_FILE_PATH
  fi
  localVersion=$(grep -i version ${CONFIG_FILE_PATH} | cut -f 2 -d :)
  echo "当前版本为$localVersion"

  code=$(shasum -a 256 ${KAE_FILE_PATH} | cut -f 1 -d " " )
  echo "当前文件的abs256值为: ${code}"

  content=$(curl -fsSL https://raw.githubusercontent.com/pepperer/shelljs/master/dist/kae -o ${TEMP_FILE_PATH})
  tempCode=$(shasum -a 256 ${TEMP_FILE_PATH} | cut -f 1 -d " " )
  echo "远程文件的abs256值为: ${tempCode}"

  #remoteCode=$(echo ${content} | shasum -a 256 | cut -f 1 -d " " )
  #echo  "远程文件的abs256值为${remoteCode}"

  if [[ $code != $tempCode ]];then
  echo "当前版本不一致, 将开始进行更新。。。" 
    return 1
  fi
  echo "当前版本一致, 将不进行更新" 
  return 0
}



case $1 in
  'upload') 
  sh ./upload.sh
  ;;
  'grep')
  grep -En ${2} ./tuyasmart_appshell/tuyaDependence.gradle
  ;;
  'adb')
   sh ./android.sh "${2}"
  ;;
  ;;
  'help')
   help
  ;;
  'update')
  init
result=$?
if [[ ${result} -eq 1 ]];
then
  echo "开始更新"
  update
fi
  ;;
  *) 
  echo "当前为选择功能或该功能暂不支持"
  ;;
esac