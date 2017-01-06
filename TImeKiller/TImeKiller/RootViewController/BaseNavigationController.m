//
//  BaseNavigationController.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/9.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

- (void)MHbackViewController
{
    [self popToRootViewControllerAnimated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [super popToRootViewControllerAnimated:animated];
    return [self.viewControllers lastObject];
}


@end
