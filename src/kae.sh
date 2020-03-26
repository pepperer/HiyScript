#!/usr/bin/env bash
### todo
# 1. sha256 检验更新
# 2. 创建.kae目录 以及config 目录和临时文件(用于和kae命令校验是否需要更新)



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



# 代码开始的地方
# echo ${*}
# echo ${HOME}
configPath="${HOME}/.kae"
tempPath="${HOME}/.kaetemp"
if [[ ! -f $configPath ]]
then
  touch configPath
  echo "version:1.0.0" >> $configPath
fi
localVersion=$(grep -i version ${configPath} | cut -f 2 -d :)
echo "当前版本为$localVersion"

code=$(shasum -a 256 ${configPath} | cut -f 1 -d " " )
echo "当前文件的abs256值为${code}"

content=$(curl -fsSL https://raw.githubusercontent.com/pepperer/shelljs/master/dist/kae -o ${tempPath})

tempCode=$(shasum -a 256 ${tempPath} | cut -f 1 -d " " )
echo "临时文件的abs256值为${code}"


remoteCode=$(echo ${content} | shasum -a 256 | cut -f 1 -d " " )
echo  "远程文件的abs256值为${remoteCode}"

if [[ $code != remoteCode ]]
then
echo "当前版本非最新版本么, 将进行更新" 
update
echo "继续下一步"
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
  echo 还不支持
  ;;
esac