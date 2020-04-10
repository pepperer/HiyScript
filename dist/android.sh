#!/usr/bin/env bash

android() {
  # 说明, 所有逻辑都是参考https://github.com/dhelleberg/android-scripts
  content=$(adb devices | egrep 'device$') #获取到当前的设备
  status=${?}
  #echo "状态为${status}, 匹配的内容为：\n${content}"

  if [ $status -ne 0 ]; then
    echo "未找到设备, 请检查是否连接成功"
    exit 1
  fi

  #rows=$(echo "${content}" |awk 'END{print NR}') # END中输出的总行数
  rows=$(echo "$content" | wc -l)
  #echo "行数为 $rows"

  if [[ $rows -ne 1 ]]; then
    echo '当前连接数 > 1, 暂时不支持多设备操作'
    exit 1
  fi

  #echo "前面逻辑可以了"

  deviceCode=$(echo "${content}" | cut -f 1)
  echo "设备号为 ${deviceCode}"

  echo "当前输入的第一个参数为${1}"
  case $1 in
  'top')
    #  adb -s ${deviceCode} shell dumpsys activity | grep mResumedActivity:
    adb -s ${deviceCode} shell dumpsys window | grep mCurrentFocus
    #  adb -s ${deviceCode} shell dumpsys activity | grep mFocusedActivity
    ;;
  'layout-on')
    adb -s ${deviceCode} shell setprop debug.layout true
    ;;
  'layout-off')
    adb -s ${deviceCode} shell setprop debug.layout false
    ;;
  'over-on')
    adb -s ${deviceCode} shell setprop debug.hwui.overdraw show
    ;;
  'over-off')
    adb -s ${deviceCode} shell setprop debug.hwui.overdraw false
    ;;
  *)
    echo "还不支持"
    exit 1
    ;;
  esac
  # 用于生效
  adb -s ${deviceCode} shell service call activity 1599295570 | echo
}

export android
