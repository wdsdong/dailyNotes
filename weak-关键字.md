#iOS weak关键字

###weak常见场景

常见于 delegate,block,NSTimer 中使用，以避免循环引用所带来的的内存泄露

###runtime如何实现 weak变量的自动置为 nil

runtime 对注册的类进行布局，对于 weak 对象会放入一个 hash 表中。  
用 weak 指向的对象内存地址作为 key,当此对象的引用计数为0的时候会 dealloc  
假如 weak 指向的对象内存地址是 a,那么就会以 a 为键，在 weak表中搜索，找到所有以 a 为键的 weak对象，从而设置为 nil

###weak 的用处

弱引用，在对象释放后置为 nil，避免错误的内存访问。  
weak 可以在不增加对象的引用计数的同时，又是的指针的访问是安全的。

###weak singleton

特殊的单例实现:：在所有使用该单例的对象都释放后,单例对象本身也会自己释放.解决实践过程中出现的单例使用完毕之后,仍然一直存在的问题。

**两种实现方式**

```
+ (id)sharedInstance { //同步锁实现
    static __weak WeakSingleton *instance;
    WeakSingleton *strongInstance = instance;
    @synchronized(self) {
        if (strongInstance == nil) {
            strongInstance = [[WeakSingleton alloc] init];
            instance = strongInstance;
        }
    }
    return  strongInstance;
}
```

```
+ (id)sharedInstance2 { //GCD 实现
    static __weak WeakSingleton *instance;
    __block WeakSingleton *strongInstance = instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        strongInstance = [[WeakSingleton alloc] init];
        instance = strongInstance;
    });
    return  strongInstance;
}
```

###weak associated object

给分类添加 weak 特性的属性的实现

```
- (void)setObject:(id)object {
    id __weak weakObject = object;
    id(^block)() = ^() {
        return weakObject;
    };
    objc_setAssociatedObject(self, @selector(object), block, OBJC_ASSOCIATION_COPY);
}

- (id)object {
    id (^block)() = objc_getAssociatedObject(self, @selector(object));
    return (block ? block() : nil);
}
```