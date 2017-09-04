//
//  LocationVCMap.m
//  ShangKTeacher
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "LocationVCMap.h"

@implementation LocationVCMap

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
}
-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, 10, 200, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(QuXiaoYlick) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    [NavBarview addSubview:button1];
}

-(void)QuXiaoYlick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
