## 1. 脚本说明（若安装的脚本没该功能 可能代码还未上传）

该脚本主要功能有
- adb操作部分集合
- 批量git操作



## 2. 安装

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/pepperer/Whale-fall/master/tools/install.sh)"
```


### 3.4 Android 布局边界的打开和关闭

- ` kae adb [layout-on/layout-off]`
  - `layout-on` : 打开布局边界
  - `layout-off`: 关闭布局边界

### 3.5 Android 过度绘制开启

- `kae adb [over-on/over-off]`
  - `over-on`: 打开过度绘制
  - `over-off` : 关闭过度绘制



### 4.通用功能

### 4.1  批量 git版本管理（推荐个人非重要项目使用）

#### 4.1.1 注册git项目到配置文件

- `kae vsc register`

#### 4.1.2 从配置文件中注销git项目

- `kae vsc register`

#### 4.1.3. 查看配置文件

- `kae vsc cat`

#### 4.1.4 批量查看项目git 状态

- `kae vsc status`
#### 4.1.5 快捷提交一个项目
- `kae vsc pushOnce`

#### 5 通用工具
- `kae tools [输入的内容]`
  - 会出现选择的功能【时间戳互相转换， base互相转换】， 后续可以加入其他功能

