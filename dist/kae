#!/usr/bin/env bash
### todo
# 1. sha256 检验更新
# 2. 创建.kae目录 以及config 目录和临时文件(用于和kae命令校验是否需要更新)

# 定义常量
# config的根目录
ROOT_DIR_PATH="${HOME}/.kae"
# config 文件路径
CONFIG_FILE_PATH="${ROOT_DIR_PATH}/config"
# 临时文件路径 用于和本地的kae做比较的
TEMP_FILE_PATH="${ROOT_DIR_PATH}/.temp"
# 脚本路径
KAE_FILE_PATH='/usr/local/kae/kae'

upload() {
  # 获取当前地址
  path=`pwd`
  # echo ${path}

  ##### 查看当前地址的setting 文件
  settingPath=${path}/settings.gradle
  # echo  settings.gradle路径为:${settingPath}

  # 判断setting 文件是否存在
  if [[ ! -f ${settingPath} ]]; then
    echo ${settingPath} NOT FOUND
    exit
  fi

  modules=`egrep -o '(:)([a-zA-Z_-]+)' ${settingPath}`

  # 测试答应结构
  # echo "数组的元素为: ${modules[*]}"


  targetModules=()
  for loop in ${modules[*]}
  do
    value=$(echo ${loop:1} | tr [A-Z] [a-z])    # 将name1全部转变成大写再做比较
    if [[ $value = "tuyasmart_appshell" ]]; then
       continue
    fi
    targetModules=(${targetModules[*]} ${value})
   # echo "${targetModules} The value is: ${value}"
  done

  # 测试答应结构
  echo '请输入你要上传模块对应的索引 ==> '
  select var in ${targetModules[*]}; do
  break;
  done

  echo "You have selected ${var} 模块"
  module=${targetModules[$index]}
  echo "执行的命令为 ===> ./gradlew ${var}:upload"
  cd ${var}
  ../gradlew upload
}

android() {
  # echo "输入的第1参数是: ${1}"
  # adb devices
  # devices=`adb devices | egrep -o '([A-a-ZZ0-9]+)'` 
  # echo $devices
  case $1 in
  'activity') 
    adb shell dumpsys window | grep mCurrentFocus
   ;;
   'layout-on') 
    adb shell setprop debug.layout true
    adb shell service call activity 1599295570 | echo
   ;;
   'layout-off')
    adb shell setprop debug.layout false
    adb shell service call activity 1599295570  | echo
   ;;
   *) echo "还不支持"
   ;;
  esac
}

help() {
  echo "当前支持的工功能有:"
  echo "kae upload           用户模块上传, 仅支持settings.gradle 带:的模块"
  echo "kae grep [module]    查看appshell匹配module的内容"
  echo "kae adb  [fubc]      支持部分adb操作:activity, layout-on, layout-off"
}

update() {
  echo "开始更新......"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/pepperer/shelljs/master/src/install.sh)"
  echo "更新结束"
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
  echo "当前版本一致, 将开始进行更新。。。" 
    return 1
  fi
  echo "当前版本一致, 将不进行更新" 
  return 0
}

init
echo $?
if [[ $? = 1 ]];then
  update
fi

case $1 in
  'upload') 
  upload
  ;;
  'grep')
  grep -En ${2} ./tuyasmart_appshell/tuyaDependence.gradle
  ;;
  'adb')
   android "${2}"
  ;;
  'version')
  echo 当前版本为0.0.3
  ;;
  'help')
   help
  ;;
  'update')
#  update
  ;;
  *) 
  echo "当前为选择功能或该功能暂不支持"
  ;;
esac