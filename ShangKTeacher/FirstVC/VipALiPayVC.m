//
//  VipALiPayVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "VipALiPayVC.h"
#import "VideoClass.h"
#import "MyVideoVip.h"
#import "MyOrderVC.h"
@implementation VipALiPayVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self createNAv];
    self.view.backgroundColor = kAppBlackColor;
}

-(void)createUI
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSString *html = [NSString stringWithFormat:@"<html><body>%@</body></html>",self.AliMSG];
    [webView loadHTMLString:html baseURL:nil];
    [self.view addSubview:webView];
}

-(void)createNAv
{
    UIView *BarView = [[UIView alloc]initWithFrame:CGRectMake(20, kScreenHeight-250, 60, 60)];
    BarView.backgroundColor = kAppWhiteColor;
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(10, 10, 40, 40);
    [Btn setBackgroundImage:[UIImage imageNamed:@"图层-65@2x.png"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(Close:) forControlEvents:UIControlEventTouchUpInside];
    [BarView addSubview:Btn];
    [self.view addSubview:BarView];
}

-(void)Close:(UIButton *)BaBtn
{
    if ([self.ChooseTitle isEqualToString:@"BuyVideo"]){
        VideoClass *video = [[VideoClass alloc]init];
        video.PayTit = @"Alerady";
        [self.navigationController pushViewController:video animated:YES];
    }else if ([self.ChooseTitle isEqualToString:@"VipGet"]){
        MyVideoVip *vip = [[MyVideoVip alloc]init];
        [self.navigationController pushViewController:vip animated:YES];
    }else if ([self.ChooseTitle isEqualToString:@"SpBuy"]){
        MyOrderVC *vip = [[MyOrderVC alloc]init];
        vip.PayTit = @"AlL";
        [self.navigationController pushViewController:vip animated:YES];
    }
    
}
@end
