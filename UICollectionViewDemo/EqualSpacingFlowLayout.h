//
//  EqualSpacingFlowLayout.h
//  JiandanOC
//
//  Created by sks on 17/5/17.
//  Copyright © 2017年 besttone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EqualSpacingFlowLayout : UICollectionViewFlowLayout
//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//是否是居中等间距
@property (nonatomic,assign)BOOL isCenter;
-(instancetype)initWith:(UICollectionViewScrollDirection)scrollDirection withMinimumLineSpacing:(CGFloat)minimumLineSpacing withSectionInset:(UIEdgeInsets)sectionInset withBetweenOfCell:(CGFloat)betweenOfCell;
@end
