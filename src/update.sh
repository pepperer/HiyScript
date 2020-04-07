#!/usr/bin/env bash

#### 配置文件相关
ROOT_DIR_PATH="${HOME}/.kae"               # config的根目录
CONFIG_FILE_PATH="${ROOT_DIR_PATH}/config" # 配置文件路径

upgrade() {
  echo "更新模块${1}"
#  sh ./install.sh
}

check() {
  echo "模块:$1;版本:$2"
  remote_content=$(curl -s https://raw.githubusercontent.com/pepperer/Whale-fall/master/src/config)
  version=$(echo "$remote_content" | grep "${1}" | cut -f2 -d "/")

  echo "获得的结果是: $1 ==>  $2 == $version"
  if [[ $2 -ne $version ]]; then
    upgrade $1
  else
    echo  "$1 当前为最新版本"
  fi

}

# 开始
while read LINES; do
  KEY=$(echo "$LINES" | cut -f1 -d '/')
  VALUE=$(echo "$LINES" | cut -f2 -d '/')
  check $KEY $VALUE
done <config
