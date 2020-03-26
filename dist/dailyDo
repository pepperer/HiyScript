#!/usr/bin/env bash


git_serial() {
  echo  "当前操作的模块为$1"
  cd $1
  git add .
  git commit -m "日常提交"
  git pull
  git push
}
# cd 项目的根目录
root="/Users/zhishui/sync"
git_serial "${root}/Itachi"
git_serial "${root}/TuyaO"


