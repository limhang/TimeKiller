//
//  ManagerRunningCell.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/9.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "ManagerRunningCell.h"

@interface ManagerRunningCell ()

@property (nonatomic,weak)UILabel *label;

@end

@implementation ManagerRunningCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UILabel *label = [[UILabel alloc]init];
        _label = label;
        [self.contentView addSubview:_label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(self.frame.size.width);
            make.bottom.mas_equalTo(5);
        }];
        label.text = @"Manager Running";
    }
    return self;
}



@end
