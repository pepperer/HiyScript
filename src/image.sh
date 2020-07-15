#!/usr/bin/env bash

handleImage() {
  echo "你输入的功能为 ${1} ${2}"
  cd ../res/
  files=$(ls ./*.png) # 需要扩展
  if [ $? -eq 1 ]; then
    echo "当前目录下没有png图片"
    exit
  fi

  #  for i in ./*.png; do sips -Z 1000 "${i}"; done

  #  for j in $files; do
  #    echo 当前文件为${j}
  #  done
  #  echo $files | awk '{print "sips -Z 300 " $0 } '| bash
  #  sips -Z 500 $files

  case $1 in
  'Z')
    :
    echo "开始缩放$files"
    sips -Z ${2} $files | echo '缩放结束'
    ;;
  'jpg')
    :
    echo "开始转格式$files"
    output=$(echo $files | tr png jpg)
    echo "$output"
    sips -s format jpeg $files
    echo $files | awk {print mv ${0} }
    mv $files $output
    ;;
  esac

}

export handleImage
