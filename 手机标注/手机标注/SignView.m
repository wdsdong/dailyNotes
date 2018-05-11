//
//  SignView.m
//  手机标注
//
//  Created by wds on 2018/5/10.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import "SignView.h"
#import "ScaleBtn.h"
#import "UIView+SSAdd.h"

static const NSUInteger kBtnSize = 20;
static NSUInteger AddSignViewTag = 1000;

@implementation SignView {
    ScaleBtn *_scaleBtn;
//    CGPoint _initialPoint; //标记的中心点
    CGRect _initiaFrame;//标记的起始点

}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.tag = AddSignViewTag ++;
        
        _scaleBtn = [[ScaleBtn alloc] initWithFrame:CGRectMake(self.frameWidth - kBtnSize, self.frameHeight - kBtnSize, kBtnSize, kBtnSize)];
        [self addSubview:_scaleBtn];
        [self initGestures];
    }
    return self;
}

- (void)layoutSubviews {
    _scaleBtn.frame = CGRectMake(self.frameWidth - kBtnSize, self.frameHeight - kBtnSize, kBtnSize, kBtnSize);
}

- (void)initGestures {
    [_scaleBtn addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scaleBtnDidPan:)]];
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(signViewDidPan:)]];
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SignViewDidiTap:)];
    [self addGestureRecognizer:tapG];
}

- (void)SignViewDidiTap:(UITapGestureRecognizer *)sender {
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"点击" message:[NSString stringWithFormat:@"%ld",(long)self.tag] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [av show];
}

- (void)signViewDidPan:(UIPanGestureRecognizer*)sender {
    CGPoint p = [sender translationInView:self.superview];
    CGFloat offetX = p.x;
    CGFloat offetY = p.y;
    if(sender.state == UIGestureRecognizerStateBegan){
        _initiaFrame = self.frame;
    }
    self.center = CGPointMake(_initiaFrame.origin.x + _initiaFrame.size.width / 2 + offetX, _initiaFrame.origin.y + _initiaFrame.size.height / 2 + offetY);
}

- (void)scaleBtnDidPan:(UIPanGestureRecognizer*)sender {
    CGPoint p = [sender translationInView:self.superview];
    if(sender.state == UIGestureRecognizerStateBegan){
        _initiaFrame = self.frame;
    }
    self.frame = CGRectMake(_initiaFrame.origin.x, _initiaFrame.origin.y, _initiaFrame.size.width + p.x, _initiaFrame.size.height + p.y);
    NSLog(@"%lf %lf %lf %lf",self.frameX,self.frameY,self.frameWidth,self.frameHeight);
    [self layoutSubviews];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
