//
//  WaterFlowLayout.h
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/29.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWaterFlowLayoutDelegate<NSObject>

- (CGFloat)itemHeightWithlayout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface WaterFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign)id <SWaterFlowLayoutDelegate>delegateFlow;

/**
 列数 默认：2
 */
@property (nonatomic, assign) NSInteger column;
/**
 列间距 默认 1px
 */
@property (nonatomic, assign) CGFloat columnSpacing;
/**
 行间距 默认 1px
 */
@property (nonatomic, assign) CGFloat rowSpacing;
@end
