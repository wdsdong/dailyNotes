#Xcode Search Paths相关配置

> Target -> Build Setting -> Search Paths

**存在以下四个路径：**

1.	Framework Search Paths 管理导入的 *.framework 的路径

2.	Library Search Paths 管理导入的 *.a 的路径
 
3.	User Header Search Paths 管理导入的头文件的路径

4.	Header Search Paths 管理导入的头文件的路径

```
2 和 4 的区别
引入头文件时，<>只从`Header Search Paths`搜索，而“”则能从搜索
`Header Search Paths` 和 `User Header Search Paths`

具体一点的区别是，<> 是从系统目录空间 （对应 Header Search Paths）
中搜索文件， "" 是从用户目录空间（对应 User Header Search Paths）
中搜索文件。如果你把路径加到 User Header Search Paths 中，而 <> 
无法从系统目录空间中找到新加的路径，从而报错
```

**路径相关参数说明**

*	`$(SRCROOT)` / `$(PROJECT_DIR)` 基本没啥区别，都是指向
	`*.xcodeproj`	所在的路径

*   通过../来调到上一层路径,返回上上层文件夹用../../

*	recursive：遍历该目录，non-recursive：默认路径设置；不遍历该目	录。如果路径的属性为recursive，那么编译的时候在找库的路径的时候，会	遍历该目录下的所有子目录的库文件。

*	$(inherited) ：`Target` 的 Framework Search Paths添加`$	(inherited)`参数会从`PROJECT -> Build Settings -> Framework 	Search Paths`里面的路径会被其继承，没有的话不会继承。
