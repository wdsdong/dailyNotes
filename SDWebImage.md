##SDWebImage

###框架核心类

**UIKit层：**负责接收参数

UIView+WebCache

UIImageView+WebCache

UIButton+WebCache

**工具层：**负责下载操作和缓存

SDWebImageManager负责处理和协调 SDWebImageDownloader 和 SDWebImageCache,  
SDWebImageDownloader负责具体的下载任务；  
SDWebImageCache负责关于缓存的工作：添加，删除，查询


###流程

1. 接受任务
> UIImageView,UIButton 的sd_setImageWithURL

2. 发布下载任务
>所有的sd_setImageWithURL都会走到 UIView(WebCache)里的 sd_internalSetImageWithURL

3. 执行下载任务
> SDWebImageViewManager里 loadImageWithURL  
>URL 校验：URL 为空，包含在 failedURLS 之中，错误处理  
>生成 URL 对应的 key

4. 检查缓存
> SDImageCache里 queryCacheOperaionForKey
>使用key 去读取内存和磁盘缓存，  
>先读内存缓存，如有，执行完成回调函数  
>如没有，读取磁盘缓存，添加到内存缓存中，执行完成回调函数

5. 执行下载操作
>SDWebImageDownLoader里 downloadImage
>将当前操作加入到操作缓存里  
>下载完成  
>将当前操作从操作缓存里移除

6. 下载成功，根据缓存策略将图片放入内存缓存和磁盘缓存中
>disk 存储文件名需要 md5加密  
>执行完成回调函数

7. 显示图片

##零散知识点
1.运行时存取关联对象

```
objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//将operations对象关联给self，地址为&loadOperationKey，语义是OBJC_ASSOCIATION_RETAIN_NONATOMIC。

SDOperationsDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
//将operations对象通过地址&loadOperationKey从self里取出来

```

2.数组的写操作需要加锁（多线程访问，避免覆写）

```
//给self.runningOperations加锁
//self.runningOperations数组的添加操作
    @synchronized (self.runningOperations) {
        [self.runningOperations addObject:operation];
    }

//self.runningOperations数组的删除操作
- (void)safelyRemoveOperationFromRunning:(nullable SDWebImageCombinedOperation*)operation {
    @synchronized (self.runningOperations) {
        if (operation) {
            [self.runningOperations removeObject:operation];
        }
    }
}

```

3.确保在主线程的宏

```
dispatch_main_async_safe(^{
 				 //将下面这段代码放在主线程中
            [self sd_setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];
        });

//宏定义：
#define dispatch_main_async_safe(block)\
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

```

4.设置不能为 nil 的参数

```
- (nonnull instancetype)initWithCache:(nonnull SDImageCache *)cache downloader:(nonnull SDWebImageDownloader *)downloader {
    if ((self = [super init])) {
        _imageCache = cache;
        _imageDownloader = downloader;
        _failedURLs = [NSMutableSet new];
        _runningOperations = [NSMutableArray new];
    }
    return self;
}

```

5.容错，强制转换类型

```
if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
}
```