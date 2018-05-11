##MVVM

viewModel 是一个放置用户输入验证逻辑，视图显示逻辑，发起网络请求和其他代码的地方

view 和 view controller 都不能直接引用 model，而是引用视图模型（viewModel）

注意事项：

view 引用 viewModel,但反过来不行（即不要在 viewModel 中引入 UIKit，任何视图本身的引用都不应该放在 viewModel 中）

viewModel 引用 model,但反过来不行

使用建议：

MVVM 可以兼容你当下使用的 MVC 架构

MVVM 增加你的应用的可测试性

MVVM 配合一个绑定机制效果最好（ReactiveCocoa）

viewController 尽量不涉及业务逻辑，让 viewModel 去做这些事情

viewController 只是一个中间人，接受 view 的事件，调用 viewModel 的方法，响应 viewModel 的变化

viewModel 绝对不能包含视图 view，不然就跟 view 产生了耦合，不方便复用和测试

viewModel 之间可以有依赖

---


M  |     C     |  V

M  |  VM   C   |  V

---

view-model 会在视图控制器上以一个属性的方式存在，视图控制器知道 view-model 和它的公有属性，但是 view-model 对视图控制器一无所知。
