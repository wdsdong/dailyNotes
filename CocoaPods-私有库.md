##使用 CocoaPods 创建私有库


###1. 创建 Spec Repo 管理我们创建的所有 pod spec

注：查看本地的 cocoapods 文件目录路径：`~/.cocoapods/repos`

1. 在 gitlab 上建立一个 DSSpec 项目（管理所有的 pod spec 文件）

2. 终端执行命令 clone 远程的 DSSpec

		# pod repo add [Private Repo Name] [GitHub HTTPS clone URL]
		
		pod repo add DSSpec git@192.168.50.20:wangdongsheng/DSSpec.git

此时查看本地`~/.cocoapods/repos`路径就会发现 DSSpec 文件夹已经存在


###2. 创建准备制作成 podspec 的项目

1. 在 gitlab 上创建 DSSDK 项目

2. cd 进入到要创建项目的目录， 然后终端执行以下命令创建工程
		
		# pod lib create [项目名]

		pod lib create DSSDK
	接着在控制台就会输出以下几个问题让你来回答：

		2.1选择使用语言
		
		What language do you want to use?? [ Swift / ObjC ]

		> ObjC
		
		2.2问你是否需要创建一个Demo项目，我选的是Yes
		
		Would you like to include a demo application with your library? [ Yes / No ]
		
		> Yes
		
		2.3让你是否选择一个测试框架，选 None
		
		Which testing frameworks will you use? [ Specta / Kiwi / None ]
		
		> None
		
		2.4是否基于View测试，选Yes
		
		Would you like to do view based testing? [ Yes / No ]
		
		> yes
		
		2.5类的前缀
		
		What is your class prefix?
		
		> DS
		
	完成以上的问题后控制台会输出以下信息 ，然后自动打开所创建的项目

		
3. 提交本地的 DSSDK 到远端仓库

		git add .
		git commit -s -m 'init'
		git remote add origin git@192.168.50.20:wangdongsheng/DSSDK.git  #添加远端仓库
		git push origin master     #提交到远端仓库
		git tag -m "first release" 0.1.0
		git push --tags     #推送tag到远端仓库

###3. 创建并提交 DSSDK 库的 pod spec 文件到私有仓库

1. 配置 pod spec 文件信息

		Pod::Spec.new do |s|
		s.name             = 'DSSDK' #名称
		s.version          = '0.1.0' #版本号
		s.summary          = 'DSSDK by DS.' # 简介
		  
		s.description      = <<-DESC        #描述
		TODO: Add long description of the pod here.
		                   DESC
			
		s.homepage         = 'http://192.168.50.20:9988/wangdongsheng/DSSDK.git'  #主页，这里要填写可以访问到的地址，不然验证不通过
		s.license          = { :type => 'MIT', :file => 'LICENSE' }
		s.author           = { 'wdsdong' => 'wangdongsheng@julong.cc' }
		  
		s.source           = { :git => 'http://192.168.50.20:9988/wangdongsheng/DSSDK.git', :tag => s.version.to_s }  #项目地址，这里不支持 ssh的地址，最好使用 https
			
		s.ios.deployment_target = '8.0'
			
		s.subspec 'DSTools' do |sp|
		  sp.source_files = 'DSSDK/Classes/DSTools/*' #代码源文件地址
		  # sp.public_header_files = 'DSSDK/Classes/**/*.h' #公开头文件地址
		end
		s.frameworks = 'UIKit', 'MapKit' #所需的 framework，多个用逗号隔开
		
		# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
		# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

		# s.resource_bundles = {
		#   'DSSDK' => ['DSSDK/Assets/*.png']
		# }
			
		# s.public_header_files = 'Pod/Classes/**/*.h'
		# s.dependency 'AFNetworking', '~> 2.3' #依赖关系，改项目所依赖的其他库，如果有多个需要填写多个是。dependency
		end

2. 验证 podspec 文件

	`pod lib lint`
	
	`pod lib  lint --allow-warning`
	
3. 向 spec repo 提价 pod spec ，也就是把 DSSDK.podspec 提交到元层仓库 DSSpec

		pod repo push [Repo 名] [podspec 文件名字]
		
		pod repo push DSSpec DSSDK.podspec
		
成功后，在`~/.cocoapods/repos/DSSpec`目录下就存在了我们创建的 pod sepc 文件

###4. 使用 pod私有库

在 podfile 中配置如下

	source 'https://github.com/CocoaPods/Specs.git'  # 官方库，若是还使用了共有的 pod库，需要把公有库地址也带上
	source  'git@192.168.50.20:wangdongsheng/DSSpec.git' #我们的私有库
	
###5. 更新 pod 私有库

1. 修改替换库中文件
2. 修改 DSSDK.podspec 文件，修改 version，目录结构
3. 打 tag，并上传 tag
4. 验证 `pod lib lint --allow-warnings`
5. 上传 `pod repo push DSSpec DSSDK.podspec`