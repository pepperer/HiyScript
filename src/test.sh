#!/usr/bin/env bash
echo "$@"
while getopts ":a:bc:" opt; do #不打印错误信息, -a -c需要参数 -b 不需要传参  
  case $opt in
    a)
      echo "-a arg:$OPTARG index:$OPTIND" #$OPTIND指的下一个选项的index
      ;;
    b)
      echo "-b arg:$OPTARG index:$OPTIND"
      ;;
    c) 
      echo "-c arg:$OPTARG index:$OPTIND"
      ;;
    :)
      echo "Option -$OPTARG requires an argument." 
      exit 1
      ;;
    ?) #当有不认识的选项的时候arg为?
      echo "Invalid option: -$OPTARG index:$OPTIND"
      ;;
    
  esac
done
