//
//  ManagerTimeTagView.m
//  TimeKiller
//
//  Created by 李明航 on 16/10/11.
//  Copyright © 2016年 李明航. All rights reserved.
//

#import "ManagerTimeTagView.h"
#import "CcellManagerTag.h"

@interface ManagerTimeTagView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak)UICollectionView *collectionView;

@property (nonatomic,copy)NSArray *titleName;

@end

@implementation ManagerTimeTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setupTag:(CGRect)frame];
        [self setupCollectionView];
    }
    return self;
}

- (NSArray *)titleName
{
    if(!_titleName){
        _titleName = @[@"学习",@"生活",@"运动",@"工作"];
    }
    return _titleName;
}

- (void)setupTag:(CGRect)frame
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreen_Width, frame.size.width, kScreen_Height - kScreen_Width)];
    btn.backgroundColor = KColorBackgroud;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)hidden
{
    if(_hiddenBtn){
        _hiddenBtn();
    }
}

- (void)setupCollectionView
{
//    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    layout.itemSize = CGSizeMake((kScreen_Width - 60) /2, (kScreen_Width - 60) /2);
    
//    layout.itemSize =CGSizeMake(110, 150);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor grayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[CcellManagerTag class] forCellWithReuseIdentifier:@"CCell"];
    [self addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CcellManagerTag *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CCell" forIndexPath:indexPath];
    cell.label.text = self.titleName[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.sentTitleBlock){
        self.sentTitleBlock(self.titleName[indexPath.row]);
    }
}

- (void)sentTitleToServer:(NSString *)title
{

}

@end
