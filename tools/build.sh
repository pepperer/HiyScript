#!/usr/bin/env bash

cp -f ../src/kae.sh ../dist/kae
chmod 555 ../dist/kae

cp -f ../src/daily.sh ../dist/daily
chmod 555 ../dist/dailyDo

cp -f ../src/kae.sh ../dist/kae.sh
cp -f ../src/upload.sh ../dist/upload.sh
cp -f ../src/android.sh ../dist/android.sh
cp -f ../src/position.sh ../dist/position.sh
cp -f ../src/upgrade.sh ../dist/upgrade.sh

#chmod 555 ../dist/kae-upload
