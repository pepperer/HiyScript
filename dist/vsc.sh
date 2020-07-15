#!/usr/bin/env bash
# 功能介绍: 在配置文件中 注册git 和 删除git 地址
# >是覆盖，>>是追加。

GIT_CONFIG_PATH="${HOME}/.kae/git"

checkCondition() {
  if [[ ! -f ${HOME}/.kae/git ]]; then
    touch ${HOME}/.kae/git
  fi

  return 0
}

clear() {
  : >$GIT_CONFIG_PATH
}

isExist() {
  ret=$(egrep -c "${curPath}" "${GIT_CONFIG_PATH}")
  echo "匹配到的行数有： $ret"
  if [[ ${ret} -gt 0 ]]; then
    echo "当前目录已注册"
    return 200
  else
    echo "当前目录未注册"
    return 201
  fi
}

isGitP() {
  curPath=$(pwd)
  if [[ ! -d "${curPath}/.git" ]]; then
    return 201
  else
    return 200
  fi
}

registerGitPath() {
  checkCondition
  isGitP
  ret=$?
  if [[ $ret -gt 200 ]]; then
    echo "当前项目不是git项目"
    return
  fi

  isExist

  ret=$?
  echo "判断结果： $ret"

  if [[ $ret -eq 200 ]]; then
    echo "当前目录已注册2"
    return $ret
  fi

  echo ${curPath} >>"${GIT_CONFIG_PATH}"
  return 0
}

unRegisterGitPath() {
  checkCondition
  echo 'unRegister'

  isGitP
  ret=$?
  if [[ $ret -gt 200 ]]; then
    echo "当前项目不是git项目的根目录"
    return
  fi

  isExist

  ret=$?
  echo "判断结果： $ret"

  if [[ $ret -ne 200 ]]; then
    echo "当前目录未注册2"
    return $ret
  fi

  curPath=$(pwd)
  echo 当前路径${curPath}
  # 字符串替换 转义问题
  curPath=${curPath//\//\\/} #
  echo 当前路径${curPath}

  # 开始清除 由于是危险操作 需要添加备份文件
  sed -i "_back" "/${curPath}/d" ${GIT_CONFIG_PATH}
}

gitStatusItem() {
  cd $1
  ret=($(git status -s))
  length=${#ret[*]}
  if [[ ${length} -eq 0 ]]; then
    cherry=($(git cherry -v))
    if [[ ${#cherry[*]} -eq 0 ]]; then
      echo "${1}项目：当前状态完美"
    else
      echo "${1}项目：当前有代码-未push，请查收"
    fi
  else
    echo "${1}项目：当前有代码-待提交, 请查收"
  fi
}

gitPush() {
  while read line || [[ -n ${line} ]]; do
    cd $line
    pwd
    git add .
    git commit -m '日常提交'
    git pull
    git push
  done <${GIT_CONFIG_PATH}
}

gitStatus() {
  while read line || [[ -n ${line} ]]; do
    gitStatusItem ${line}
  done <${GIT_CONFIG_PATH}
}

# 查看结果
#echo "测试, 先清除配置文件中的内容"
#clear

#cd ${HOME}/sync/itachi

#registerGitPath
#unRegisterGitPath

vsc() {
  echo "当前输入功能为:${1} "
  echo

  case $1 in
  'register')
    registerGitPath
    #    cat $GIT_CONFIG_PATH
    ;;
  'unRegister')
    unRegisterGitPath
    #    cat $GIT_CONFIG_PATH
    ;;
  'cat')
    cat $GIT_CONFIG_PATH
    ;;
  'status')
    gitStatus
    ;;
  'push_lsd')
    gitPush
    ;;
  *)
    echo "当前为选择功能或该功能暂不支持"
    ;;
  esac
}

#vsc ${1}

#echo "\n\n开始查看结果 == >>>>"
#cat $GIT_CONFIG_PATH

export vsc
