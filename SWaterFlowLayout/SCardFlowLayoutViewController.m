//
//  SCardFlowLayoutViewController.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/6/4.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "SCardFlowLayoutViewController.h"
#import "SCardCell.h"
#import "CardFlowLayout.h"
static NSString *identifierCell = @"SCardCell";

@interface SCardFlowLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SCardFlowLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;



@end

@implementation SCardFlowLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataArr addObjectsFromArray:@[@"衣服服服",@"鞋子",@"包服服服服包",@"裤子",@"项链",@"首饰",@"帽子",@"上衣",@"鞋子",@"篮球",@"乒乓球",@"羽毛球羽毛球羽毛球",@"冰球",@"橄榄球"]];
    CardFlowLayout *flow = [[CardFlowLayout alloc] init];
    flow.flowDelegate = self;
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
- (NSMutableArray *)cellAttributesArray
{
    if (!_cellAttributesArray) {
        _cellAttributesArray = [NSMutableArray array];
    }
    return _cellAttributesArray;
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
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}
- (CGFloat)itemWidthWithlayout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *img = self.dataArr[indexPath.row];
    CGFloat width = [img boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.width;
    return width + 30;
}

#pragma mark - 手势
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    SCardCell *cell = (SCardCell *)longPress.view;
    NSIndexPath *cellIndexpath = [_collectionView indexPathForCell:cell];
    [_collectionView bringSubviewToFront:cell];
    _isChange = NO;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.dataArr.count; i++) {
                [self.cellAttributesArray addObject:[_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            cell.center = [longPress locationInView:_collectionView];
            
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    _isChange = YES;
                    NSString *imgStr = self.dataArr[cellIndexpath.row];
                    [self.dataArr removeObjectAtIndex:cellIndexpath.row];
                    [self.dataArr insertObject:imgStr atIndex:attributes.indexPath.row];
                    [self.collectionView moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                    break;
                }
            }
            
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            if (!_isChange) {
                cell.center = [_collectionView layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
        }
            
            break;
            
        default:
            break;
    }
    
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
