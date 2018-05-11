##Runtime

###基本概念

Runtime 基本是用 C 和汇编写的，Runtime 简称运行时，主要的就是消息机制，是 OC 面向对象和动态机制的基石。

OC 代码会在编译时通过 Runtime 转化成消息转发

>对于 C语言，函数的调用的时候会决定调用哪个函数，编译完成之后直接书序执行，无任何二义性

>OC 函数调用是消息发送，属于动态调用过程，在编译的时候并不能决定真正调用哪个函数（事实证明，在编译阶段，OC 可以调用任何函数，即使这个函数并未实现，只要声明过就不会报错，而C语言在编译阶段就会报错），只要在真正运行的时候才会根据函数的名称找到对应的函数来调用。

###三种不同层级与 Runtime 系统交互

1. Objective-C 源代码
2. Foundation 框架的 NSObject 类定义的方法
3. Runtime 函数的直接调用

###常见方法

`unsigned int count;`

```
unsigned int count;
//获取属性列表	
objc_property_t *propertyList  = class_copyPropertyList([User class], &count);
//获取成员变量列表    
Ivar *ivarList = class_copyIvarList([User class], &count);
//获取方法列表   
Method *methodList = class_copyMethodList([User class], &count);
//获取协议列表    
Protocol *__unsafe_unretained *protocolList = class_copyProtocolList([User class], &count);
//获取类方法    
Method classMethod = class_getClassMethod([User class], @selector(test1));
//获取实例方法    
Method instanceMethod = class_getInstanceMethod([User class], @selector(test2));
//获取方法实现    
IMP classImp = method_getImplementation(classMethod);
    
IMP instanceImp = method_getImplementation(instanceMethod);
//添加方法    
BOOL addSucc = class_addMethod([User class], @selector(test3), instanceImp, method_getTypeEncoding(instanceMethod));
//替换原方法实现    
class_replaceMethod([User class], @selector(test3), instanceImp, method_getTypeEncoding(instanceMethod));
//交换两个方法的实现    
method_exchangeImplementations(instanceMethod, class_getInstanceMethod([User class], @selector(test3)));
```

###常见作用

* 动态的添加对象的成员变量和方法

* 动态交换两个方法的实现

* 拦截并替换方法

* 在方法上增加额外功能

* 实现 NSCoding 的自动归档和解归档

* 实现字典转模型的自动装换

###代码实现

1. 动态变量控制

```
unsigned int count = 0;
Ivar *ivar = class_copyIvarList([self.xiaoMing class], &count);
for (int i = 0; i<count; i++) {
 Ivar var = ivar[i];
 const char *varName = ivar_getName(var);
 NSString *name = [NSString stringWithUTF8String:varName];
 if ([name isEqualToString:@"_age"]) {
     object_setIvar(self.xiaoMing, var, @"20");
     break;
 }
}
```

2. 动态添加方法


```
void guessAnswer(id self,SEL _cmd) {
	NSLog(@"i am from beijing");
}
 
class_addMethod([self.xiaoMing class], @selector(guess), (IMP)guessAnswer, "v@:");

(IMP)guessAnswer 意思是guessAnswer的地址指针;
"v@:" 意思是，v代表无返回值void，如果是i则代表int；@代表 id sel; : 代表 SEL _cmd;
“v@:@@” 意思是，两个参数的没有返回值。

```

3. 动态交换两个方法的实现

```
Method m1 = class_getInstanceMethod([self.xiaoMing class], @selector(test1));
    Method m2 = class_getInstanceMethod([self.xiaoMing class], @selector(test2));
    method_exchangeImplementations(m1, m2);

```

4. 拦截并替换方法

```
+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Class selfClass = [self class];

        SEL oriSEL = @selector(sendAction:to:forEvent:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);

        SEL cusSEL = @selector(mySendAction:to:forEvent:);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);

        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }

    });
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [CountTool addClickCount];
    [self mySendAction:action to:target forEvent:event];
}

```

5. 实现 NSCoding 的自动归档和解归档

```
- (void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Movie class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Movie class], &count);
        for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
       // 归档
       NSString *key = [NSString stringWithUTF8String:name];
      id value = [decoder decodeObjectForKey:key];
       // 设置到成员变量身上
        [self setValue:value forKey:key];
            
        }
        free(ivars);
    } 
    return self;
}

```

###几个参数概念

1. objc_msgSend
2. SEL:映射到方法的 C字符串，不同类中相同名字的方法所对应的方法选择器是相同的，即使方法名字相同而变量类型不同也会导致它们具有相同的方法选择器
`typedef struct objc_selector *SEL`
3. id
`typedef struct objc_object *id`
4. Class
`typedef struct objc_class *Class`
