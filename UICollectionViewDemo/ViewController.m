//
//  ViewController.m
//  UICollectionViewDemo
//
//  Created by WJY on 16/12/12.
//  Copyright (c) 2016年 WJY. All rights reserved.
//

#import "ViewController.h"
#import "EqualSpaceFlowLayout.h"
#import "ItemData.h"
#import "CustomCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,EqualSpaceFlowLayoutDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController
- (void)addContentView
{
    EqualSpaceFlowLayout *flowLayout = [[EqualSpaceFlowLayout alloc] init];
    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 100) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
}

- (void)loadData
{
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 500; i++) {
        NSInteger n = arc4random() % 10 + 1;
        ItemData *itemData = [[ItemData alloc] init];
        itemData.content = [NSString stringWithFormat:@"%d",i];
        itemData.size = CGSizeMake((n * 5) + 50,30);
        [self.dataArray addObject:itemData];
        
    }
}

#pragma mark - lifeCycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    [self addContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *moreCellIdentifier = @"CellIdentifier";
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:moreCellIdentifier forIndexPath:indexPath];
    
    ItemData *itemData = [self.dataArray objectAtIndex:[indexPath row]];
    cell.content = itemData.content;
//    [cell.contentView setNeedsLayout];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemData *itemData = [self.dataArray objectAtIndex:[indexPath row]];
    return itemData.size;
}

@end
