//
//  AddPlanViewController.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/8.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "AddPlanViewController.h"

@interface AddPlanViewController ()

@property (nonatomic,weak)UITableView *tableView;

@end

@implementation AddPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupBasicUI];
}

- (void)setupNav
{
    self.title = @"Make Plan";
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)setupBasicUI
{
//    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
//    _tableView = tableView;
//    [self.view addSubview:_tableView];
}

- (void)setupBeginTime
{
    
}


- (void)setupEndTime
{

}

- (void)setupContent
{

}

@end
