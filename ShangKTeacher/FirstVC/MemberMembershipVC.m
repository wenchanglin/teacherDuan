//
//  MemberMembershipVC.m
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MemberMembershipVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "WXApi.h"
#import "NSString+StringHelper.h"
//#import "WXApiManager.h"
#import "DataSigner.h"
#import "VipALiPayVC.h"
@interface MemberMembershipVC ()
{
    UILabel *PriceLabel;
    NSString *_type;
    NSInteger PriceId;
    NSString *Price;
}
@property(nonatomic,strong)UILabel     * accountLabel;
@property(nonatomic,strong)UIButton    * resultBtn;
@property(nonatomic, strong)UIButton   * btnSelected;
@end

@implementation MemberMembershipVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self createPriceData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor = KAppBackBgColor;
}

-(void)createUI
{
    UIView *BarView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/3)];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3-50)];
    imageView.image   = [UIImage imageNamed:@"组-39@2x.png"];
    UILabel *TitLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, kScreenWidth, 30)];
    TitLabel.text     = @"说明:包月说明";
    TitLabel.font     = [UIFont systemFontOfSize:17];
    BarView.backgroundColor = kAppWhiteColor;
    UILabel *PriceLa = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, (kScreenHeight/3-50)/2-10, 40, 20)];
    PriceLa.text = [NSString stringWithFormat:@"%.2f",[Price doubleValue]];
    PriceLa.adjustsFontSizeToFitWidth = YES;
    PriceLa.textColor = kAppRedColor;
    PriceLa.textAlignment  = NSTextAlignmentCenter;
    PriceLa.font = [UIFont boldSystemFontOfSize:20];
    UILabel *TextLa = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(PriceLa.frame)+1, (kScreenHeight/3-50)/2-13, 50, 20)];
    TextLa.adjustsFontSizeToFitWidth = YES;
    TextLa.textAlignment  = NSTextAlignmentCenter;
    TextLa.font = [UIFont boldSystemFontOfSize:22];
    TextLa.text = @"元/每月";
    UILabel *BtnLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(BarView.frame)+20, 100, 20)];
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
        [button addTarget:self action:@selector(BtClose:) forControlEvents:UIControlEventTouchUpInside];
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
    [imageView addSubview:PriceLa];
    [BarView   addSubview:TitLabel];
    [BarView   addSubview:imageView];
    [BarView   addSubview:TextLa];
    [self.view addSubview:BarView];
    [self.view addSubview:BtnLabel];
}

-(void)BtClose:(UIButton *)btnSJ
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

-(void)createPriceData
{
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:nil url:UrL_PriceVip success:^(id responseObject) {
        NSLog(@"看看价格%@",responseObject);
        NSDictionary *RootD = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootD objectForKey:@"iData"];
        for (NSDictionary *Dict in Arr) {
            Price = [Dict objectForKey:@"price"];
        }
        [weakSelf createUI];
        [weakSelf CreateFootView];
    } failure:^(NSError *error) {
    }];
}

-(void)CreateFootView
{
    UIView *TitleFootView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 54)];
    TitleFootView.backgroundColor = kAppWhiteColor;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    imageView.image = [UIImage imageNamed:@"78@2x.png"];
    _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, 140, 30)];
    [TitleFootView addSubview:_accountLabel];
    _accountLabel.text = [NSString stringWithFormat:@"总额:%@",Price];
    _resultBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-100, 0, 100, 44)];
    [TitleFootView addSubview:_resultBtn];
    [_resultBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [_resultBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    _resultBtn.tag = 5;
    //PicZeroClick
    [_resultBtn addTarget:self action:@selector(alipay) forControlEvents:UIControlEventTouchUpInside];
    _resultBtn.backgroundColor = kAppRedColor;
    
    [TitleFootView addSubview:imageView];
    [TitleFootView addSubview:_accountLabel];
    [TitleFootView addSubview:_resultBtn];
    [self.view addSubview:TitleFootView];
}

//支付宝支付
-(void)alipay
{
    if([_type isEqualToString:@"alipay"])
    {
        __weak typeof(self) weakSelf = self;
        FbwManager *Manager = [FbwManager shareManager];
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:nil url:UrL_PriceVip success:^(id responseObject) {
            NSDictionary *RootD = [responseObject objectForKey:@"data"];
            NSArray *Arr = [RootD objectForKey:@"iData"];
            for (NSDictionary *Dict in Arr) {
                NSString * PricrId = [Dict objectForKey:@"id"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"vipPriceId":PricrId,@"fkUserId":Manager.UUserId} url:UrL_BuyVip success:^(id responseObject) {
                        NSDictionary *Ditc = [responseObject objectForKey:@"data"];
                        NSString *VipId = [Ditc objectForKey:@"id"];
                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":VipId} url:UrL_ALiPayOrder success:^(id responseObject) {
                            NSString *AliPayWeb = [responseObject objectForKey:@"msg"];
                            VipALiPayVC *Ali = [[VipALiPayVC alloc]init];
                            Ali.ChooseTitle = @"VipGet";
                            Ali.AliMSG = AliPayWeb;
                            [weakSelf.navigationController pushViewController:Ali animated:YES];
                        } failure:^(NSError *error) {
                        }];
                    } failure:^(NSError *error) {
                        NSLog(@"支付失败");
                    }];
                });
            }
        } failure:^(NSError *error) {
        }];
        
//        // 商户PID
//        NSString *partner = @"2088321042647089";
//        // 商户收款账号
//        NSString *seller = @"hyjkpay@1gene.com.cn";
//        // 商户私钥，pkcs8格式
//        NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAIOdoCVrr/bWnmPE aDYoPJSH7cfrtGBTMFQjeE2v73GlTEWPjJNs7T6aTPcmXNeIiyLmLzOL8AgArrn2 pjgpw04nIetW3ZaiczrRzK3E+zadfEDf4KighWgGeYVgLRfNYirDBnaqQMk3XcvD hYoF6hTZWg4q8ABNcvXTI4FLGWtVAgMBAAECgYBdbCp7xWee55KAMK7kGkV+DMo8 iVN8uC/q2U6QnlxxJ6rvCUj4cG4qbK5LFID8QKC6gfdpOGCF3a4otCoiXYqSTxEU untEqS5rtovxvW/fP3TPLZ3DFFIwt2F7np6dvRQ5sLqRvHWNS4r716XDXfxV/Bsf lEwaaxAOZ4/6uG1nVQJBAMC28NxyRb/9MdrEufKDjMcuZEnw1TjSJVyuKlS8eSdT vq12viH+ZWeFHYcq9U8ZVN0vKEWUBmCHV8qZlyKS2RMCQQCu1j8cMG0bkQuB8WHt Nvs80lRXqIMvfsyDco06JjAdUJfULs187qwSrMN2nhwWQf+8gFSPv7YFfqcfAYHR F173AkEAqVxcwq9eYwJl3OfErr8zahx4II8ZI61zDkc1hnB4XLp5OULAh2llvps6 vv5exVvyu8tkrfkPvadT3QYrz0OUpwJBAK2kSV+01Ng5EQXId6rCHXoFpxC8YzYL qBCw94SWItkqjvCEXz/CR5Hwldy8IUcV22kax2FRVPVWGaMYuxawMHcCQGir3STI 2uP/RIcShyA12ZfwzYRbJqtAVt3C991l8piDrf5n0lxtSP1TeFZ/L5zjDjCGEveN a5HJuj4re8xhyps=";    /*============================================================================*/
//        /*============================================================================*/
//        /*============================================================================*/
//        
//        //partner和seller获取失败,提示
//        if ([partner length] == 0 ||
//            [seller length] == 0 ||
//            [privateKey length] == 0)
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"缺少partner或者seller或者私钥。"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
//        
//        
//        //生成订单信息及签名
//        //将商品信息赋予AlixPayOrder的成员变量
//        
//        Order *order = [[Order alloc] init];
//        order.partner = partner;
//        order.sellerID = seller;
//        order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//        order.subject = @"我的"; //商品标题
//        order.body = @"测试"; //商品描述
//        order.totalFee = @"0.02"; //商品价格
//        order.notifyURL =  @"http://www.xxx.com"; //回调URL
//        order.service = @"mobile.securitypay.pay";
//        order.paymentType = @"1";
//        order.inputCharset = @"utf-8";
//        order.itBPay = @"30m";
//        order.showURL = @"m.alipay.com";
//        
//        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//        NSString *appScheme = @"fbwalipay";
//        
//        //将商品信息拼接成字符串
//        NSString *orderSpec = [order description];
//        //        NSLog(@"orderSpec = %@",orderSpec);
//        
//        id<DataSigner> signer = CreateRSADataSigner(privateKey);
//        NSString *signedString = [signer signString:orderSpec];
//        
//        //将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = nil;
//        if (signedString != nil) {
//            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
//            NSArray *array = [[UIApplication sharedApplication] windows];
//            UIWindow* win=[array objectAtIndex:0];
//            [win setHidden:NO];
//            //            NSLog(@"oederstring %@",orderString);
//            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                //                NSLog(@"reslut = %@",resultDic);
//            }];
//        }
    }
    else
    {
//        PayReq *request = [[PayReq alloc] init];
//        request.partnerId = @"10000100";
//        request.prepayId= @"1101000000140415649af9fc314aa427";
//        request.package = @"Sign=WXPay";
//        request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
//        request.timeStamp= @"1397527777";
//        request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
//        [WXApi sendReq:request];
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
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:nil url:UrL_PriceVip success:^(id responseObject) {
        NSDictionary *RootD = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootD objectForKey:@"iData"];
        for (NSDictionary *Dict in Arr) {
            NSString * PricrId = [Dict objectForKey:@"id"];
//            dispatch_async(dispatch_get_main_queue(), ^{
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"vipPriceId":PricrId,@"fkUserId":Manager.UUserId} url:UrL_BuyVip success:^(id responseObject) {
                    NSDictionary *Ditc = [responseObject objectForKey:@"data"];
                    NSString *VipId = [Ditc objectForKey:@"id"];
                    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":VipId,@"clientType":@"teacher"} url:UrL_WxinPay success:^(id responseObject) {
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
                } failure:^(NSError *error) {
                    NSLog(@"支付失败");
                }];
//            });
        }
    } failure:^(NSError *error) {
    }];
    return @"";
}

//    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":@"",@"clientType":@"teacher"} url:UrL_WxinPay success:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
//    NSString *urlString = [NSString stringWithFormat:@"%@",UrL_WxinPay];//@"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp = [dict objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req = [[PayReq alloc] init];
//                req.partnerId = [dict objectForKey:@"partnerid"];
//                req.prepayId = [dict objectForKey:@"prepayid"];
//                req.nonceStr = [dict objectForKey:@"noncestr"];
//                req.timeStamp = stamp.intValue;
//                req.package = [dict objectForKey:@"package"];
//                req.sign = [dict objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                return @"";
//            }else{
//                return [dict objectForKey:@"retmsg"];
//            }
//        }else{
//            return @"服务器返回错误，未获取到json对象";
//        }
//    }else{
//        return @"服务器返回错误";

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

-(void)PicZeroClick:(UIButton *)BTn
{
    NSLog(@"立即支付");
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"vipPriceId":@"20",@"fkUserId":Manager.UUserId} url:UrL_BuyVip success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSLog(@"支付成功");
    } failure:^(NSError *error) {
        NSLog(@"支付失败");
    }];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"会员包月";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
