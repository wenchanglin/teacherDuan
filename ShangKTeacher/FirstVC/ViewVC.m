//
//  ViewVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ViewVC.h"
@implementation ViewVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createView
{
    UIView *BarView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/2, kScreenWidth, kScreenHeight/2)];
    BarView.backgroundColor = kAppBlueColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = kAppOrangeColor;
    button.frame = CGRectMake(49, 49, 40, 49);
    [button addTarget:self action:@selector(BBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [BarView addSubview:button];
    
    [self.view addSubview:BarView];
}

-(void)BBtn:(UIButton *)tn
{
    NSLog(@"关闭");
}

@end
