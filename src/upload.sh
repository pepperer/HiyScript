#!/usr/bin/env bash
# 获取当前地址
ROOT_PATH=$(pwd)
##### 查看当前地址的setting 文件
SETTING_PATH="${ROOT_PATH}/settings.gradle"

# 1. 判断setting 文件是否存在
if [[ ! -f ${SETTING_PATH} ]]; then
  echo "${SETTING_PATH} 没找到"
  exit
fi

# 2. 匹配
modules=$(egrep -o '(:)([a-zA-Z_-]+)' "${SETTING_PATH}")
echo "匹配的状态为${?}, 说明， 0 标示搜索成功  1标示失败  2 标示文件不存在"

if [[ ${?} -eq 1 ]]; then
  echo "匹配失败, 没有找到可以上传的模块， 请手动上传"
  exit 1
elif [[ $? -eq 2 ]]; then
  echo "未找到${SETTING_PATH}, 请检查路径"
  exit 1
fi

# 开始上传
targetModules=()
for loop in ${modules[*]}; do
  value=$(echo "${loop:1}" | tr [A-Z] [a-z]) # 将name全部转变成大写再做比较
  if [[ $value = "tuyasmart_appshell" ]]; then
    continue
  fi
  targetModules=(${targetModules[*]} ${value}) # 扩展函数
  # echo "${targetModules} The value is: ${value}"
done

# 测试答应结构
echo '请输入你要上传模块对应的索引 ==> '
select module in ${targetModules[*]}; do
  pwd
  echo "You have selected ${module} 模块"
  echo "执行的命令为 ===> ./gradlew ${module}:upload"
  cd "${module}" || exit #  如果没有找到目录的话  则推出当前的目录
  ../gradlew upload      # 执行
  cd ..
done
