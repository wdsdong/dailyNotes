require('UIView', 'UIColor')
var UIControlEventTouchUpInSide = 1 << 6;
defineClass("ViewController", {
      test: function() {
            console.log("tes已经被替换了1");

            self.performSelector_withObject("selector:", "wdsdong")

            // var weakSelf = __weak(self)
            // self.setCompleteBlock(block(function(){
            //     var strongSelf = __strong(weakSelf)
            //     strongSelf.blabla()
            // }))

            // var btn = self.valueForKey("_btn")
            // btn.addTarget_action_forControlEvents(self, "handleBtn", UIControlEventTouchUpInSide)

            // dispatch_after(3.0, function() {
            //     console.log("延迟三秒执行")
            // })

            // dispatch_async_main(function(){

            // })

            // dispatch_async_global_queue(function(){

            // })

            //        var array = self.valueForKey("_array")
            //        self.setValue_forkey(["JSPatch"],"_data")

            //        var data = self.data()
            //        self.setData(data.toJS().push("JSPatch"))
            //        var sel = self
            //        self.bridge().registerHandler_handler('h5ToNativeShareDialog', block('NSDictionary *',function(data,responseCallback) {
            //             sel.setShareURL(data.objectForKey('url'));
            //             sel.setShareTitle(data.objectForKey('title'));
            //         }));

                    var view = UIView.alloc().initWithFrame({
                        x: 200,
                        y: 200,
                        width: 100,
                        height: 100
                    })
                    var redColor = UIColor.redColor()
                    view.setBackgroundColor(redColor)
                    self.view().addSubview(view)
      },
      touchesBegan_withEvent: function(touches, event) {
            console.log("点击了屏幕被替换了1");

      }
}, {});
