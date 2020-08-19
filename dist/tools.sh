#!/usr/bin/env bash

date2Time() {
  time_pattern="^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}"
  os_platform=$(uname -s)
  echo 111
  if [[ $# -le 0 ]]; then
    echo "默认按照当前时间向后5min取值"
    if [[ "${os_platform}" = "Darwin" ]]; then
      echo $(date -v+5M +%s)000
    elif [[ "${os_platform}" = "Linux" ]]; then
      echo $(date -d +5min +%s)000
    fi
  else
    case $1 in
    -h | --help)
      usage
      ;;
    *)
      dateStr=${1}
      echo ${dateStr}
      if [[ "${dateStr}" =~ ${time_pattern} ]]; then
        echo 111
        if [[ "${os_platform}" = "Darwin" ]]; then
          echo $(date -j -f "%Y-%m-%d %H:%M:%S" "${dateStr}" +%s)000
        elif [[ "${os_platform}" = "Linux" ]]; then
          echo $(date -d "${dateStr}" +%s)000
        fi
      else
        echo "时间格式不正确，请按照'%Y-%m-%d %H:%M:%S'格式输入，如'2017-01-01 16:00:00' "
      fi
      ;;
    esac
  fi
}

time2Date() {
  #!/bin/sh

  function usage() {
    echo "-h --help \n" \
      "  将10/13位时间戳转换为本地时间 \n" \
      "  参数：时间戳，支持10/13位两种 \n" \
      "  默认值：当前时间向后5min \n" \
      "  e.g. 1483430400(10位秒时间戳),1483430400000(13位毫秒时间戳) \n"
    exit 1
  }

  ###
  os_platform=$(uname -s)
  if [[ $# -le 0 ]]; then
    echo "默认按照当前时间向后5min取值"
    if [[ "${os_platform}" = "Darwin" ]]; then
      echo $(date -v+5M +"%Y-%m-%d %H:%M:%S")
    elif [[ "${os_platform}" = "Linux" ]]; then
      echo $(date -d +5min +"%Y-%m-%d %H:%M:%S")
    fi
  else
    case $1 in
    -h | --help)
      usage
      ;;
    *)
      timestampStr=${1}
      length=$(echo ${#timestampStr})
      if [[ ${length} -ne 10 ]] && [[ ${length} -ne 13 ]]; then
        echo "请输入10/13位数字时间戳"
        exit 1
      elif [[ ${length} -eq 13 ]]; then
        timestampStr=${timestampStr:0:10}
      fi
      echo "时间戳位：${timestampStr}"
      if [[ "${os_platform}" = "Darwin" ]]; then
        dateStr=$(date -r${timestampStr} +"%Y-%m-%d %H:%M:%S")
      elif [[ "${os_platform}" = "Linux" ]]; then
        dateStr=$(date -d @${timestampStr} +"%Y-%m-%d %H:%M:%S")
      fi
      echo "${1}对应的本地时间为${dateStr}"
      ;;
    esac
  fi
}

str2Base64() {
  base=$(base64 <<<${1})
  echo "base值: $base"
}

base642Str() {
  base=$(base64 -D <<<${1})
  echo "原值: $base"
}

tools() {
  # echo "tools" ${1}

  targetModules=("时间转日期" "日期转时间" "Base64编码" "Base64解码")
  echo '请输入你要上传模块对应的索引 ==> '
  select module in ${targetModules[*]}; do
    echo "选择了${module}"
    case $module in
    '时间转日期')
      time2Date "${1}"
      ;;
    '日期转时间')
      date2Time "${1}"
      ;;
    'Base64编码')
      str2Base64 "${1}"
      ;;
    'Base64解码')
      base642Str "${1}"
      ;;
    *)
      echo '当前暂时不支持'
      ;;
    esac
    break
  done

}
