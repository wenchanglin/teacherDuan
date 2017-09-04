//
//  MyVideoVip.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyVideoVip.h"
#import "AppDelegate.h"
#import "MemberMembershipVC.h"

@interface MyVideoVip ()
{
    NSString *UserId;
    NSInteger IsVip;
    NSString *VipExpireTime;
}
@end

@implementation MyVideoVip
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    [self createData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kAppWhiteColor;
    self.fd_interactivePopDisabled = YES;
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    //[defaults objectForKey:@"UserID"]
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId} url:UrL_VideoVipIs success:^(id responseObject) {
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSInteger errCode =[[responseObject objectForKey:@"errcode"]integerValue];
        NSLog(@"%@",responseObject);
        IsVip = [[RootDic objectForKey:@"isVip"]integerValue];
        if (errCode == 100) {
            [weakSelf createHeadView];
            [weakSelf createNav];
        }else{
            NSLog(@"可能是会员");
            if (IsVip == 1) {
                VipExpireTime = [RootDic objectForKey:@"expireTime"];
                [weakSelf createVipHeadView];
                [weakSelf createNav];
            }else if(IsVip == 2){
                [weakSelf createGuoQiVipHeadView];
                [weakSelf createNav];
            }
        }
        UserId = [RootDic objectForKey:@"data"];
        IsVip = [[RootDic objectForKey:@"isVip"]integerValue];
    } failure:^(NSError *error) {
        
    }];
}

-(void)createHeadView
{
    UIImageView *HeadPic  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    HeadPic.userInteractionEnabled = YES;
    HeadPic.image         = [UIImage imageNamed:@"图层-4@2x.png"];
    UIImageView *VipPic   = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 130)/2, 100, 30, 30)];
    VipPic.image          = [UIImage imageNamed:@"会员-(2)@2x.png"];
    UILabel *VipLabel     = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(VipPic.frame)+10, 100, 80, 30)];
    VipLabel.text         = @"包月会员";
    VipLabel.font         = [UIFont boldSystemFontOfSize:19];
    VipLabel.textColor    = kAppWhiteColor;
    UILabel *YNVip        = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 140)/2, CGRectGetMaxY(VipLabel.frame)+20, 140, 30)];
    YNVip.text            = @"您还不是会员哦!";
    YNVip.font            = [UIFont boldSystemFontOfSize:19];
    YNVip.textColor       = kAppWhiteColor;
    UIButton *BanLiBtn    = [UIButton buttonWithType:UIButtonTypeCustom];
    BanLiBtn.frame = CGRectMake((kScreenWidth - 150)/2, CGRectGetMaxY(YNVip.frame)+15, 150, 50);
    [BanLiBtn setTitle:@"立即办理" forState:UIControlStateNormal];
    BanLiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [BanLiBtn setTitleColor:kAppBlueColor forState:UIControlStateNormal];
    BanLiBtn.backgroundColor = kAppWhiteColor;
    [BanLiBtn addTarget:self action:@selector(BanLiBTn:) forControlEvents:UIControlEventTouchUpInside];
    
    [HeadPic   addSubview:BanLiBtn];
    [HeadPic   addSubview:YNVip];
    [HeadPic   addSubview:VipLabel];
    [HeadPic   addSubview:VipPic];
    [self.view addSubview:HeadPic];
}

-(void)createVipHeadView
{
    UIImageView *HeadPic  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    HeadPic.userInteractionEnabled = YES;
    HeadPic.image         = [UIImage imageNamed:@"图层-4@2x.png"];
    UIImageView *VipPic   = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 130)/2, 100, 30, 30)];
    VipPic.image          = [UIImage imageNamed:@"会员-(2)@2x_57副本.png"];
    UILabel *VipLabel     = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(VipPic.frame)+10, 100, 80, 30)];
    VipLabel.text         = @"包月会员";
    VipLabel.font         = [UIFont boldSystemFontOfSize:19];
    VipLabel.textColor    = kAppWhiteColor;
    UILabel *YNVip        = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - kScreenWidth/1.5)/2, CGRectGetMaxY(VipLabel.frame)+20, kScreenWidth/1.5, 30)];
    NSString * timeStampString = VipExpireTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    YNVip.text            = [NSString stringWithFormat:@"截止时间%@",time];
    YNVip.font            = [UIFont boldSystemFontOfSize:19];
    YNVip.textColor       = kAppWhiteColor;
    UIButton *BanLiBtn    = [UIButton buttonWithType:UIButtonTypeCustom];
    BanLiBtn.frame = CGRectMake((kScreenWidth - 150)/2, CGRectGetMaxY(YNVip.frame)+15, 150, 50);
    [BanLiBtn setTitle:@"立即续费" forState:UIControlStateNormal];
    BanLiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [BanLiBtn setTitleColor:kAppBlueColor forState:UIControlStateNormal];
    BanLiBtn.backgroundColor = kAppWhiteColor;
    [BanLiBtn addTarget:self action:@selector(BanLiBTn:) forControlEvents:UIControlEventTouchUpInside];
    
    [HeadPic   addSubview:BanLiBtn];
    [HeadPic   addSubview:YNVip];
    [HeadPic   addSubview:VipLabel];
    [HeadPic   addSubview:VipPic];
    [self.view addSubview:HeadPic];
}

-(void)createGuoQiVipHeadView
{
    UIImageView *HeadPic  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    HeadPic.userInteractionEnabled = YES;
    HeadPic.image         = [UIImage imageNamed:@"图层-4@2x.png"];
    UIImageView *VipPic   = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 130)/2, 100, 30, 30)];
    VipPic.image          = [UIImage imageNamed:@"会员-(2)@2x.png"];
    UILabel *VipLabel     = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(VipPic.frame)+10, 100, 80, 30)];
    VipLabel.text         = @"包月会员";
    VipLabel.font         = [UIFont boldSystemFontOfSize:19];
    VipLabel.textColor    = kAppWhiteColor;
    UILabel *YNVip        = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 140)/2, CGRectGetMaxY(VipLabel.frame)+20, 140, 30)];
    YNVip.text            = @"你的会员已过期!";
    YNVip.font            = [UIFont boldSystemFontOfSize:19];
    YNVip.textColor       = kAppWhiteColor;
    UIButton *BanLiBtn    = [UIButton buttonWithType:UIButtonTypeCustom];
    BanLiBtn.frame = CGRectMake((kScreenWidth - 150)/2, CGRectGetMaxY(YNVip.frame)+15, 150, 50);
    [BanLiBtn setTitle:@"立即续费" forState:UIControlStateNormal];
    BanLiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [BanLiBtn setTitleColor:kAppBlueColor forState:UIControlStateNormal];
    BanLiBtn.backgroundColor = kAppWhiteColor;
    [BanLiBtn addTarget:self action:@selector(BanLiBTn:) forControlEvents:UIControlEventTouchUpInside];
    
    [HeadPic   addSubview:BanLiBtn];
    [HeadPic   addSubview:YNVip];
    [HeadPic   addSubview:VipLabel];
    [HeadPic   addSubview:VipPic];
    [self.view addSubview:HeadPic];
}

-(void)BanLiBTn:(UIButton *)BanBtn
{
    NSLog(@"办理会员");
    MemberMembershipVC *ship = [[MemberMembershipVC alloc]init];
    [self.navigationController pushViewController:ship animated:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppClearColor;
    
    UILabel *label    = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text        = @"视频会员";
    label.font        = [UIFont boldSystemFontOfSize:16];
    label.textColor   = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame     = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaBtnlick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}

-(void)BaBtnlick:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
