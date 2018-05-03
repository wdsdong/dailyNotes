#RunLoop

###一、RunLoop 简介

**运行循环**

>一般来讲，一个线程一次只能执行一个任务，执行完成后线程就会退出。  
本质上是一个 do-while 循环，这种模型通常被称作 EventLoop。  
关键在于：如何管理消息/事件，如何让线程在没有处理消息时休眠以避免占用资源，在有消息时立刻被唤醒

###二、NSRunLoop 与 CFRunLoopRef

>CFRunLoopRef 是在 CoreFoundation框架内的，它提供了纯 C 函数的 API，所以这些 API 都是线程安全的

>NSRunLoop 是基于 CFRunLoopRef 的封装，提供了面向对象的 API，但是这些 API 都不是线程安全的

###三、RunLoop 与线程的关系

线程和 RunLoop 之间是一一对应的，其关系保存在一个全局的 Dictionary 里，线程为 key，RunLoop 为 value  

除主线程外，RunLoop 的创建发生在第一次获取时，销毁是在线程结束时，并且只能在线程内部获取其RunLoop  

主线程 RunLoop 自动创建，其他线程需要手动获取，否则不创建

###四、RunLoop 对外的接口

在 CoreFoundation 里面关于 RunLoop 有5个类  

```
CFRunLoopRef 

CFRunLoopModeRef 

CFRunLoopSoureRef ：事件产生
 
CFRunLoopTimerRef ：基于时间的触发器

CFRunLoopObserverRef ：观察者
```

一个 RunLoop 包含若干个 Mode,每个 Mode 又包含若干个 Source/Timer/Observer。每次调用 RunLoop 的主函数时，只能指定其中一个 Mode，这个 Mode 被称为 CurrentMode。如果需要切换 Mode，只能退出 Loop,在重新指定 Mode 进入。这样做主要是为了分割开不同组的 Source/Timer/Observer，让其互不影响。

###五、RunLoop 的 Mode
```
NSDefaultRunLoopMode : App默认 Mode,通常主线程在这个 Mode

UITrackingRunLoopMode : 追踪 ScrollView 滑动的状态

NSRunLoopCommonModes = NSDefaultRunLoopMode + UITrackingRunLoopMode
```
###六、RunLoop 使用

1. AutoreleasePool

	App启动后，苹果会在主线程 RunLoop 里注册两个 Observer，其回		
	调都	是`_warpRunLoopWithAutoreleasePoolHandler()`
		
	>第一个 Observer监视一个事件： Entry
	>>Entry（即将进入 Loop），其回调内会调用_objc_autoreleasePoolPush()创建自动释放池，优先级最高，保证创建释放池发生在其他所有回调之前
		
	>第二个 Observer 监视两个事件：BeforeWaiting、Exit
	>>BeforeWaiting（准备进入休眠），调用_objc_autoreleasePoolPop()和_objc_autoreleasePoopPush()释放旧的池并创建新池  
	
	>>Exit（即将退出 Loop），调用_objc_autoreleasePoolPop()释放池，优先级最低，保证释放池发生在其他所有回调之后



2. 界面刷新
	
	当在操作 UI 时，比如改变了 Frame、更新 UIView/CALayer的层次时，或者手动调用 setNeedsLayout/setNeedsDisplay 方法后，这个 UIView/CALayer 被标记为待处理，并被提交到一个全局的容器。

	>苹果注册了一个 Observer 监听监视两个事件：BeforeWaiting、Exit，回调一个函数，这个函数里会遍历所有待处理的 UIView/CALayer 以执行实际的绘制和调整，并更新 UI 界面

3. 定时器

	>NSTimer其实就是 CFRunLoopTimerRef。NSTimer注册到 RunLoop 后，RunLoop 会为其重复的时间点注册好事件。RunLoop 为了节省时间，并不会在非常准确的时间点回调 Timer，Timer 有个属性叫做 Tolerance（宽容度），标示了当时间点到后，容许有多少最大误差。错过时间点后，回调会跳过去。
	
	>CADisplayLink 是一个和屏幕刷新率一致的定时器（内部操作了一个 Source），如果两次刷新之间执行了一个长任务，那其中就会有一帧被跳过去
	
4. performSelecter

	>当 NSObject 调用 performSelector：afterDelay后，实际上其内部会创建 Timer 并添加到当前线程的 RunLoop 中，如果当前线程没有 RunLoop，则这个方法会失效
