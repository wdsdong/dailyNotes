//
//  ViewController.m
//  转场动画
//
//  Created by wds on 2018/5/24.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface ViewController ()<DetailViewControllerDelegate,UIViewControllerTransitioningDelegate>

{
    BouncePresentAnimation *_presentAnimation;
    NormalDismissAnimation *_dismissAnimation;
    SwipeUpInteractiveTransition *_swipeTransition;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _presentAnimation = [BouncePresentAnimation new];
    _dismissAnimation = [NormalDismissAnimation new];
    _swipeTransition = [SwipeUpInteractiveTransition new];
}

-(void) buttonClicked:(id)sender
{
    DetailViewController *dvc =  [[DetailViewController alloc] init];
    dvc.transitioningDelegate = self;
    dvc.delegate = self;
    [_swipeTransition wireToViewController:dvc];
    [self presentViewController:dvc animated:YES completion:nil];
}

-(void)detailViewControllerDidClickedDidmissButton:(DetailViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return  _dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _swipeTransition.interacting ? _swipeTransition : nil;
}

@end
