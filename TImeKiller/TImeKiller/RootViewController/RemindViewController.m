//
//  RemindViewController.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/8.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "RemindViewController.h"
#import "RemindCollectionViewCellOne.h"

static NSString * const KCellRemind = @"kcellReindCollection";

@interface RemindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@end

@implementation RemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTitleView];
    [self setupCollectionView];
    
}

- (void)setupNav
{
    self.navigationItem.title = @"remind";
}

- (void)setupTitleView
{
    UIView *scrollTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, 40)];
    [self.view addSubview:scrollTitle];
    scrollTitle.backgroundColor = [UIColor blueColor];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreen_Width, kScreen_Height - 40 -64);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+40, kScreen_Width, kScreen_Height - 40 - 64) collectionViewLayout:layout];
    [collectionView registerClass:[RemindCollectionViewCellOne class] forCellWithReuseIdentifier:KCellRemind];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RemindCollectionViewCellOne *item = [collectionView dequeueReusableCellWithReuseIdentifier:KCellRemind forIndexPath:indexPath];
    item.backgroundColor = [UIColor redColor];
    return item;
}



@end
