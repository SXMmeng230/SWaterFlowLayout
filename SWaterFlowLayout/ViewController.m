//
//  ViewController.m
//  SWaterFlowLayout
//
//  Created by 小萌 on 2018/5/29.
//  Copyright © 2018年 sunxm. All rights reserved.
//

#import "ViewController.h"

#import "SFlowLayoutViewController.h"
#import "SCircleFlowViewController.h"
#import "SCardFlowLayoutViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)clickWaterFlow:(UIButton *)sender
{
    SFlowLayoutViewController *flowVC = [[SFlowLayoutViewController alloc] init];
    [self.navigationController pushViewController:flowVC animated:YES];
}
- (IBAction)clickCircleFlow:(UIButton *)sender
{
    SCircleFlowViewController *circleFlow = [[SCircleFlowViewController alloc] init];
    [self.navigationController pushViewController:circleFlow animated:YES];
}
- (IBAction)clickCardFlow:(UIButton *)sender
{
    SCardFlowLayoutViewController *cardFlow = [[SCardFlowLayoutViewController alloc] init];
    [self.navigationController pushViewController:cardFlow animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
