#!/usr/bin/env bash
#for mac
CONFIG_DIR_PATH="../res"
#for window
#CONFIG_DIR_PATH="C:\Users\Administrator\Desktop\Philip_Android"

CONFIG_PATH="${CONFIG_DIR_PATH}/config"

if [[ "$(uname)" == "Darwin" ]]; then
  CONFIG_DIR_PATH="../res"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  return
elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
  CONFIG_DIR_PATH="C:\Users\Administrator\Desktop\Philip_Android"
fi

# 开始同步
kaeSync() {
  echo "开始 ==>: ${1} ${2} "
  gitName=$(echo ${1} | egrep -o "[0-9A-Za-z_-]+.git")
  dirName=($(echo ${gitName} | egrep -o "[0-9A-Za-z_-]+"))
  pwd
  git clone "${1}"
  cd ${dirName[0]}
  pwd
  git fetch origin "${2}"
  git checkout "${2}"
  cd ..
  echo "结束 ==> ${1}\n\n"
}

# 进入目标目录
cd ${CONFIG_DIR_PATH}
# 读取
while read line || [[ -n ${line} ]]; do
  url=$(echo $line | cut -f1 -d " ")
  branch=$(echo $line | cut -f2 -d " ")
  if [[ ${url} ]]; then
    kaeSync $url $branch
  fi
done <${CONFIG_PATH}
