//
//  UseHelpVC.m
//  ShangKTeacher
//
//  Created by apple on 16/12/29.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "UseHelpVC.h"

@interface UseHelpVC ()

@end

@implementation UseHelpVC
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
    AboutLabel.text = @"使用帮助";
    AboutLabel.textColor = kAppBlackColor;
    AboutLabel.font = [UIFont boldSystemFontOfSize:20];
    AboutLabel.textAlignment = NSTextAlignmentCenter;
    AboutLabel.backgroundColor = kAppClearColor;
    UILabel * CompanyTit = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(AboutLabel.frame)+10, kScreenWidth - 40, 20)];
    CompanyTit.text = @"在使用过程中，有任何问题可以通过以下方式提到帮助";
    CompanyTit.numberOfLines = 0;
    CGRect textFrame = CompanyTit.frame;
    CompanyTit.frame = CGRectMake(20, CGRectGetMaxY(AboutLabel.frame)+10, kScreenWidth - 40, textFrame.size.height = [CompanyTit.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:CompanyTit.font,NSFontAttributeName ,nil] context:nil].size.height);
    CompanyTit.font = [UIFont systemFontOfSize:16];
    CompanyTit.frame = CGRectMake(20, CGRectGetMaxY(AboutLabel.frame)+10, kScreenWidth - 40, textFrame.size.height);
    UILabel *labelTen = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(CompanyTit.frame)-10, kScreenWidth-40, 60)];
    labelTen.text = @"1、通过在官网上观看教学视频所有功能在官网上都有详细的视频操作介绍";
    labelTen.numberOfLines = 0;
    CGRect textFrame9 = labelTen.frame;
    labelTen.frame = CGRectMake(20, CGRectGetMaxY(CompanyTit.frame), kScreenWidth - 40, textFrame9.size.height = [labelTen.text boundingRectWithSize:CGSizeMake(textFrame9.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:labelTen.font,NSFontAttributeName ,nil] context:nil].size.height);
    labelTen.frame = CGRectMake(20, CGRectGetMaxY(CompanyTit.frame)+5, kScreenWidth - 40, textFrame9.size.height);
    labelTen.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelTen];
    UILabel *labelOne = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(labelTen.frame)+5, kScreenWidth-40, 20)];
    labelOne.text = @"2、通过微信客服咨询（客服微信:skb-kf）";
    labelOne.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelOne];
    UILabel *labelTwo = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(labelOne.frame)+5, kScreenWidth-40, 20)];
    labelTwo.text = @"3、通过QQ客服咨询（QQ:3410933974）";
    labelTwo.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelTwo];
    UILabel *labelThree = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(labelTwo.frame)+5, kScreenWidth-40, 20)];
    labelThree.text = @"4、通过电话咨询（客服电话:18616610235）";
    labelThree.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelThree];
    UILabel *labelT = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(labelThree.frame)-10, kScreenWidth-40, 60)];
    labelT.text = @"另外如果您觉得这样还嫌麻烦，也可以委托给我们客服，客服会安排您的客服秘书帮您设置一切操作。可以通过以下方式来联系找秘书委托代操作：";
    labelT.numberOfLines = 0;
    CGRect textFrame1 = labelT.frame;
    labelT.frame = CGRectMake(20, CGRectGetMaxY(labelThree.frame), kScreenWidth - 40, textFrame1.size.height = [labelT.text boundingRectWithSize:CGSizeMake(textFrame1.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:labelT.font,NSFontAttributeName ,nil] context:nil].size.height);
    labelT.frame = CGRectMake(20, CGRectGetMaxY(labelThree.frame)+5, kScreenWidth - 40, textFrame1.size.height);
    labelT.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelT];
    UILabel *labelfour = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(labelT.frame)+5, kScreenWidth-40, 20)];
    labelfour.text = @"客服QQ:3410933974";
    labelfour.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelfour];
    UILabel *labelTfive = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(labelfour.frame)+5, kScreenWidth-40, 20)];
    labelTfive.text = @"客服微信:skb-kf";
    labelTfive.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelTfive];
    UILabel *labelsix = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(labelTfive.frame)+5, kScreenWidth-40, 20)];
    labelsix.text = @"客服热线:18616610235";
    labelsix.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelsix];
    
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
    [self.view addSubview:AboutBtn];
    [self.view addSubview:AboutLabel];
    [self.view addSubview:CompanyTit];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text = @"使用帮助";
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
