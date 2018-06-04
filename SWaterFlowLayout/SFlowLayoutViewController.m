//
//  SFlowLayoutViewController.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/30.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "SFlowLayoutViewController.h"
#import "TestCollectionViewCell.h"
#import "WaterFlowLayout.h"
#import "MJRefresh.h"

static NSString *identifierCell = @"TestCollectionViewCell";

@interface SFlowLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SWaterFlowLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation SFlowLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.heightArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 30; i ++) {
        int x = arc4random() % 5;
        [self.dataArray addObject:[NSString stringWithFormat:@"img_0%d",1 + x]];
        
        int y = arc4random() % 100;
        [self.heightArray addObject:@(100 + y)];

    }
        WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
        flowLayout.delegateFlow = self;
        flowLayout.column = 3;
        flowLayout.columnSpacing = 3;
        flowLayout.rowSpacing = 3;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 3, 0, 3);
        [self.collectionView setCollectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifierCell];
    
        self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    
    
}
- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (NSInteger i = 0; i < 30; i ++) {
            int x = arc4random() % 5;
            [self.dataArray addObject:[NSString stringWithFormat:@"img_0%d",1 + x]];
            
            int y = arc4random() % 100;
            [self.heightArray addObject:@(100 + y)];
        }
        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];
    });
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    cell.ivHead.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)itemHeightWithlayout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  [self.heightArray[indexPath.row] doubleValue];
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
