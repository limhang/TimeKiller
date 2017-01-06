//
//  ManagerUndoCell.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/9.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "ManagerUndoCell.h"

@interface ManagerUndoCell ()

@property (nonatomic,weak)UILabel *label;

@end

@implementation ManagerUndoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
//        UILabel *label = [[UILabel alloc]init];
//        _label = label;
//        [self.contentView addSubview:_label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(5);
//            make.left.mas_equalTo(5);
//            make.width.mas_equalTo(self.frame.size.width);
//            make.bottom.mas_equalTo(5);
//        }];
//        label.text = @"Manager Undo";
        
        [self setupDirectionBtn];
        
        [self setupDetailLabel];
        
        [self setupTimeLabel];
        
    }
    return self;
}

- (void)setupDirectionBtn
{
    UIButton *btn = [[UIButton alloc]init];
    _directionButton = btn;
    [self.contentView addSubview:_directionButton];
    [_directionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    btn.backgroundColor = KColorBackgroud;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 20;
    [btn setTitle:@"运动" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
}

- (void)setupDetailLabel
{
    UILabel *label = [[UILabel alloc]init];
    _detailLabel = label;
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_directionButton.mas_left);
        make.top.equalTo(_directionButton.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreen_Width);
    }];
    label.text = @"详细信息描述";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
}

- (void)setupTimeLabel
{
    UILabel *label = [[UILabel alloc]init];
    _timeLabel = label;
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_directionButton.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    label.text = @"精力值是多少";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
}

@end
