#!/usr/bin/env bash

#### 配置文件相关
# config的根目录
ROOT_DIR_PATH="${HOME}/.kae"
# 版本配置文件
VERSION_CONFIG_PATH="${ROOT_DIR_PATH}/config"
# 配置文件
GIT_CONFIG_PATH="${ROOT_DIR_PATH}/git_config"
# 环境配置文件
ENV_CONFIG_PATH="${ROOT_DIR_PATH}/env_config"


initKaeRoot() {
  if [[ ! -d ${ROOT_DIR_PATH} ]]; then
       echo "kea 配置根目录开始构建"
       mkdir "${}"
     else
      echo "kea 配置根目录已生成"
 fi
}

initEnvConfig() {
 if [[ ! -f ${ENV_CONFIG_PATH} ]]; then
    touch "${ENV_CONFIG_PATH}"
    echo 'env=dev' > "${ENV_CONFIG_PATH}"
  else
    echo "环境配置文件已生成"
  fi
}

initVersionConfig() {
   if [[ ! -f ${VERSION_CONFIG_PATH} ]]; then
    touch "${VERSION_CONFIG_PATH}"
  else
    echo "版本配置文件已生成"
  fi
}

initGitConfig() {
   if [[ ! -f ${GIT_CONFIG_PATH} ]]; then
    touch "${GIT_CONFIG_PATH}"
  else
    echo "git配置文件已生成"
  fi
}

initKae() {
#  initKaeRoot
#  initEnvConfig
  initVersionConfig
  initGitConfig
}

export initKae
