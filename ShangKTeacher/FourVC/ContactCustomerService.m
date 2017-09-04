//
//  ContactCustomerService.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ContactCustomerService.h"

@implementation ContactCustomerService
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createUI
{
    UIButton *ServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ServiceBtn.frame = CGRectMake(0, 62, kScreenWidth, kScreenHeight/3.5);
    [ServiceBtn setBackgroundImage:[UIImage imageNamed:@"组-1@2x_12.png"] forState:UIControlStateNormal];
    ServiceBtn.userInteractionEnabled = NO;
    UILabel *KefuQLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/2)/2, CGRectGetMaxY(ServiceBtn.frame)+10, kScreenWidth/2, 20)];
    KefuQLabel.text = @"客服 QQ:3410933974";
//    KefuQLabel.textAlignment = NSTextAlignmentCenter;
    KefuQLabel.font = [UIFont boldSystemFontOfSize:18];
    UILabel *WeiXinLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/2)/2, CGRectGetMaxY(KefuQLabel.frame)+10, kScreenWidth/2, 20)];
    WeiXinLabel.text = @"客服微信:skb-kf";
//    WeiXinLabel.textAlignment = NSTextAlignmentCenter;
    WeiXinLabel.font = [UIFont boldSystemFontOfSize:18];
    
    UILabel *PhoneLAbel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenWidth/2)/2, CGRectGetMaxY(WeiXinLabel.frame)+10, kScreenWidth/2, 20)];
//    PhoneLAbel.textAlignment = NSTextAlignmentCenter;
    PhoneLAbel.font = [UIFont boldSystemFontOfSize:18];
    NSMutableAttributedString *AttStr = [[NSMutableAttributedString alloc]initWithString:@"客服电话:18616610235"];
    [AttStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(5,11)];
    PhoneLAbel.attributedText = AttStr;
    UIButton *PhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    PhoneBtn.frame = CGRectMake((kScreenWidth - 100)/2, CGRectGetMaxY(PhoneLAbel.frame)+20, 100, 50);
    [PhoneBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    PhoneBtn.layer.cornerRadius = 8;
    PhoneBtn.layer.masksToBounds = YES;
    PhoneBtn.backgroundColor = kAppBlueColor;
    [PhoneBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    [PhoneBtn addTarget:self action:@selector(PhoneBtn) forControlEvents:UIControlEventTouchUpInside];
    UILabel * LineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight - 90, kScreenWidth, 1)];
    LineLabel.backgroundColor = kAppLineColor;
    UILabel *CompanyLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenWidth/1.6)/2, kScreenHeight - 70, kScreenWidth/1.6, 20)];
    CompanyLabel.font = [UIFont systemFontOfSize:15];
    CompanyLabel.textAlignment = NSTextAlignmentCenter;
    CompanyLabel.text = @"上海盟课网络科技有限公司";
    CompanyLabel.textColor = kAppLineColor;
    CompanyLabel.backgroundColor = kAppClearColor;
    
    [self.view addSubview:CompanyLabel];
    [self.view addSubview:LineLabel];
    [self.view addSubview:KefuQLabel];
    [self.view addSubview:WeiXinLabel];
    [self.view addSubview:PhoneBtn];
    [self.view addSubview:PhoneLAbel];
    [self.view addSubview:ServiceBtn];
}

-(void)PhoneBtn
{
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"18616610235"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text = @"联系客服";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
