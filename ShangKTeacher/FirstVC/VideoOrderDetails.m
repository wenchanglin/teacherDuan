//
//  VideoOrderDetails.m
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "VideoOrderDetails.h"
#import "MemberMembershipVC.h"
#import "VipALiPayVC.h"
#import "PayMoneyOrderVC.h"
@interface VideoOrderDetails ()
{
    UILabel *PriceLabel;
}
@property(nonatomic,strong)UILabel     * accountLabel;
@property(nonatomic,strong)UIButton    * resultBtn;
@end

@implementation VideoOrderDetails

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    [self CreateFootView];
    self.view.backgroundColor = KAppBackBgColor;
}

-(void)createUI
{
    UIView *BarView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/3.3)];
    BarView.backgroundColor = kAppWhiteColor;
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 35)];
    Label.text     = @"来源:";
    Label.font     = [UIFont boldSystemFontOfSize:17];
    UILabel *LineLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(Label.frame)+5, kScreenWidth, 1)];
    LineLabel.alpha     = 0.5;
    LineLabel.backgroundColor = kAppLineColor;
    UIImageView *imageView    = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LineLabel.frame)+10, kScreenWidth/4+20, kScreenWidth/4+20)];
    imageView.image     = [UIImage imageNamed:@"图层-69@2x_15.png"];
    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, CGRectGetMaxY(LineLabel.frame)+15, kScreenWidth-(CGRectGetMaxX(imageView.frame)+20), 20)];
    TitleLabel.text     = self.OrderCourseName;
    TitleLabel.font     = [UIFont boldSystemFontOfSize:17];
    TitleLabel.numberOfLines = 0;
    CGRect textFrame    = TitleLabel.frame;
    TitleLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+10, CGRectGetMaxY(LineLabel.frame)+15, kScreenWidth-(CGRectGetMaxX(imageView.frame)+20), textFrame.size.height = [TitleLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:TitleLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
    TitleLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+10, CGRectGetMaxY(LineLabel.frame)+15, kScreenWidth-(CGRectGetMaxX(imageView.frame)+20), textFrame.size.height);
    PriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, CGRectGetMaxY(LineLabel.frame)+kScreenWidth/4+10, kScreenWidth-(CGRectGetMaxX(imageView.frame)+20), 20)];
    PriceLabel.text  = [NSString stringWithFormat:@"¥%@",self.OrderCoursePrice];
    PriceLabel.textColor = kAppRedColor;
    PriceLabel.font  = [UIFont boldSystemFontOfSize:17];
    
    [BarView addSubview:LineLabel];
    [BarView addSubview:Label];
    [BarView addSubview:imageView];
    [BarView addSubview:TitleLabel];
    [BarView addSubview:PriceLabel];
    [self.view addSubview:BarView];
}

-(void)CreateFootView
{
    UIView *TitleFootView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 54)];
    TitleFootView.backgroundColor = kAppWhiteColor;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    imageView.image = [UIImage imageNamed:@"78@2x.png"];
    _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, 140, 30)];
    [TitleFootView addSubview:_accountLabel];
    _accountLabel.text =[NSString stringWithFormat:@"总额:¥%@",self.OrderCoursePrice];
    _resultBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-100, 0, 100, 44)];
    [TitleFootView addSubview:_resultBtn];
    [_resultBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_resultBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    _resultBtn.tag = 5;
    [_resultBtn addTarget:self action:@selector(PicZeroClick:) forControlEvents:UIControlEventTouchUpInside];
    _resultBtn.backgroundColor = kAppRedColor;
    
    [TitleFootView addSubview:imageView];
    [TitleFootView addSubview:_accountLabel];
    [TitleFootView addSubview:_resultBtn];
    [self.view addSubview:TitleFootView];
}

-(void)PicZeroClick:(UIButton *)BTn
{
//    NSLog(@"提交订单");
    NSLog(@"%@",_OrderCoursePrice);
    NSLog(@"%@",_OrderCourseId);
//    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];//self.OrderCoursePrice
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkVideoCourseId":self.OrderCourseId,@"fkUserId":Manager.UUserId,@"payPrice":self.OrderCoursePrice} url: UrL_BuyVideoS success:^(id responseObject) {
        NSLog(@"我看%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSString *VideoId = [RootDic objectForKey:@"id"];
        PayMoneyOrderVC *pay = [[PayMoneyOrderVC alloc]init];
        pay.SumPrice = [self.OrderCoursePrice doubleValue];
        pay.OrderId = VideoId;
        pay.PayMoneyChoose = @"BuyVideo";
        [self.navigationController pushViewController:pay animated:YES];
//        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":VideoId} url:UrL_ALiPayOrder success:^(id responseObject) {
//            NSString *AliPayWeb = [responseObject objectForKey:@"msg"];
//            VipALiPayVC *Ali = [[VipALiPayVC alloc]init];
//            Ali.ChooseTitle = @"BuyVideo";
//            Ali.AliMSG = AliPayWeb;
//            [weakSelf.navigationController pushViewController:Ali animated:YES];
//        } failure:^(NSError *error) {
//        }];
    } failure:^(NSError *error) {
    }];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"提交订单";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 80, 10, 70, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"会员包月" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(VipClick) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)VipClick
{
    NSLog(@"会员包月");
    MemberMembershipVC *MemberShip = [[MemberMembershipVC alloc]init];
    [self.navigationController pushViewController:MemberShip animated:YES];
}

@end
