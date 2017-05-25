//
//  EqualSpacingFlowLayout.m
//  JiandanOC
//
//  Created by sks on 17/5/17.
//  Copyright © 2017年 besttone. All rights reserved.
//

#import "EqualSpacingFlowLayout.h"
@interface EqualSpacingFlowLayout(){
    CGFloat _sumWidth ;
}
@end
@implementation EqualSpacingFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(0.1, 5, 0.1, 5);
        _betweenOfCell = 5.0;
    }
    return self;
}
-(instancetype)initWith:(UICollectionViewScrollDirection)scrollDirection withMinimumLineSpacing:(CGFloat)minimumLineSpacing withSectionInset:(UIEdgeInsets)sectionInset withBetweenOfCell:(CGFloat)betweenOfCell{
    self = [super init];
    if (self) {
        self.scrollDirection = scrollDirection;
        self.minimumLineSpacing = minimumLineSpacing;
        self.minimumInteritemSpacing = betweenOfCell;
        _betweenOfCell = betweenOfCell;
        self.sectionInset = sectionInset;
    }
    return self;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray * attributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray * attributes = [[NSArray alloc]initWithArray:attributes_t copyItems:true];
    NSMutableArray * attributesTemp = [[NSMutableArray alloc]init];
    for (int index=1; index < attributes.count; index++) {
        
        UICollectionViewLayoutAttributes *curAttr = attributes[index]; // 当前cell的位置信息
        UICollectionViewLayoutAttributes *preAttr = attributes[index-1]; // 上一个cell 的位置信息
        // 下面这块代码是对于一行只有一个cell进行位置调整
        [attributesTemp addObject:preAttr];
        _sumWidth = preAttr.frame.size.width;
        UICollectionViewLayoutAttributes *nextAttr = nil;//下一个cell 位置信息
        if (index+1 < attributes.count) {
            nextAttr = attributes[index+1];
        }
        if (_isCenter){
            if (nextAttr != nil){
                CGFloat preY = CGRectGetMaxY(preAttr.frame);
                CGFloat curY = CGRectGetMaxY(curAttr.frame);
                CGFloat nextY = CGRectGetMaxY(nextAttr.frame);
                if (curY > preY) {
                    for (UICollectionViewLayoutAttributes* attribute in attributesTemp){
                        attribute.center = CGPointMake(self.collectionView.center.x, attribute.center.y);
                    }
                    [attributesTemp removeAllObjects];
                    _sumWidth = 0.0;
                }else if (curY > preY&&curY < nextY) {
                        if ([curAttr.representedElementKind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
                            CGRect frame = curAttr.frame;
                            frame.origin.x = 0;
                            curAttr.frame = frame;
                        }
                }else if (nextY > curY){
                        [attributesTemp addObject:curAttr];
                        _sumWidth += curAttr.frame.size.width;
                        CGFloat tempSumSpace = 0;
                        CGFloat leftSpace = (self.collectionView.frame.size.width - _sumWidth - (attributesTemp.count - 1)*_betweenOfCell)/2;
                        for (UICollectionViewLayoutAttributes* attribute in attributesTemp){
                            CGRect frame = attribute.frame;
                            frame.origin.x = leftSpace + tempSumSpace;
                            attribute.frame = frame;
                            tempSumSpace = CGRectGetMaxX(attribute.frame) + _betweenOfCell;
                        }
                       [attributesTemp removeAllObjects];
                       _sumWidth = 0.0;
                   }else{
                       [attributesTemp addObject:curAttr];
                       _sumWidth += curAttr.frame.size.width;
                   }
            }else{
                CGFloat tempSumSpace = 0;
                CGFloat leftSpace = (self.collectionView.frame.size.width - _sumWidth - (attributesTemp.count - 1)*_betweenOfCell)/2;
                for (UICollectionViewLayoutAttributes* attribute in attributesTemp){
                    CGRect frame = attribute.frame;
                    frame.origin.x = leftSpace + tempSumSpace;
                    attribute.frame = frame;
                    tempSumSpace = CGRectGetMaxX(attribute.frame) + _betweenOfCell;
                }
                [attributesTemp removeAllObjects];
                _sumWidth = 0.0;
            }
        }else{
            if (nextAttr != nil){
                CGFloat preY = CGRectGetMaxY(preAttr.frame);
                CGFloat curY = CGRectGetMaxY(curAttr.frame);
                CGFloat nextY = CGRectGetMaxY(nextAttr.frame);
                //根据cell的Y轴位置来判断cell是否是单独一行
                if (curY > preY&&curY < nextY) {
                    //这个判断方式也会对区头进行判断 如果是区头则X轴还是从0开始
                    if ([curAttr.representedElementKind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
                        CGRect frame = curAttr.frame;
                        frame.origin.x = 0;
                        curAttr.frame = frame;
                    } else {
                        //单独一行的cell的X轴从5开始
                        CGRect frame = curAttr.frame;
                        frame.origin.x = self.sectionInset.left;
                        curAttr.frame = frame;
                    }
                }
            }
            //下面是对一行多个cell的间距进行调整
            CGFloat origin = CGRectGetMaxX(preAttr.frame);
            CGFloat targetX = origin + _betweenOfCell;
            if (CGRectGetMinX(curAttr.frame) > targetX){
                //如果cell换行了则不进行调整
                if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                    CGRect frame = curAttr.frame;
                    frame.origin.x = targetX;
                    curAttr.frame = frame;
                }
            }
        }
    }
    return attributes;
}
@end
