//
//  WaterFlowLayout.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/29.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "WaterFlowLayout.h"
#define DefaultItemHeight 100;
@interface WaterFlowLayout()
@property (nonatomic, strong) NSMutableArray *attArr;//存放内容
@property (nonatomic, strong) NSMutableDictionary *columnHeightDic;//列高度
@property (nonatomic, assign) CGFloat contentHeight;//内容高度

@end
@implementation WaterFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.column = 2;
        self.columnSpacing = 1;
        self.rowSpacing = 1;
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
    [self.columnHeightDic removeAllObjects];
    for (NSInteger i = 0; i < self.column; i ++ ) {
        [self.columnHeightDic setObject:@(0) forKey:@(i)];
    }
    [self.attArr removeAllObjects];
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
    UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat itemWidth = (width - self.sectionInset.left - self.sectionInset.right - (self.column - 1) * self.columnSpacing) / self.column;
    CGFloat itemHeight = DefaultItemHeight;
    CGFloat itemX = 0.0;
    CGFloat itemY = 0.0;
    if ([self.delegateFlow respondsToSelector:@selector(itemHeightWithlayout:sizeForItemAtIndexPath:)]) {
        itemHeight = [self.delegateFlow itemHeightWithlayout:self sizeForItemAtIndexPath:indexPath];
    }
    //找到最短的列
    __block NSNumber *minIndex = @0;
    [self.columnHeightDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.columnHeightDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    CGFloat oldHeight = [self.columnHeightDic[minIndex] doubleValue];
    if (indexPath.row <= self.column - 1) {//第一行
        itemY = oldHeight + self.sectionInset.top;
    }else{
        itemY =  oldHeight + self.rowSpacing;
    }
    itemX = [minIndex integerValue] * (itemWidth+ self.columnSpacing) + self.sectionInset.left;
    
    [self.columnHeightDic setObject:@(itemHeight + itemY) forKey:minIndex];

    layoutAtt.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);

    CGFloat columnHeight = [self.columnHeightDic[minIndex] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return layoutAtt;
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentHeight + self.sectionInset.bottom);
}
#pragma mark - setter&getter
- (NSMutableArray *)attArr
{
    if (!_attArr) {
        _attArr = [NSMutableArray array];
    }
    return _attArr;
}
- (NSMutableDictionary *)columnHeightDic
{
    if (!_columnHeightDic) {
        _columnHeightDic = [NSMutableDictionary dictionary];
    }
    return _columnHeightDic;
}
@end
