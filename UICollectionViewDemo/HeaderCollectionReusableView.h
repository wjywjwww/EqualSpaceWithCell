//
//  HeaderCollectionReusableView.h
//  UICollectionViewDemo
//
//  Created by sks on 17/4/26.
//  Copyright © 2017年 CHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCollectionReusableView : UICollectionReusableView
@property(nonatomic,retain)UILabel * label;
-(void)updateLabelFrame;
@end
