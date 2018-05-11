//
//  SignObject.m
//  手机标注
//
//  Created by wds on 2018/5/11.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import "SignObject.h"

@implementation SignObject

- (CGRect)signFrame {
    return self.signView.frame;
}

- (NSUInteger)signTag {
    return self.signView.tag;
}

@end
