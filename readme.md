# shelljs


目前支持的功能有：（建议 安装 on my zsh 插件使用 可以记录之前使用过的命令）

kae upload ： 和./gradlew login:upload功能一致
kae grep [name] : 打印出匹配到name的行 ，
kae adb [functiton]
kae adb activity ： 查看顶部activity
kae abd layout-on: 打开边界布局
kae adb layout-off:  关闭边界布局
安装
自动档：
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/pepperer/shelljs/master/src/install.sh)"
手动档
下载 https://github.com/pepperer/shelljs/blob/master/dist/kae

添加可执行权限: chmod 555 kae

手动添加kae文件到/usr/local/bin/kae