//
//  CircleFlowLayout.h
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/30.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleFlowLayout : UICollectionViewFlowLayout

/**
 半径
 */
@property (nonatomic, assign) CGFloat radius;

/**
 滑动速率 默认3倍
 */
@property (nonatomic, assign) CGFloat rate;

@end
