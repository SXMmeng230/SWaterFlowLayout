//
//  CardTransFlowLayout.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/6/4.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "CardTransFlowLayout.h"
@interface CardTransFlowLayout()

@end
@implementation CardTransFlowLayout
- (instancetype)init
{
    if (self =[super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(100, [UIScreen mainScreen].bounds.size.height - 300);
        self.minimumLineSpacing = 20;
        self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newArray = [NSMutableArray array];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        UICollectionViewLayoutAttributes *newAttrs = [attrs copy];
        CGFloat offset = 1 - fabs(centerX - attrs.center.x)/self.collectionView.frame.size.width;
        newAttrs.transform = CGAffineTransformScale(newAttrs.transform, offset, offset);
        [newArray addObject:newAttrs];
    }
    return newArray;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect proposedRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [self layoutAttributesForElementsInRect:proposedRect];
    CGFloat offset = 1000;
    for (UICollectionViewLayoutAttributes *attrs in array) {
       
        if (fabs(attrs.center.x - (proposedContentOffset.x+self.collectionView.bounds.size.width/2))< offset) {
            offset = attrs.center.x - (proposedContentOffset.x+self.collectionView.bounds.size.width/2);
        }
    }
    return CGPointMake(proposedContentOffset.x + offset, proposedContentOffset.y);
}
@end
