#!/usr/bin/env bash

#### 配置文件相关
ROOT_DIR_PATH="${HOME}/.kae"               # config的根目录
CONFIG_FILE_PATH="${ROOT_DIR_PATH}/config" # 配置文件路径


check(){
  echo "模块:$1;版本:$2"
}

# check 读取本地的配置文件
#origin=()
#while read LINES; do
#  KEY=$(echo "$LINES" | cut -f1 -d '/')
#  VALUE=$(echo "$LINES" | cut -f2 -d '/')
#  check $KEY $VALUE
#done < config

result=$(awk -F "/"  '
{
print NR "hello\n"
}' ./config)
echo ${result[*]}
echo ${#result[*]}


