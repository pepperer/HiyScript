#!/usr/bin/env bash

#publish2Cloud() {
#  cd $1
  git status
  git add .
  git commit -m '这是一次简单的发布'
  git pull
  git push
#}
#
#GIT_CONFIG_PATH="${HOME}/.kae/git"
#
#while read line || [[ -n ${line} ]]; do
# publish2Cloud ${line}
#done <${GIT_CONFIG_PATH}
