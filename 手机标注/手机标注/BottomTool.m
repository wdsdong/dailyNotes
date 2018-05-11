//
//  BottomTool.m
//  手机标注
//
//  Created by wds on 2018/5/10.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import "BottomTool.h"
#import "UIView+SSAdd.h"

@implementation BottomTool

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *addSignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addSignBtn.frame = CGRectMake(0, 0, self.frameWidth/2, self.frameHeight);
        [addSignBtn addTarget:self action:@selector(addSign:) forControlEvents:UIControlEventTouchUpInside];
        [addSignBtn setBackgroundColor:[UIColor grayColor]];
        [addSignBtn setTitle:@"添加标记" forState:UIControlStateNormal];
        [addSignBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addSignBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        addSignBtn.selected = NO;
        [self addSubview:addSignBtn];
        
        UIButton *deleteSignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteSignBtn.frame = CGRectMake(self.frameWidth/2, 0, self.frameWidth/2, self.frameHeight);
        deleteSignBtn.titleLabel.text = @"删除标记";
        [self addSubview:deleteSignBtn];
    }
    return self;
}

- (void)addSign:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundColor:[UIColor grayColor]];
    } else {
        [sender setBackgroundColor:[UIColor whiteColor]];
    }
    if (self.addSign) {
        self.addSign(sender.selected);
    }
}

- (void)deleteSign:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        [sender setBackgroundColor:[UIColor grayColor]];
//    } else {
//        [sender setBackgroundColor:[UIColor whiteColor]];
//    }
    if (self.addSign) {
        self.addSign(sender.selected);
    }
}

@end
