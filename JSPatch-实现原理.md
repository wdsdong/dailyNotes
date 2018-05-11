##JSPatch 实现原理

JSPatch是一个 iOS 动态更新框架，只需在项目中引入极小的引擎，就可以使用 JavaScript 调用任何 Objective-C 原生接口，获得脚本语言的优势：为项目动态添加模块，或替换项目原生代码动态修复 bug

**原理**

JSPatch 能做到通过 JS 调用和改写 OC 方法最根本的原因是 Objective-C 是动态语言，OC 上所有方法的调用/类的生成都通过 Objective-C Runtime在运行时进行，

* 我们可以通过类名/方法名反射得到相应的类和方法，  

```
Class class = NSClassFromString("UIViewController")
id viewController = [[class alloc] init];
SEL selector = NSSelectorFromString("viewDidLoad")
[viewController performSelector:selector];
```

* 也可以替换某个类的方法为新的实现

```
static void newViewDidLoad(id slf,SEL sel){}
class_replaceMethod(class,selector,newViewDidLoad,@"")

```

* 还可以新注册一个类，为类添加方法

```
Class cls = objc_allocateClassPair(superCls,"JPObject",0)
objc_registerClassPair(cls);
class_addMethod(cls,selector,implement,typedesc)

```

**理论上你可以在运行时通过类名/方法名调用任何 OC 方法，替换任何类的实现以及新增任意类。**

所以 JSPatch 的基本原理就是：**JS 传递字符串给 OC，OC 通过 Runtime 接口调用和替换 OC 方法。**
