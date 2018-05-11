//
//  SignBGView.m
//  手机标注
//
//  Created by wds on 2018/5/10.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import "SignBGView.h"
#import "SignObject.h"
#import "BottomTool.h"
#import "UIView+SSAdd.h"

@interface SignBGView() {
    CGPoint _startPoint;
    BOOL _isEnlarge;
    UITapGestureRecognizer *_tapG;
    UIPanGestureRecognizer *_panG;
}

@property (nonatomic, strong) SignObject *currentSignObject;
@property (nonatomic, strong) BottomTool *bottomTool;

@end

@implementation SignBGView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isEnlarge = NO;
        self.layer.contents = (__bridge id _Nullable)[UIImage imageNamed:@"Image"].CGImage;
        
        [self initGestures];
    }
    return self;
}

- (void)signMode:(BOOL)isSign {
    if (isSign) {
        _panG.enabled = YES;
    } else {
        _panG.enabled = NO;
    }
}


- (void)setImage:(NSString *)image {

}

- (void)initGestures {
    _panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPan:)];
    _panG.enabled = NO;
    [self addGestureRecognizer:_panG];
    
    _tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    _tapG.numberOfTapsRequired = 2;
    [self addGestureRecognizer:_tapG];

}

- (void)viewPan:(UIPanGestureRecognizer*)sender {
    CGPoint startP = [sender locationInView:self];
    NSLog(@"%lf",startP.x);
    if(sender.state == UIGestureRecognizerStateBegan){
        _startPoint = startP;
        self.currentSignObject.signView = [[SignView alloc] initWithFrame:CGRectMake(_startPoint.x, _startPoint.y, 20, 20)];
    }
    
    CGFloat addX = startP.x - _startPoint.x;
    CGFloat addY = startP.y - _startPoint.y;
    _currentSignObject.signView.frameWidth += addX;
    _currentSignObject.signView.frameHeight += addY;
    _startPoint = startP;
    
    NSLog(@"%lf %lf %lf %lf",self.currentSignObject.signView.frameX, self.currentSignObject.signView.frameY, self.currentSignObject.signView.frameWidth, self.currentSignObject.signView.frameHeight);

    
    if (addY > 0 && addX > 0 && ![self.subviews containsObject:_currentSignObject.signView]) {
        [self addSubview:_currentSignObject.signView];
    } else {
        return;
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self.signObjectArray addObject:_currentSignObject];
        _currentSignObject = nil;
        NSLog(@"%@",_signObjectArray);
    }
}

- (void)viewTap:(UITapGestureRecognizer *)sender {
    
    _isEnlarge = !_isEnlarge;
    
    UIView *view = sender.view;
    CGPoint p = [sender locationInView:self];
    NSLog(@"%lf",p.x);

    CGFloat apX = p.x / self.frameWidth;
    CGFloat apY = p.y / self.frameHeight;
    
    if (apX < 0.25) {
        apX = 0.25;
    } else if (apX > 0.75) {
        apX = 0.75f;
    }
    if (apY < 0.25) {
        apY = 0.25;
    } else if (apY > 0.75) {
        apY = 0.75f;
    }

    view.transform = CGAffineTransformIdentity;
    if (_isEnlarge) {
        view.layer.anchorPoint = CGPointMake(apX, apY);
//        CGPoint location = [sender locationInView:view.superview];
//        view.center = location;
    } else {
        view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        view.center = CGPointMake(view.frameWidth/2, view.frameHeight/2);
    }
    CGFloat scale = (_isEnlarge ? 2 : 1);
    view.transform = CGAffineTransformMakeScale(scale, scale);
//    NSLog(@"%f %f %f %f",self.frameX,self.frameY,self.superview.frameWidth,self.superview.frameHeight);    
}

- (NSMutableArray *)signObjectArray {
    if (!_signObjectArray) {
        _signObjectArray = @[].mutableCopy;
    }
    return _signObjectArray;
}

- (SignObject *)currentSignObject {
    if (!_currentSignObject) {
        _currentSignObject = [[SignObject alloc] init];
    }
    return _currentSignObject;
}

@end
