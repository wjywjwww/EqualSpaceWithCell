//
//  EqualSpaceFlowLayout.h
//  UICollectionViewDemo
//
//  Created by WJY on 16/12/12.
//  Copyright (c) 2016年 WJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  EqualSpaceFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>
@end

@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id<EqualSpaceFlowLayoutDelegate> delegate;
//是否需要Cell居中等间距
@property(nonatomic,assign)BOOL isCenter;
@end
