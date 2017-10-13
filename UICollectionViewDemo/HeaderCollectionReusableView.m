//
//  HeaderCollectionReusableView.m
//  UICollectionViewDemo
//
//  Created by sks on 17/4/26.
//  Copyright © 2017年 CHC. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

-(instancetype)init{
    self = [super init];
    if (self){
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        _label.backgroundColor = [UIColor blueColor];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"我是区头";
        _label.font = [UIFont systemFontOfSize:25];
        [self addSubview:_label];
    }
    return self;
}
-(void)updateLabelFrame{
    _label.frame = self.bounds;
}
@end
