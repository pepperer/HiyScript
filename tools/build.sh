#!/usr/bin/env bash

##
#### 需要重构 ===> 编译 + 自动上传  现在github cache-control 5 分钟的缓存已经取改为0分了

pwd
cp -f ./src/kae.sh ./dist/kae
chmod 555 ./dist/kae

cp -f ./src/kae.sh ./dist/kae.sh
cp -f ./src/upload.sh ./dist/upload.sh
cp -f ./src/android.sh ./dist/android.sh
cp -f ./src/position.sh ./dist/position.sh
cp -f ./src/upgrade.sh ./dist/upgrade.sh
cp -f ./src/vsc.sh ./dist/vsc.sh
cp -f ./src/init.sh ./dist/init.sh
cp -f ./src/tools.sh ./dist/tools.sh

cp -f ./tools/install.sh ./dist/install.sh
cp -f ./tools/uninstall.sh ./dist/uninstall.sh



#chmod 555 ../dist/kae-upload
