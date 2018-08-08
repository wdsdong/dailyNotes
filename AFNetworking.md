##AFNetworking

**AFN 5个功能模块**

* 网络通信模块--NSURLSession（AFURLSessionManager、AFHTTPSessionManager）

* 网络状态监听模块--Reachability（AFNetworkReachabilityManager）

* 网络通信安全模块策略模块--Security（AFSecurityPolity）

* 网络通信信息序列化/反序列化模块--Serialization（AFURLRequsetSerialization, AFURLResponseSerialization）

* 对于 iOS UIKit 库的扩展（UIKit）  

###一、网络通信模块

AFURLSessionManager是网络通信模块的核心，AF3.x是基于 NSURLSession 来封装的，所以这个类围绕这 NSURLSession 做了一系列的上层封装。

AFHTTPSessionManager 是继承于 AFURLSessionManager 的，我们一般做网络请求都是用这个类，但是他本身没有做实事，只是做了一些简单的封装，把请求逻辑分发给 AFURLSessionManager 去做。

###二、请求参数解析类
AFHTTPRequseteSerializer:根据 URL 和参数，去构造需要的 NSMutableURLRequset,主要部分是参数的编码
