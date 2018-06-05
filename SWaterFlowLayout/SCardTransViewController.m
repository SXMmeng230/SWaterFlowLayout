//
//  SCardTransViewController.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/6/4.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "SCardTransViewController.h"
#import "SCardCell.h"
#import "CardTransFlowLayout.h"
static NSString *identifierCell = @"SCardCell";

@interface SCardTransViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation SCardTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataArr addObjectsFromArray:@[@"衣服服服",@"鞋子",@"包服服服服包",@"裤子",@"项链",@"首饰",@"帽子",@"上衣",@"鞋子",@"篮球",@"乒乓球",@"羽毛球羽毛球羽毛球",@"冰球",@"橄榄球"]];
    CardTransFlowLayout *flow = [[CardTransFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:flow];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SCardCell" bundle:nil] forCellWithReuseIdentifier:identifierCell];

    // Do any additional setup after loading the view from its nib.
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
    SCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    cell.lbTitle.text = self.dataArr[indexPath.row];    
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
