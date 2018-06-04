//
//  CardFlowLayout.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/6/4.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "CardFlowLayout.h"
@interface CardFlowLayout()
@property (nonatomic, strong) NSMutableArray *attArr;
@property (nonatomic, assign) CGFloat rowMaxWidth;
@property (nonatomic, assign) CGFloat maxHeight;


@end

@implementation CardFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.columnSpacing = 5;
        self.rowSpacing = 5;
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
    [self.attArr removeAllObjects];
    self.rowMaxWidth = 0;
    self.maxHeight = 0;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAtt = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attArr addObject:layoutAtt];
    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attArr;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *att = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    CGFloat itemWidth = 30;
    CGFloat itemX;
    CGFloat itemY;
    CGFloat itemHeight = self.itemHeight?:30;
    if ([self.flowDelegate respondsToSelector:@selector(itemWidthWithlayout:sizeForItemAtIndexPath:)]) {
        itemWidth = [self.flowDelegate itemWidthWithlayout:self sizeForItemAtIndexPath:indexPath];
    }
    itemX = self.rowMaxWidth + self.columnSpacing;
    self.rowMaxWidth += (itemWidth + self.columnSpacing);
    
    if (self.rowMaxWidth > self.collectionView.frame.size.width) {
        self.rowMaxWidth = itemWidth + self.columnSpacing;
        itemX = self.columnSpacing;
        self.maxHeight += itemHeight + self.rowSpacing;
    }
    itemY = self.maxHeight;
    att.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    return att;
}

- (NSMutableArray *)attArr
{
    if (!_attArr) {
        _attArr = [NSMutableArray array];
    }
    return _attArr;
}

@end
