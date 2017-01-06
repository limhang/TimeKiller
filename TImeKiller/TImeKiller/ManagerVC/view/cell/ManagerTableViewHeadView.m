//
//  ManagerTableViewHeadView.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/10.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "ManagerTableViewHeadView.h"

@interface ManagerTableViewHeadView ()

@end

@implementation ManagerTableViewHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setupTimeShow];
        [self setupTimeStart];
        [self setupTimeStop];
    }
    return self;
}

- (void) setupTimeShow{
    CGFloat spaceOfTime = (kScreen_Width - (30 * 4)) / 3;
    UIView *timeShow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    _timeShow = timeShow;
    [self addSubview:_timeShow];
    //secondTime
    UILabel *secondTime = [[UILabel alloc]init];
    _secondTime = secondTime;
    [self.timeShow addSubview:_secondTime];
    [_secondTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(spaceOfTime);
        make.height.mas_equalTo(100);
    }];
    secondTime.text = @"00";
    secondTime.font = [UIFont systemFontOfSize:52];
//    secondTime.backgroundColor = [UIColor grayColor];
    
    //冒号
    UILabel *spaceLabel = [[UILabel alloc]init];
    [self.timeShow addSubview:spaceLabel];
    [spaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondTime.mas_right);
        make.width.mas_equalTo(30);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    spaceLabel.text = @":";
    spaceLabel.font = [UIFont systemFontOfSize:60];
    
    //minuteTime
    UILabel *minuteTime = [[UILabel alloc]init];
    _minuteTime = minuteTime;
    [self.timeShow addSubview:_minuteTime];
    [_minuteTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.equalTo(self.secondTime.mas_right).offset(30);
        make.width.mas_equalTo(spaceOfTime);
        make.height.mas_equalTo(100);
    }];
    minuteTime.text = @"00";
    minuteTime.font = [UIFont systemFontOfSize:52];
//    minuteTime.backgroundColor = [UIColor grayColor];
    
    //冒号
    UILabel *spaceLabel2 = [[UILabel alloc]init];
    [self.timeShow addSubview:spaceLabel2];
    [spaceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.minuteTime.mas_right);
        make.width.mas_equalTo(30);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    spaceLabel2.text = @":";
    spaceLabel2.font = [UIFont systemFontOfSize:60];
    
    //hourTime
    UILabel *hourTime = [[UILabel alloc]init];
    _hourTime = hourTime;
    [self.timeShow addSubview:_hourTime];
    [_hourTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.equalTo(self.minuteTime.mas_right).offset(30);
        make.width.mas_equalTo(spaceOfTime);
        make.height.mas_equalTo(100);
    }];
    hourTime.text = @"00";
    hourTime.font = [UIFont systemFontOfSize:52];
//    hourTime.backgroundColor = [UIColor grayColor];
    
    //lineView
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 149, kScreen_Width, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.timeShow addSubview:lineView];
    
}

- (void)setupTimeStart
{
    UIButton *timeStart = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeStart = timeStart;
    [self addSubview:_timeStart];
    CGFloat widthTwenty = kScreen_Width * 0.2;
    [timeStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeShow.mas_bottom).offset(20);
        make.left.mas_equalTo(widthTwenty);
        make.width.mas_equalTo(widthTwenty);
        make.height.mas_equalTo(widthTwenty);
    }];
    [timeStart setTitle:@"启动" forState:UIControlStateNormal];
    
    timeStart.layer.masksToBounds = YES;
    timeStart.layer.cornerRadius = widthTwenty / 2;
    timeStart.backgroundColor = [UIColor blueColor];
    [timeStart addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupTimeStop
{
    UIButton *timeStop = [[UIButton alloc]init];
    _timeStop = timeStop;
    [self addSubview:_timeStop];
    CGFloat widthTwenty = kScreen_Width * 0.2;
    [_timeStop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeShow.mas_bottom).offset(20);
        make.right.mas_equalTo(-widthTwenty);
        make.width.mas_equalTo(widthTwenty);
        make.height.mas_equalTo(widthTwenty);
    }];
    [timeStop setTitle:@"标签" forState:UIControlStateNormal];
    
    timeStop.layer.masksToBounds = YES;
    timeStop.layer.cornerRadius = widthTwenty / 2;
    timeStop.backgroundColor = [UIColor blueColor];
    [timeStop addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)start:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(touchStartOrStop)]){
        [self.delegate touchStartOrStop];
    }
}

- (void)restart:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(touchRestart)]){
        [self.delegate touchRestart];
    }
}

@end
