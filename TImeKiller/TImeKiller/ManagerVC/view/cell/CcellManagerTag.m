//
//  CcellManagerTag.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/11.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "CcellManagerTag.h"

@implementation CcellManagerTag

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imageView.backgroundColor = KColorBackgroud;
        [self addSubview:imageView];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = self.frame.size.width / 2;
        UILabel *label = [[UILabel alloc]init];
        _label = label;
        [self addSubview:_label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView.mas_centerX);
            make.centerY.equalTo(imageView.mas_centerY);
        }];
        label.font = [UIFont systemFontOfSize:30];
        
    }
    return self;
}

@end
