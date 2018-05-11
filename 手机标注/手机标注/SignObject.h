//
//  SignObject.h
//  手机标注
//
//  Created by wds on 2018/5/11.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignView.h"

@interface SignObject : NSObject

@property (nonatomic, strong) SignView *signView;
@property (nonatomic, copy) NSString *signName;
@property (nonatomic, readonly, assign) CGRect signFrame;
@property (nonatomic, readonly, assign) NSUInteger signTag;

@end
