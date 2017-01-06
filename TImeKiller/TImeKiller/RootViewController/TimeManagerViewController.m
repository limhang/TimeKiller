//
//  TimeManagerViewController.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/8.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "TimeManagerViewController.h"
#import "ManagerCompleteCell.h"
#import "ManagerRunningCell.h"
#import "ManagerUndoCell.h"

#import "ManagerTableViewHeadView.h"
#import "ManagerTimeTagView.h"

static NSString *const KCellIdentifier_ManagerCompleteCell = @"ManagerCompleteCell";
static NSString *const KCellIdentifier_ManagerRunningCell = @"ManagerRunningCell";
static NSString *const KCellIdentifier_ManagerUndoCell = @"ManagerUndoCell";


@interface TimeManagerViewController ()<UITableViewDataSource,UITableViewDelegate,ManagerTableViewHeadDelegate>

@property (nonatomic,weak)UITableView *tableView;

@property (nonatomic,weak)ManagerTableViewHeadView *tableHeadView;

@property (nonatomic,weak)ManagerTimeTagView *tagView;

@property (nonatomic,strong)NSTimer *time;

@property (assign,nonatomic)int timeI;

@property (assign,nonatomic)int timeMinute;

@property (nonatomic,assign)int timeHour;

@property (assign,nonatomic)BOOL startOrStop;

//程序进入后台时间
@property (nonatomic,assign)int backgroundTimeSS;
@property (nonatomic,assign)int backgroundTimeMM;
@property (nonatomic,assign)int backgroundTimeHH;

//前后台时间差
@property (nonatomic,assign)int finialSS;
@property (nonatomic,assign)int finialMM;
@property (nonatomic,assign)int finialHH;

//进入前台后最终显示的时间
@property (nonatomic,assign)int SS;
@property (nonatomic,assign)int MM;
@property (nonatomic,assign)int HH;

@end

@implementation TimeManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupBasicUI];
    [self setupTagView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToBackground) name:@"程序进入后台" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToFont) name:@"程序进入前台" object:nil];

}

- (void)goToBackground
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyMMddHHmmss"];
    NSString *currentTimeStr = [formatter stringFromDate:[NSDate date]];
    self.backgroundTimeHH = [[currentTimeStr substringWithRange:(NSRange){6,2}] intValue];
    self.backgroundTimeMM = [[currentTimeStr substringWithRange:(NSRange){8,2}] intValue];
    self.backgroundTimeSS = [[currentTimeStr substringWithRange:(NSRange){10,2}] intValue];
}

- (void)goToFont
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyMMddHHmmss"];
    NSString *currentTimeStr = [formatter stringFromDate:[NSDate date]];
    int lastTimeHH = [[currentTimeStr substringWithRange:(NSRange){6,2}] intValue];
    int lastTimeMM = [[currentTimeStr substringWithRange:(NSRange){8,2}] intValue];
    int lastTimeSS = [[currentTimeStr substringWithRange:(NSRange){10,2}] intValue];

    //进入后台和前台的时间差
    if(lastTimeSS < self.backgroundTimeSS){
        self.finialSS = lastTimeSS + 60 - self.backgroundTimeSS;
        lastTimeMM = lastTimeMM - 1;
        if(lastTimeMM < self.backgroundTimeMM){
            self.finialMM = lastTimeMM + 60 - self.backgroundTimeMM;
            lastTimeHH = lastTimeHH - 1;
            self.finialHH = lastTimeHH - self.backgroundTimeHH;
        }else{
            self.finialMM = lastTimeMM - self.backgroundTimeMM;
            self.finialHH = lastTimeHH - self.backgroundTimeHH;
        }
    }else{
        if(lastTimeMM < self.backgroundTimeMM){
            self.finialSS = lastTimeSS - self.backgroundTimeSS;
            self.finialMM = lastTimeMM + 60 - self.backgroundTimeMM;
            lastTimeHH = lastTimeHH - 1;
            self.finialHH = lastTimeHH - self.backgroundTimeHH;
        }else{
            self.finialHH = lastTimeHH - self.backgroundTimeHH;
            self.finialMM = lastTimeMM - self.backgroundTimeMM;
            self.finialSS = lastTimeSS - self.backgroundTimeSS;
        }
    }
    
    _SS = self.finialSS + _timeI;
    if(_SS < 60){
        _MM = self.finialMM + _timeMinute;
        if(_MM < 60){
            _HH = self.finialHH + _timeHour;
        }else{
            _MM = _MM - 60;
            _HH = self.finialHH + _timeHour + 1;
        }
    }else{
        _SS = _SS - 60;
        _MM = self.finialMM + _timeMinute + 1;
        if(_MM < 60){
            _HH = self.finialHH + _timeHour;
        }else{
            _MM = _MM - 60;
            _HH = self.finialHH + _timeHour + 1;
        }
    }
    //进入前台后刷新int时间，刷新label数据
    if(_startOrStop){
        //在启动的状态下刷新时间显示
        _timeI = _SS;
        _timeHour = _HH;
        _timeMinute = _MM;
        self.tableHeadView.hourTime.text = [NSString stringWithFormat:@"%02d",_SS];
        self.tableHeadView.minuteTime.text = [NSString stringWithFormat:@"%02d",_MM];
        self.tableHeadView.secondTime.text = [NSString stringWithFormat:@"%02d",_HH];
    }
    
}

- (void)setupNav
{
    self.navigationItem.title = @"manager";
//    _timeI = 0;
    
}

- (void)setupBasicUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView = tableView;
    [self.view addSubview:_tableView];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 48, 0);
    tableView.dataSource = self;
    tableView.delegate = self;
    
    ManagerTableViewHeadView *headView = [[ManagerTableViewHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 250)];
    _tableHeadView = headView;
    tableView.tableHeaderView = _tableHeadView;
    _tableHeadView.delegate = self;
    
    [tableView registerClass:[ManagerUndoCell class] forCellReuseIdentifier:KCellIdentifier_ManagerUndoCell];
    [tableView registerClass:[ManagerRunningCell class] forCellReuseIdentifier:KCellIdentifier_ManagerRunningCell];
    [tableView registerClass:[ManagerCompleteCell class] forCellReuseIdentifier:KCellIdentifier_ManagerCompleteCell];
    
}


- (void)setupTagView
{
    ManagerTimeTagView *tag = [[ManagerTimeTagView alloc]initWithFrame:CGRectMake(0, -kScreen_Height - 64, kScreen_Width, kScreen_Height)];
    _tagView = tag;
    [self.view addSubview:tag];
    __weak typeof (tag) weakTag = tag;
    __weak typeof (self) weakSelf = self;
    tag.hiddenBtn = ^(){
        [UIView animateWithDuration:0.5 animations:^{
            weakTag.frame = CGRectMake(0, -kScreen_Height - 64, kScreen_Width, kScreen_Height);
        }];
    };
    tag.sentTitleBlock = ^(NSString *string){
        NSLog(@"选中的标签是:%@",string);
        weakTag.hiddenBtn();
        [weakSelf clearTime];
    };
}

//代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 10;
    }else if(section ==1){
        return 10;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        UIView *sectionViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        sectionViewOne.backgroundColor = KColorBackgroud;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreen_Width, 30)];
        label.text = @"未完，待续";
        label.font = [UIFont systemFontOfSize:15];
        [sectionViewOne addSubview:label];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 30)];
        bgView.backgroundColor = [UIColor redColor];
//        bgView.layer.masksToBounds = YES;
//        bgView.layer.cornerRadius = 15.0f;
        [sectionViewOne addSubview:bgView];
        return sectionViewOne;
    }else if(section == 1){
        UIView *sectionViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        sectionViewTwo.backgroundColor = KColorBackgroud;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreen_Width, 30)];
        label.text = @"已完成";
        label.font = [UIFont systemFontOfSize:15];
        [sectionViewTwo addSubview:label];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 30)];
        bgView.backgroundColor = [UIColor greenColor];
//        bgView.layer.masksToBounds = YES;
//        bgView.layer.cornerRadius = 15.0f;
        [sectionViewTwo addSubview:bgView];
        return sectionViewTwo;
    }else{
        UIView *sectionViewThree = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        sectionViewThree.backgroundColor = KColorBackgroud;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreen_Width, 30)];
        label.text = @"未开垦";
        label.font = [UIFont systemFontOfSize:15];
        [sectionViewThree addSubview:label];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 30)];
        bgView.backgroundColor = [UIColor blueColor];
//        bgView.layer.masksToBounds = YES;
//        bgView.layer.cornerRadius = 15.0f;
        [sectionViewThree addSubview:bgView];
        return sectionViewThree;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        ManagerCompleteCell *completeCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_ManagerCompleteCell];
        return completeCell;
    }else if(indexPath.section == 1){
        ManagerRunningCell *runningCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_ManagerRunningCell];
        return runningCell;
    }else{
        ManagerUndoCell *undoCell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier_ManagerUndoCell];
        return undoCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
        return 90;
    }else{
        return 44;
    }
}



//headView delegate method
- (void)touchStartOrStop
{
    NSLog(@"点击了打印");
    _startOrStop = !_startOrStop;
    if(_startOrStop){
        self.time = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(secondRunning) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
        [self.tableHeadView.timeStart setTitle:@"暂停" forState:UIControlStateNormal];
    }else if(!_startOrStop){
        [self.time invalidate];
        [self.tableHeadView.timeStart setTitle:@"启动" forState:UIControlStateNormal];
    }

}

- (void)secondRunning
{
    if(_timeI == 60 && [self.tableHeadView.minuteTime.text isEqualToString:@"60"]){
        _timeHour ++;
        _timeMinute = 0;
        _timeI = 0;
        self.tableHeadView.secondTime.text = [NSString stringWithFormat:@"%02d",_timeHour];
    }else if(_timeI == 60){
        _timeMinute ++;
        _timeI = 0;
        self.tableHeadView.minuteTime.text = [NSString stringWithFormat:@"%02d",_timeMinute];
    }
    self.tableHeadView.hourTime.text = [NSString stringWithFormat:@"%02d",_timeI];
    _timeI++;
}

- (void)touchRestart
{
    if([self.tableHeadView.hourTime.text isEqualToString:@"00"]&&[self.tableHeadView.minuteTime.text isEqualToString:@"00"]&&[self.tableHeadView.secondTime.text isEqualToString:@"00"]){
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"开始启动一个新任务吧^-^";
        [HUD hide:YES afterDelay:1.0];
    }else if(_startOrStop){
        [self touchStartOrStop];
        [self setTagForTime];
    }else{
        [self setTagForTime];
    }
}

- (void)setTagForTime
{
    //创建UIAlertController类
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"打个标签" preferredStyle:UIAlertControllerStyleAlert];
    //设置UIAlertController的点击事件
    __weak typeof (self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf clearTime];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"打标签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf showTagView];
    }]];
    //显示UIAlertController
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)clearTime
{
    _timeI = 0;
    _timeHour = 0;
    _timeMinute = 0;
    self.tableHeadView.hourTime.text = [NSString stringWithFormat:@"%02d",0];
    self.tableHeadView.minuteTime.text = [NSString stringWithFormat:@"%02d",0];
    self.tableHeadView.secondTime.text = [NSString stringWithFormat:@"%02d",0];
}

- (void)showTagView
{
    [UIView animateWithDuration:0.5 animations:^{
        _tagView.frame = CGRectMake(0, 64, kScreen_Width, kScreen_Height);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
