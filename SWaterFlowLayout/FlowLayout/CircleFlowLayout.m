//
//  CircleFlowLayout.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/30.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "CircleFlowLayout.h"
@interface CircleFlowLayout()
@property (nonatomic, assign) CGPoint touchPoint;
@property (nonatomic,strong) NSMutableArray *attArr;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) CGFloat rotation;
@end
@implementation CircleFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(60, 60);
        self.rate = 3;
    }
    return self;
}


- (void)prepareLayout
{
    [super prepareLayout];
    
    if (!self.pan) {
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        self.collectionView.userInteractionEnabled = YES;
        [self.collectionView addGestureRecognizer:self.pan];
    }
    if (self.radius == 0) {
        self.radius = (self.collectionView.frame.size.width - 2 *self.itemSize.width - 40) * 0.5;
    }
    [self.attArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAtt = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attArr addObject:layoutAtt];
    }
}
- (void)panGes:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.touchPoint  = [pan translationInView:self.collectionView];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        CGPoint point  = [pan translationInView:self.collectionView];
        // 夹角余弦
        // 两直线夹角公式：cosφ=(A1A2+B1B2)/[√(A1^2+B1^2)√(A2^2+B2^2)]
        
        CGFloat a1 = self.touchPoint.x - self.collectionView.center.x;
        CGFloat b1 = self.touchPoint.y - self.collectionView.center.y;
        CGFloat a2 = point.x - self.collectionView.center.x;
        CGFloat b2 = point.y - self.collectionView.center.y;
        
        double cos = (a1 * a2 + b1 * b2) / (sqrt(pow(a1, 2.0) + pow(b1, 2.0)) * sqrt(pow(a2, 2.0) + pow(b2, 2.0)));

        cos = cos > 1 ? 1 : cos;
        CGFloat ara =  acos(cos);
        
        if (self.touchPoint.x != self.collectionView.center.x && point.x != self.collectionView.center.x) {
            
            CGFloat k1 = (self.touchPoint.y - self.collectionView.center.y) / (self.touchPoint.x - self.collectionView.center.x);
            CGFloat k2 = (point.y - self.collectionView.center.y) / (point.x - self.collectionView.center.x);
            if (k2 > k1) {
                self.rotation -= self.rate * ara;//控制滑动快慢 手势速率
            } else {
                self.rotation += self.rate * ara;
            }
        }
        
        [self invalidateLayout];
        self.touchPoint = point;

    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attArr;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attri = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat ra  =  indexPath.row * M_PI * 2/count;
    ra+=self.rotation;
    CGFloat centerX = cos(ra) * self.radius + self.collectionView.center.x;
    CGFloat centerY = sin(ra) * self.radius + self.collectionView.center.y;//self.collectionView.frame.size.height * 0.5
    attri.center = CGPointMake(centerX, centerY);
//    attri.transform3D = CATransform3DMakeRotation(0, 0, 0, 0.5);
    return attri;
}
- (NSMutableArray *)attArr
{
    if (!_attArr) {
        _attArr = [NSMutableArray array];
    }
    return _attArr;
}
@end
