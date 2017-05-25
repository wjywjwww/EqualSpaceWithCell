//
//  EqualSpaceFlowLayout.m
//  UICollectionViewDemo
//
//  Created by WJY on 16/12/12.
//  Copyright (c) 2016年 WJY. All rights reserved.
//

#import "EqualSpaceFlowLayout.h"

@interface EqualSpaceFlowLayout()
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@end

@implementation EqualSpaceFlowLayout
- (id)init
{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 5;
        self.minimumLineSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return self;
}

#pragma mark - Methods to Override
- (void)prepareLayout
{
    [super prepareLayout];
    self.itemAttributes = [[NSMutableArray alloc]init];
    for (NSInteger indexSextion = 0 ; indexSextion < [[self collectionView] numberOfSections] ; indexSextion++) {
        
    }
    NSInteger itemCount = [[self collectionView] numberOfItemsInSection:0];
    NSInteger equalIndex = 0;
    CGFloat xOffset = self.sectionInset.left;
    CGFloat yOffset = self.sectionInset.top;
    CGFloat xNextOffset = self.sectionInset.left;
    for (NSInteger idx = 0; idx < itemCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        
        xNextOffset+=(self.minimumInteritemSpacing + itemSize.width);
        if (xNextOffset > [self collectionView].bounds.size.width - self.sectionInset.right) {
            xOffset = self.sectionInset.left;
            xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width);
            yOffset += (itemSize.height + self.minimumLineSpacing);
            if (_isCenter){
                UICollectionViewLayoutAttributes *layoutAttributes = [_itemAttributes lastObject];
                CGFloat someSpace = [self collectionView].bounds.size.width - layoutAttributes.frame.origin.x - layoutAttributes.frame.size.width;
                CGFloat oneSpace = (someSpace + 10) / 2.0;
                for (NSInteger index =  equalIndex ; index < idx  ; index++) {
                    UICollectionViewLayoutAttributes *oneLayoutAttributes = _itemAttributes[index] ;
                    CGRect originalFrame = oneLayoutAttributes.frame;
                    originalFrame.origin.x += oneSpace -  10;
                    oneLayoutAttributes.frame = originalFrame;
                }
                equalIndex = idx;
            }
        }
        else{
            xOffset = xNextOffset - (self.minimumInteritemSpacing + itemSize.width);
        }
        UICollectionViewLayoutAttributes *layoutAttributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        layoutAttributes.frame = CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height);
        [_itemAttributes addObject:layoutAttributes];
        if (_isCenter){
            if (idx == itemCount - 1){
                UICollectionViewLayoutAttributes *layoutAttributes = [_itemAttributes lastObject];
                CGFloat someSpace = [self collectionView].bounds.size.width - layoutAttributes.frame.origin.x - layoutAttributes.frame.size.width;
                CGFloat oneSpace = (someSpace + 10) / 2.0;
                for (NSInteger index =  equalIndex ; index < idx + 1  ; index++) {
                    UICollectionViewLayoutAttributes *oneLayoutAttributes = _itemAttributes[index] ;
                    CGRect originalFrame = oneLayoutAttributes.frame;
                    originalFrame.origin.x += oneSpace -  10;
                    oneLayoutAttributes.frame = originalFrame;
                }
            }
        }
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.itemAttributes)[indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray * array = [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}
@end
