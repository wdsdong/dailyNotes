//
//  BottomTool.h
//  手机标注
//
//  Created by wds on 2018/5/10.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddSignBlock)(BOOL);

@interface BottomTool : UIView

/** <#wds#>*/
@property (nonatomic, copy) AddSignBlock addSign;

@end
