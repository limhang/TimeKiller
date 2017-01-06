//
//  PlanViewController.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/8.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "PlanViewController.h"
#import "AddPlanViewController.h"

#import "KxMenu.h"
@interface PlanViewController ()

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupNav];
}

- (void)setupNav
{
    self.navigationItem.title = @"plan";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPlan:)];
    
}


- (void)addPlan:(UIButton *)button
{
    
    if ([KxMenu isShowingInView:self.view]) {
        [KxMenu dismissMenu:YES];
    }else{
        [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
        [KxMenu setTintColor:[UIColor whiteColor]];
        [KxMenu setLineColor:KColorBackgroud];
        NSArray *menuItems = @[
                               [KxMenuItem menuItem:@"新建计划" image:[UIImage imageNamed:@"navbar_add"] target:self action:@selector(makeNewPlan)],
                               [KxMenuItem menuItem:@"查询计划" image:[UIImage imageNamed:@"navbar_more"] target:self action:@selector(queryPlan)],
                               ];
        [menuItems setValue:[UIColor blackColor] forKey:@"foreColor"];
        //这个地方设置的senderFrame的数值，是指尖号的位置！！！
        CGRect senderFrame = CGRectMake(kScreen_Width - 26, 64, 0, 0);
        [KxMenu showMenuInView:self.view
                      fromRect:senderFrame
                     menuItems:menuItems];
    }

}

- (void)makeNewPlan
{
    AddPlanViewController *addPlanVC = [[AddPlanViewController alloc]init];
    [self.navigationController pushViewController:addPlanVC animated:YES];
}

- (void)queryPlan
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"开发者太懒了0— ，-0";
    [HUD hide:YES afterDelay:1.0];
}

@end
