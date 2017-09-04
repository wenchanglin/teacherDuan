//
//  FourVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FourVC.h"
#import "AppDelegate.h"
#import "MyAccountVC.h"
#import "MyVideos.h"
#import "MyVideoVip.h"
#import "MyPointVC.h"
#import "SystemSetingVC.h"
#import "MyCompanyInfoVC.h"
#import "MyOrderVC.h"
#import "MyOrderCar.h"
#define PictureArr @[@"购物车-(1)@2x.png",@"账户-(1)@2x.png",@"视频-(12)@2x.png",@"会员-(3)@2x.png",@"积分-(3)@2x.png",@"设置-(2)@2x"]
#define TitleARr @[@"购物车",@"我的账户",@"我的视频",@"视频会员",@"我的积分",@"系统设置"]
@interface FourVC ()
{
    NSString *_UserInfoIntro;
    NSString *_UserInfoPhone;
    NSInteger _UserInfoAge;
    NSInteger _UserInfoSex;
    NSString *_UserInfoName;
    NSString *_OrgInfoName;
    NSString *_UserInfoImage;
}
@end

@implementation FourVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
    [self createDAta];
}

-(void)createDAta
{
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId} url:UrL_SearchTeacher success:^(id responseObject) {
        NSLog(@"看看%@",responseObject);
        NSDictionary *rootTDic = [responseObject objectForKey:@"data"];
        NSDictionary *diTct = [rootTDic objectForKey:@"userInfoBase"];
        _UserInfoIntro = [diTct objectForKey:@"intro"];
        _UserInfoAge   = [[diTct objectForKey:@"age"]integerValue];
        _UserInfoSex   = [[diTct objectForKey:@"sex"]integerValue];
        _UserInfoPhone = [diTct objectForKey:@"phone"];
        _UserInfoName  = [diTct objectForKey:@"nickName"];
        _UserInfoImage = [diTct objectForKey:@"userPhotoHead"];
        [defaults setObject:[diTct objectForKey:@"username"] forKey:@"UinfoUser"];
        [defaults synchronize];
        NSLog(@"信息%ld %ld %@ %@",(long)_UserInfoAge,(long)_UserInfoSex,_UserInfoIntro,_UserInfoPhone);
        NSDictionary *Dict = [rootTDic objectForKey:@"userInfoOrg"];
        NSDictionary *DiY = [Dict objectForKey:@"userBase"];
        _OrgInfoName = [DiY objectForKey:@"nickName"];
        [weakSelf createHeadView];
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSEcondView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createHeadView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UIView *HeadView       = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight/2.5)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(HeadView.frame) - 120)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TApImageView:)];
    imageView.image        = [UIImage imageNamed:@"图层-10-副本@2x.png"];
    UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame           = CGRectMake(20, (CGRectGetMaxY(HeadView.frame) - 220)/2,kScreenWidth/3.5, kScreenWidth/3.5);
    button.layer.cornerRadius  = kScreenWidth/3.5/2;
    button.layer.masksToBounds = YES;
    [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_UserInfoImage]]];
    [button addTarget:self action:@selector(PersonPic:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *PicArr        = @[@"姓名@2x.png",@"周边机构-拷贝@2x.png"];
    NSLog(@"真好笑%@",_OrgInfoName);
    NSString *NameOrg;
    if ([defaults objectForKey:@"OrgName"] == nil) {
        NameOrg = _OrgInfoName;
    }else{
        NameOrg = [defaults objectForKey:@"OrgName"];
    }
    NSArray *TitleArr      = @[_UserInfoName,NameOrg];
    for (int i=0; i<2; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+10, (CGRectGetMaxY(HeadView.frame) - 220)/2 +10+50*i, 25, 25)];
        image.image        = [UIImage imageNamed:PicArr[i]];
        UILabel *label     = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +10+50*i, kScreenWidth - 150, 25)];
        label.text         = TitleArr[i];
        label.font         = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = kAppWhiteColor;
        CGRect textFrame   = label.frame;
        label.frame = CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +15+50*i, kScreenWidth - 160, textFrame.size.height = [label.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName ,nil] context:nil].size.height);
        //        NSLog(@"%f",textFrame.size.height);
        if (textFrame.size.height>50) {
            label.frame = CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +15+35*i, kScreenWidth - 160, textFrame.size.height);
        }else{
            label.frame = CGRectMake(CGRectGetMaxX(button.frame)+40,  (CGRectGetMaxY(HeadView.frame) - 220)/2 +15+50*i, kScreenWidth - 160, textFrame.size.height);
        }
        [imageView addSubview:image];
        [imageView addSubview:label];
    }
    UILabel *FixLAbel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/3)/2, CGRectGetMaxY(imageView.frame)-25, kScreenWidth/3, 20)];
    FixLAbel.text = @"(点击修改资料)";
    FixLAbel.textColor = kAppWhiteColor;
    FixLAbel.font = [UIFont systemFontOfSize:16];
    FixLAbel.textAlignment = NSTextAlignmentCenter;
    FixLAbel.userInteractionEnabled = YES;
    [imageView addSubview:FixLAbel];
    UIImageView *SpPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, 30, 30)];
    SpPic.image        = [UIImage imageNamed:@"我的订单@2x.png"];
    UILabel *SpLabel   = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(imageView.frame)+10, kScreenWidth - 130, 30)];
    SpLabel.text       = @"商品订单";
    SpLabel.font       = [UIFont boldSystemFontOfSize:18];
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10+40, kScreenWidth, 1)];
    lineLabel.backgroundColor = kAppLineColor;
    NSArray *TitArr    = @[@"待收货",@"待发货",@"待评价",@"退货",@"历史订单"];
    NSArray *LageARr   = @[@"图层-77@2x.png",@"图层-78@2x.png",@"待评价-(1)@2x.png",@"图层-80@2x_42.png",@"下载(62)@2x.png"];
    for (int i=0; i<5; i++) {
        UIButton *PersonButton = [UIButton buttonWithType:UIButtonTypeCustom];
        PersonButton.tag       = i;
        PersonButton.frame     = CGRectMake(20+i*30+i*(kScreenWidth - 40 -150)/4, CGRectGetMaxY(imageView.frame)+10+40+10, 30, 30);
        [PersonButton setBackgroundImage:[UIImage imageNamed:LageARr[i]] forState:UIControlStateNormal];
        if (PersonButton.tag == 0) {
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(23, -7, 14, 14)];
//            label.text                = @"2";
//            label.textColor           = kAppWhiteColor;
//            label.backgroundColor     = kAppRedColor;
//            label.textAlignment       = NSTextAlignmentCenter;
//            label.layer.cornerRadius  =7;
//            label.layer.masksToBounds =YES;
//            label.font                = [UIFont systemFontOfSize:11];
//            [PersonButton addSubview:label];
        }
        [PersonButton addTarget:self action:@selector(PersonInfoBTn:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *PersonLabel   = [[UILabel alloc]initWithFrame:CGRectMake(5+i*30+i*(kScreenWidth - 40 -150)/4, CGRectGetMaxY(imageView.frame)+10+30+55, 60, 15)];
        PersonLabel.font       = [UIFont systemFontOfSize:14];
        PersonLabel.textAlignment = NSTextAlignmentCenter;
        PersonLabel.text       = TitArr[i];
        [HeadView addSubview:PersonButton];
        [HeadView addSubview:PersonLabel];
    }
    [imageView addGestureRecognizer:tap];
    [imageView addSubview:button];
    [HeadView  addSubview:SpPic];
    [HeadView  addSubview:SpLabel];
    [HeadView  addSubview:lineLabel];
    [HeadView  addSubview:imageView];
    [self.view addSubview:HeadView];
}

//个人头像
-(void)PersonPic:(UIButton *)Picbtn
{
    MyCompanyInfoVC *info = [[MyCompanyInfoVC alloc]init];
    info.UserAge = _UserInfoAge;
    info.UserSex = _UserInfoSex;
    info.UserIntro = _UserInfoIntro;
    info.UserPhone = _UserInfoPhone;
    info.UserImage = _UserInfoImage;
    info.UserNickName = _UserInfoName;
    [self.navigationController pushViewController:info animated:YES];
}

-(void)TApImageView:(UITapGestureRecognizer *)ImageTap
{
    MyCompanyInfoVC *info = [[MyCompanyInfoVC alloc]init];
    info.UserAge = _UserInfoAge;
    info.UserSex = _UserInfoSex;
    info.UserIntro = _UserInfoIntro;
    info.UserPhone = _UserInfoPhone;
    info.UserImage = _UserInfoImage;
    info.UserNickName = _UserInfoName;
    [self.navigationController pushViewController:info animated:YES];
}
//订单 5
-(void)PersonInfoBTn:(UIButton *)OrderBtn
{
    MyOrderVC *order = [[MyOrderVC alloc]init];
    order.num = OrderBtn.tag;
    [self.navigationController pushViewController:order animated:YES];
}

-(void)createSEcondView
{
    for (int i = 0; i < 6; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame     = CGRectMake((i % 3)*kScreenWidth/3, kScreenHeight/2.5 +(i / 3)*(100) + 50 , kScreenWidth/3, 100);
        button.tag       = 100+i;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/3 - 40)/2, (button.frame.size.height - 40)/2-10, 40, 40)];
        imageView.image  = [UIImage imageNamed:PictureArr[i]];
        [button addSubview:imageView];
        UILabel * LineLabel       = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight/2.5 +(i / 3)*(100) + 50 , kScreenWidth, 0.5)];
        LineLabel.backgroundColor = kAppLineColor;
        UILabel * LineLabelT      = [[UILabel alloc]initWithFrame:CGRectMake((i % 3)*kScreenWidth/3, CGRectGetMinY(button.frame) , 0.5, 100)];
        LineLabelT.backgroundColor = kAppLineColor;
        [button addTarget:self action:@selector(BTnClck:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *DicLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/3 - 40)/2-15, CGRectGetMaxY(imageView.frame)+5, 70, 15)];
        DicLabel.font     = [UIFont systemFontOfSize:14];
        DicLabel.textAlignment = NSTextAlignmentCenter;
        DicLabel.text     = TitleARr[i];
        
        [self.view addSubview:LineLabel];
        [button    addSubview:DicLabel];
        [self.view addSubview:LineLabelT];
        [self.view addSubview:button];
    }
}

-(void)BTnClck:(UIButton *)Info
{
    if (Info.tag == 100) {
        MyOrderCar *car = [[MyOrderCar alloc]init];
        [self.navigationController pushViewController:car animated:YES];
    }else if(Info.tag == 101){
        //我的账户
        MyAccountVC *Account = [[MyAccountVC alloc]init];
        [self.navigationController pushViewController:Account animated:YES];
    }else if(Info.tag == 102){
        //我的网络视频
        MyVideos *video = [[MyVideos alloc]init];
        [self.navigationController pushViewController:video animated:YES];
    }else if(Info.tag == 103){
        //视频会员
        MyVideoVip *Vip = [[MyVideoVip alloc]init];
        [self.navigationController pushViewController:Vip animated:YES];
    }else if(Info.tag == 104){
        //我的积分
        MyPointVC *point = [[MyPointVC alloc]init];
        [self.navigationController pushViewController:point animated:YES];
    }else if(Info.tag == 105){
        //系统设置
        SystemSetingVC *erweima = [[SystemSetingVC alloc]init];
        [self.navigationController pushViewController:erweima animated:YES];
    }
}
@end
