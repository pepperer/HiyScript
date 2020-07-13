#!/usr/bin/env bash

VIDEO_PATH='/Users/zhishui/Downloads/black.mp4'
pwd
rm -r ../output
mkdir ../output
cd ../output

# 
# ffmpeg -i ${VIDEO_PATH}  a.flv


#### 视频截图
# ffmpeg -i ${VIDEO_PATH} -ss 00:01:37 -f image2 -vframes 5 b-%3d.png

#### ffplay
# ffplay ${VIDEO_PATH}

##### 视频
# ffmpeg -i ${VIDEO_PATH} -vcodec copy -an a.mp4

##### 视频信息
ffmpeg -i /Users/zhishui/Downloads/black.mp4