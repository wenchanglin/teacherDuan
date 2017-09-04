//
//  AboutUS.m
//  ShangKOrganization
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AboutUS.h"

@implementation AboutUS

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
    UIButton *AboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    AboutBtn.frame = CGRectMake((kScreenWidth - kScreenWidth/4)/2, 80, kScreenWidth/4, kScreenWidth/4);
    [AboutBtn setBackgroundImage:[UIImage imageNamed:@"使用帮助hyh.png"] forState:UIControlStateNormal];
    AboutBtn.userInteractionEnabled = NO;
    UILabel *AboutLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenWidth/4)/2, CGRectGetMaxY(AboutBtn.frame)+10, kScreenWidth/4, 30)];
    AboutLabel.text = @"关于我们";
    AboutLabel.textColor = kAppBlackColor;
    AboutLabel.font = [UIFont boldSystemFontOfSize:20];
    AboutLabel.textAlignment = NSTextAlignmentCenter;
    AboutLabel.backgroundColor = kAppClearColor;
    UILabel * CompanyTit = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(AboutLabel.frame)+10, kScreenWidth - 40, 20)];
    CompanyTit.text = @"      “上课呗教育平台”主要是为线下的全国中小培训机构提供裂变式招生、营销推广、粉丝运营、作业管理等综合教育平台。将在全国600多个城市开展教育平台服务。为全国各种类型的中小培训机构和全国学生、家长提供互联网+教育的APP平台。一共有多个端，分别为：APP家长端、APP机构端、APP教师端、PC商家端、PC在线教育端等。";
    CompanyTit.numberOfLines = 0;
    CGRect textFrame = CompanyTit.frame;
    CompanyTit.frame = CGRectMake(20, CGRectGetMaxY(AboutLabel.frame)+10, kScreenWidth - 40, textFrame.size.height = [CompanyTit.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:CompanyTit.font,NSFontAttributeName ,nil] context:nil].size.height);
    CompanyTit.font = [UIFont systemFontOfSize:16];
    CompanyTit.frame = CGRectMake(20, CGRectGetMaxY(AboutLabel.frame)+10, kScreenWidth - 40, textFrame.size.height);
    UILabel *MoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(CompanyTit.frame)+15, kScreenWidth - 40, 20)];
    MoreLabel.font = [UIFont systemFontOfSize:16];
    MoreLabel.text = @"更多详细视频介绍请登录上课呗官方网站";
    UILabel *UrlLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(MoreLabel.frame)+10, kScreenWidth - 40, 20)];
    UrlLabel.font = [UIFont systemFontOfSize:16];
    UrlLabel.text = @"http://www.skbjypt.com";
    
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
    [self.view addSubview:MoreLabel];
    [self.view addSubview:UrlLabel];
    [self.view addSubview:AboutBtn];
    [self.view addSubview:AboutLabel];
    [self.view addSubview:CompanyTit];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text = @"关于我们";
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
