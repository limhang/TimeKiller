//
//  ManagerTableViewHeadView.h
//  TimeKiller
//
//  Created by 李明航 on 16/10/10.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ManagerTableViewHeadDelegate <NSObject>

- (void)touchStartOrStop;

- (void)touchRestart;

@end

@interface ManagerTableViewHeadView : UIView

@property (nonatomic,weak)UIView *timeShow;

@property (nonatomic,weak)UIButton *timeStart;

@property (nonatomic,weak)UIButton *timeStop;

@property (nonatomic,weak)UILabel *secondTime;

@property (nonatomic,weak)UILabel *minuteTime;

@property (nonatomic,weak)UILabel *hourTime;

@property (nonatomic,weak) id<ManagerTableViewHeadDelegate> delegate;

@end
