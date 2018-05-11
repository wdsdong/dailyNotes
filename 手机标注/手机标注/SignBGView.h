//
//  SignBGView.h
//  手机标注
//
//  Created by wds on 2018/5/10.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignBGView : UIView

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSMutableArray *signObjectArray;

- (void)signMode:(BOOL)isSign;

@end
