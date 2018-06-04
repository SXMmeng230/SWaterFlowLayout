//
//  CardFlowLayout.h
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/6/4.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCardFlowLayoutDelegate<NSObject>

- (CGFloat)itemWidthWithlayout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CardFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id <SCardFlowLayoutDelegate>flowDelegate;
/**
 列间距 默认 5dp
 */
@property (nonatomic, assign) CGFloat columnSpacing;
/**
 行间距 默认 5dp
 */
@property (nonatomic, assign) CGFloat rowSpacing;

/**
 cell高度 默认 30
 */
@property (nonatomic, assign) CGFloat itemHeight;

@end
