//
//  DetailViewController.h
//  转场动画
//
//  Created by wds on 2018/5/24.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@protocol DetailViewControllerDelegate <NSObject>

- (void)detailViewControllerDidClickedDidmissButton:(DetailViewController *)viewController;

@end

@interface DetailViewController : UIViewController

/** <#wds#>*/
@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;


@end
