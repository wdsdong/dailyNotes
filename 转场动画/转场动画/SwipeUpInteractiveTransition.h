//
//  SwipeUpInteractiveTransition.h
//  转场动画
//
//  Created by wds on 2018/5/24.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

/** <#wds#> */
@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController *)viewController;

@end
