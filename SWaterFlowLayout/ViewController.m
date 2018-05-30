//
//  ViewController.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/29.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "ViewController.h"
#import "TestCollectionViewCell.h"
#import "WaterFlowLayout.h"
#import "MJRefresh.h"

static NSString *identifierCell = @"TestCollectionViewCell";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SWaterFlowLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *heightArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.heightArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i ++) {
        int x = arc4random() % 100;
        [self.heightArray addObject:@(100 + x)];
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
            int x = arc4random() % 100;
            [self.heightArray addObject:@(100 + x)];
        }
        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];
    });
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.heightArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor greenColor];
    }else{
        cell.backgroundColor = [UIColor redColor];
    }
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


@end
