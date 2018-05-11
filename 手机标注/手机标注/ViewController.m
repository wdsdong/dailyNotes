//
//  ViewController.m
//  手机标注
//
//  Created by wds on 2018/5/10.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SSAdd.h"
#import "SignBGView.h"
#import "BottomTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frameWidth, self.view.frameHeight - 44)];
    [self.view addSubview:backgroundView];
    
    SignBGView *signBGView = [[SignBGView alloc] initWithFrame:backgroundView.bounds];
    [backgroundView addSubview:signBGView];

    BottomTool *bottomTool = [[BottomTool alloc] initWithFrame:CGRectMake(0, self.view.frameHeight - 44, self.view.frameWidth, 44)];
    bottomTool.addSign = ^(BOOL selected) {
        [signBGView  signMode:selected];
    };
    [self.view addSubview:bottomTool];
    [self.view bringSubviewToFront:bottomTool];
}





@end
