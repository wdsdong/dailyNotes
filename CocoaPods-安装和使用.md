##CocoaPods的安装和使用教程

###什么是 CocoaPods?
CocoaPods 是专门为 iOS 工程提供对第三方库的依赖的管理工具。

###安装 CocoaPods

1. 首先更新 gem 到最新版本
	`sudo gem update --system`
	
2. 删除自带的 ruby 镜像
	`gem sources --remove https://rubygems.org/`
	
3. 添加淘宝的镜像
	`gem sources -a https://gems.ruby-china.org/`
	
4. 检查镜像替换成功 `gem sources -l`

5. 安装 CocoaPods `sudo gem install cocoapods`

6. 配置 CocoaPods `pod setup` 

###查找第三方库

`pod search AFNetworking`

`退出 :wq`

###引入第三方库到项目中

1. 新建 Test项目

2. cd 到 Test 路径下

3. `vim Podfile`生成 Podfile 文件，编辑至如下格式： 
	
		platform :ios,'8.0'
		target 'Test' do
		pod 'MJExtension', '~> 3.0.13'
		end
4. 安装 `pod install`
5. 双击 Test.xcworkspace 打开工程

###使用第三方

解决 import没有提示：在工程的Build Settings搜索Search，然后在User header search paths中添加$(SRCROOT)并选择recursive

###增加新的第三方

在 Podfile 里添加，再执行 pod install

###更新 CocoaPods中的第三方

`pod update` 或者 `pod install`

###删除 CocoaPods 中的第三方

`pod update` 或者 `pod install`

注：如果遇到pod install或者pod update慢的问题，原因在于当执行以上两个命令的时候会升级CocoaPods的spec仓库，加一个参数可以省略这一步，然后速度就会提升不少。加参数的命令如下：
pod install --verbose --no-repo-update
pod update --verbose --no-repo-update

###升级 CocoaPods
`sudo gem install cocoapods`


###卸载 CocoaPods
`sudo gem uninstall cocoapods`

###CocoaPods Mac App 的安装和使用

[CocoaPods桌面应用版下载地址](https://cocoapods.org/app)

注意：Cocoapods.app 删掉并执行命令可能会报错：Unable to locate the CocoaPods.app application bundle. Please ensure the application is available and launch it at least once

这时候只要执行sudo gem install -n /usr/local/bin cocoapods命令就可以了。
