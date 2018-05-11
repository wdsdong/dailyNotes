##Xcode 控制台调试命令

控制台调试命令前缀为 `lldb`

在 Debug 模式下，如果你的程序在运行中崩溃（Crash）掉，或者你添加了断点（Deactivate breakpoints）

* `p`
	>如果查看基本数据，返回基本数据类型的值；如果查看对象，则返回对象的指针地址
	
	>`p int`

* `po`
	> 打印对象
	
	>`po s`
	
*	`expression`

	>动态修改变量的值
	
	>expression s = @"wdsdong"

*  call

	>动态调用函数
	
	>call [self test];

* 	bt 

	>打印线程的堆栈信息
	
	>bt
	
*	`image lookup --address 0x0000XXXXX`
	
	>快速查看 crash 位置
	
	>image lookup --address 0x000000010b9ce919
	
*	断点
	
	1. 全局断点
	2. 局部断点
	3. 条件断点
	4. 符号断点

*	僵尸对象模式