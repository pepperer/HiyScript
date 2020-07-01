#!/usr/bin/env bash

target_host=arm-linux-androideabi
export AR=$target_host-ar
export AS=$taret_host-clang
export CC=$target_host-clang++
export LD=$target_host-ld
export STRIP=$target_host-strip

ADDI_CFLAGS="-marm"
API=21
PLATFORM=arm-linux-androideabi
CPU=armv7-a
# NDK=/Users/zhishui/Library/Android/sdk/ndk/android-ndk-r10e # 修改成自己本地的ndk路径。
NDK=/Users/zhishui/Library/Android/sdk/ndk/17.2.4988734 # 修改成自己本地的ndk路径。
SYSROOT=$NDK/platforms/android-$API/arch-arm/
ISYSROOT=$NDK/sysroot
ASM=$ISYSROOT/usr/include/$PLATFORM
#TOOLCHAIN=$NDK/toolchains/$PLATFORM-4.9/prebuilt/darwin-x86_64
TOOLCHAIN=/tmp/my-android-toolchain
FFMPEG_D_PATH=/Users/zhishui/ffmpegPro/ffmpeg-4.2.3
OUTPUT=/Users/zhishui/ffmpegPro/android #自己指定一个输出目录，用来放生成的文件的。

function build
{
  pwd
./configure \
--prefix=$OUTPUT \
--enable-shared \
--disable-static \
--disable-doc \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-avdevice \
--disable-doc \
--disable-symver \
--pkg-config=/usr/local/bin/pkg-config \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--cc=$TOOLCHAIN/bin/arm-linux-androideabi-gcc \
--nm=$TOOLCHAIN/bin/arm-linux-androideabi-nm \
--target-os=android \
--arch=arm \
--enable-cross-compile \
--enable-cross-compile \
--sysroot=$SYSROOT \
--extra-cflags="-I$ASM -isysroot $ISYSROOT -Os -fpic -marm" \
--extra-ldflags="-marm" \
$ADDITIONAL_CONFIGURE_FLAG
  make clean
  make 
  make install
}

cd $FFMPEG_D_PATH
build