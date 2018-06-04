//
//  SCircleFlowViewController.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/30.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "SCircleFlowViewController.h"
#import "CircleFlowLayout.h"
#import "SCircleCollectionCell.h"

static NSString *identifierCell = @"SCircleCollectionCell";


@interface SCircleFlowViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation SCircleFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CircleFlowLayout *circleFlow = [[CircleFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:circleFlow];
    [self.dataArr addObjectsFromArray:@[@"红烧鱼",@"干煸豆角",@"辣子鸡",@"青椒鸡蛋",@"排骨",@"鲍鱼",@"糖醋鱼",@"里脊肉",@"东北大乱炖"]];

    [self.collectionView registerNib:[UINib nibWithNibName:@"SCircleCollectionCell" bundle:nil] forCellWithReuseIdentifier:identifierCell];
    

}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SCircleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    [cell configName:self.dataArr[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
