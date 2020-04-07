#!/usr/bin/env bash
# 功能介绍：查看内容所在行数

echo "需要查看的内容关键字是: ${1}"

content=$(grep -En "${1}" ./tuyasmart_appshell/tuyaDependence.gradle)
status=$?
if [[ $status -ne 0 ]]; then
  echo "没有找到的匹配的内容, 请确认内容是否存在"
fi

echo "${content}"
