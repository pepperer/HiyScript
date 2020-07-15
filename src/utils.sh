#!/usr/bin/env bash
# 工具类

echo_error() {
  echo -e "\e[31;1m${1}\e[1;1m"
}

echo_info() {
  echo -e "\e[32;1m ${1} \e[1;1m"
}

#
echo -e "\e[31;1mhelloword\e[1;1m"
echo_error '111'

#echo -e "\e[33;1m helloword \e[1;1m"
#echo -e "\e[34;1m helloword \e[1;1m"
#echo -e "\e[35;1m helloword \e[1;1m"
#echo -e "\e[36;1m helloword \e[1;1m"
#echo -e "\e[37;1m helloword \e[1;1m"

