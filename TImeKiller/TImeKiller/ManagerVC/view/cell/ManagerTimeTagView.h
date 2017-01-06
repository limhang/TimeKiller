//
//  ManagerTimeTagView.h
//  TimeKiller
//
//  Created by 李明航 on 16/10/11.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^viewHidden) ();

typedef void(^sentTilte) (NSString *title);

@interface ManagerTimeTagView : UIView

@property (nonatomic,copy)viewHidden hiddenBtn;

@property (nonatomic,copy)sentTilte sentTitleBlock;

@end
