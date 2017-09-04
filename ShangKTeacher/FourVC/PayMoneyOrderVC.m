//
//  PayMoneyOrderVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "PayMoneyOrderVC.h"
#import "VipALiPayVC.h"
#import "WXApi.h"
@interface PayMoneyOrderVC ()
{
    NSString *_type;
}
@property(nonatomic,strong)UILabel     * accountLabel;
@property(nonatomic,strong)UIButton    * resultBtn;
@property(nonatomic,strong)UIButton    * btnSelected;
@end

@implementation PayMoneyOrderVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor = KAppBackBgColor;
    [self createHeadView];
    [self CreateFootView];
}

-(void)createHeadView
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/4)];
    HeadView.backgroundColor = kAppWhiteColor;
    UILabel *LabelNum = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, 20, 100, 20)];
    LabelNum.textAlignment = NSTextAlignmentCenter;
    LabelNum.text = @"付款金额";
    LabelNum.font = [UIFont boldSystemFontOfSize:15];
    UILabel *PriceLAbel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/2.5)/2, CGRectGetMaxY(LabelNum.frame)+10, kScreenWidth/2.5, 40)];
    PriceLAbel.text = [NSString stringWithFormat:@"¥ %.2f",self.SumPrice];
    PriceLAbel.font = [UIFont boldSystemFontOfSize:30];
    PriceLAbel.textAlignment = NSTextAlignmentCenter;
    UILabel *BtnLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(HeadView.frame)+20, 100, 20)];
    BtnLabel.text = @"支付方式:";
    BtnLabel.font = [UIFont boldSystemFontOfSize:15];
    NSArray *arr    = @[@"对号-拷贝9@2x.png",@"对号-拷贝9@2x.png"];
    NSArray *arrPic = @[@"对号9@2x.png",@"对号9@2x.png"];//
    NSArray *Title  = @[@"支付宝支付",@"微信支付"];
    NSArray *PicArr = @[@"图层-588@2x_19.png",@"图层-599@2x_76.png"];
    for (int i=0; i<2; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*(kScreenWidth-20-30)/2+i*30, CGRectGetMaxY(BtnLabel.frame)+10, (kScreenWidth-20-30)/2, 80);
        button.tag  = 10+i;
        [button setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:arrPic[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(BtPayClose:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
        imageView.image = [UIImage imageNamed:PicArr[i]];
        UILabel *ZFLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+8, 35, 70, 10)];
        ZFLabel.text     = Title[i];
        ZFLabel.font     = [UIFont boldSystemFontOfSize:14];
        if (button.tag   == 10) {
            button.selected  = YES;
            self.btnSelected = button;
            _type = @"alipay";
        }
        [button addSubview:ZFLabel];
        [button addSubview:imageView];
        [self.view addSubview:button];
    }
    
    
    [self.view addSubview:BtnLabel];
    [HeadView addSubview:PriceLAbel];
    [HeadView addSubview:LabelNum];
    [self.view addSubview:HeadView];
}

-(void)BtPayClose:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 10) {
        btnSJ.selected = YES;
        _type = @"alipay";
    }else
    {
        btnSJ.selected = YES;
        _type = @"WeiXinPay";
    }
    self.btnSelected = btnSJ;
}


-(void)CreateFootView
{
    _resultBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
    [_resultBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [_resultBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    _resultBtn.tag = 5;
    //PayClick:
    [_resultBtn addTarget:self action:@selector(payChoose) forControlEvents:UIControlEventTouchUpInside];
    _resultBtn.backgroundColor = kAppRedColor;
    
    [self.view addSubview:_resultBtn];
}

-(void)payChoose
{
    __weak typeof(self) weakSelf = self;
    if([_type isEqualToString:@"alipay"]){
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":self.OrderId} url:UrL_ALiPayOrder success:^(id responseObject) {
            NSString *AliPayWeb = [responseObject objectForKey:@"msg"];
            VipALiPayVC *Ali = [[VipALiPayVC alloc]init];
            Ali.AliMSG = AliPayWeb;
            Ali.ChooseTitle = self.PayMoneyChoose;
            [weakSelf.navigationController pushViewController:Ali animated:YES];
        } failure:^(NSError *error) {
        }];
    }else{
        NSLog(@"WX");
        NSString *weixinBackStr = [self jumpToBizPay];
        NSLog(@"你妹啊%@",weixinBackStr);
        if (![weixinBackStr isEqualToString:@""]) {
            NSLog(@"微信支付返回的信息 %@",weixinBackStr);
        }
    }
}

-(NSString *)jumpToBizPay
{
    if (![WXApi isWXAppInstalled]) {
        [SVProgressHUD showErrorWithStatus:@"没有安装微信"];
        return nil;
    }else if (![WXApi isWXAppSupportApi]){
        NSLog(@"不支持微信支付");
        return nil;
    }
    NSLog(@"安装了微信，而且支持微信支付");
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":self.OrderId,@"clientType":@"teacher"} url:UrL_WxinPay success:^(id responseObject) {
        NSLog(@"看看返回什么%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        if (RootDic != nil) {
            [WXApi registerApp:@"wx811f5b20d31544f4" withDescription:@"ShangKeTeacher"];
            PayReq* req = [[PayReq alloc] init];
            req.openID    = [RootDic objectForKey:@"appId"];
            req.partnerId = [RootDic objectForKey:@"partnerId"];
            req.prepayId  = [RootDic objectForKey:@"prepayId"];
            req.nonceStr  = [RootDic objectForKey:@"nonceStr"];
            req.timeStamp = [[RootDic objectForKey:@"timeStamp"]intValue];//(UInt32)[RootDic objectForKey:@"timeStamp"];
            req.package   = @"Sign=WXPay";
            req.sign      = [RootDic objectForKey:@"sign"];
            [WXApi sendReq:req];
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        }
    } failure:^(NSError *error) {
    }];
    return @"";
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text      = @"支付";
    label.textAlignment = NSTextAlignmentCenter;
    label.font      = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaKclick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}

-(void)BaKclick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
