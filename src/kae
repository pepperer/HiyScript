#!/usr/bin/env bash
#
#function check(){
#    local a="$1"
#    printf "%d" "$a" &>/dev/null && echo "integer" && return
#    printf "%d" "$(echo $a|sed 's/^[+-]\?0\+//')" &>/dev/null && echo "integer" && return
#    printf "%f" "$a" &>/dev/null && echo "number" && return
#    [ ${#a} -eq 1 ] && echo "char" && return
#    echo "string"
#}
#
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

# 代码开始的地方
# echo $1 $2
if [[ 'upload' = $1 ]]
then
   upload
elif  [[ 'grep' = $1  ]]
then
  echo "请选择当前有的功能: ${2}"
  grep -En ${2} ./tuyasmart_appshell/tuyaDependence.gradle
elif [[ 'adb' = $1 ]]
then
  android "${2}"
elif [[ 'version' = $1 ]]
then
  echo 当前版本为0.0.3
  elif [[ 'help' = $1 ]]
then
 help
else
  echo "不支持当前命令"
fi
