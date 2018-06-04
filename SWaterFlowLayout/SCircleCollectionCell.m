//
//  SCircleCollectionCell.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/30.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "SCircleCollectionCell.h"
@interface SCircleCollectionCell()

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@end
@implementation SCircleCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lbName.layer.cornerRadius = self.frame.size.width * 0.5;
    self.lbName.layer.masksToBounds = YES;
}
- (void)configName:(NSString *)name
{
    self.lbName.text = name;
}
@end
