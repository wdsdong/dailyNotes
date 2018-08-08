//
//  ViewController.h
//  Print
//
//  Created by wds on 2018/7/25.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBController.h"

@interface ViewController : CBController
{
    MyPeripheral *controlPeripheral;
    NSMutableArray *connectingList;
}

@end

