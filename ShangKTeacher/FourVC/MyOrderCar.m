//
//  MyOrderCar.m
//  ShangKTeacher
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyOrderCar.h"
#import "AppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WXApi.h"
#import "PayMoneyOrderVC.h"
#import "VipALiPayVC.h"
#import <UMSocialCore/UMSocialCore.h>
@protocol JSObjcDelegate <JSExport>
- (void)call;
- (void)getCall:(NSString *)callString;
@end
@interface MyOrderCar ()<UIWebViewDelegate,JSObjcDelegate>
@property (nonatomic, strong) JSContext *jsContext;
@property (strong, nonatomic)  UIWebView *webView;

@end

@implementation MyOrderCar

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self createNav];
    [self createUI];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createUI
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+44)];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"shopcar" ofType:@"html" inDirectory:@"www/onlingshopping"]]]];
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"tianbai"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlstr = request.URL.absoluteString;
    
    NSRange range = [urlstr
                     rangeOfString:@"ios://"];
    if(range.length!=0)
    {
        NSString *method = [urlstr
                            substringFromIndex:(range.location+range.length)];
        SEL selctor = NSSelectorFromString(method);
        [self performSelector:selctor withObject:nil];
        
    }
    NSString *scheme=@"hq://";
    
    //如果是我们自定义的协议hq://call
    if ([urlstr hasPrefix:scheme]) {
        
        //取出scheme后边的路径
        NSString *path=[urlstr substringFromIndex:scheme.length];
        
        //根据?区分出方法名  参数
        NSArray *array=[path componentsSeparatedByString:@"?"];
        
        NSLog(@"%@",array);
        
        NSString *methodName=array.firstObject;
        [self Push:methodName];
        return NO;
    }
    NSString *schemetwo=@"hp://";
    
    //如果是我们自定义的协议hq://call
    if ([urlstr hasPrefix:schemetwo]) {
        
        //取出scheme后边的路径
        NSString *pathtwo=[urlstr substringFromIndex:schemetwo.length];
        
        //根据?区分出方法名  参数
        NSArray *arraytwo=[pathtwo componentsSeparatedByString:@"?"];
        
        NSLog(@"weixin%@",arraytwo);
        NSString *weixinname=arraytwo.firstObject;
        [self PushWEIXIN:weixinname];
        return NO;
    }
    NSString *schemethree = @"aa://";
    if ([urlstr hasPrefix:schemethree])
    {
        NSString *path=[urlstr substringFromIndex:schemethree.length];
        
        //根据?区分出方法名  参数
        NSArray *array=[path componentsSeparatedByString:@"?"];
        
        NSLog(@"%@",array);
        NSString *methodName=array.firstObject;
        NSLog(@"微信好友分享");
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject *web = [[UMShareWebpageObject alloc]init];
        //    web.webpageUrl = @"http://www.skbpt.com/share/share.html";
        web.webpageUrl = [NSString stringWithFormat:@"http://www.skbpt.com/share/share.html?type=3&shopid=%@&d=2",methodName];//1
        web.thumbImage = [UIImage imageNamed:@"使用帮助hyh.png"];
        web.descr = @"我已经用上课呗APP教育平台啦！全国数百万培训机构等你来挑选！课程覆盖少儿、成人、艺术......";
        messageObject.text = @"测试";
        messageObject.shareObject = web;
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            NSString *message = nil;
            if (!error) {
                message = [NSString stringWithFormat:@"分享成功"];
                
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }];
        [UMShareWebpageObject shareObjectWithTitle:@"测试" descr:@"234" thumImage:nil];
        
        return NO;
    }
    NSString *schemefour = @"bb://";
    if ([urlstr hasPrefix:schemefour])
    {
        NSString *path=[urlstr substringFromIndex:schemefour.length];
        
        //根据?区分出方法名  参数
        NSArray *array=[path componentsSeparatedByString:@"?"];
        
        NSLog(@"%@",array);
        NSString *methodName=array.firstObject;
        NSLog(@"微信好友分享");
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject *web = [[UMShareWebpageObject alloc]init];
        web.webpageUrl = [NSString stringWithFormat:@"http://www.skbpt.com/share/share.html?type=3&shopid=%@&d=2",methodName];//1
        web.thumbImage = [UIImage imageNamed:@"使用帮助hyh.png"];
        web.descr = @"我已经用上课呗APP教育平台啦！全国数百万培训机构等你来挑选！课程覆盖少儿、成人、艺术......";
        messageObject.text = @"测试";
        messageObject.shareObject = web;
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            NSString *message = nil;
            if (!error) {
                message = [NSString stringWithFormat:@"分享成功"];
                
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }];
        [UMShareWebpageObject shareObjectWithTitle:@"测试" descr:@"234" thumImage:nil];
        
        
        return NO;
    }
    NSString *schemefive = @"cc://";
    if([urlstr hasPrefix:schemefive])
    {
        NSString *path=[urlstr substringFromIndex:schemefive.length];
        
        //根据?区分出方法名  参数
        NSArray *array=[path componentsSeparatedByString:@"?"];
        
        NSLog(@"%@",array);
        NSString *methodName=array.firstObject;
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject *web = [UMShareWebpageObject shareObjectWithTitle:@"上课呗" descr:@"qweas" thumImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x_47"] ];
        web.webpageUrl = [NSString stringWithFormat:@"http://www.skbpt.com/share/share.html?type=3&shopid=%@&d=2",methodName];//1
        web.thumbImage = [UIImage imageNamed:@"使用帮助hyh.png"];
        web.descr = @"我已经用上课呗APP教育平台啦！全国数百万培训机构等你来挑选！课程覆盖少儿、成人、艺术......";
        messageObject.text = @"测试";
        messageObject.shareObject = web;
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            NSString *message = nil;
            if (!error) {
                message = [NSString stringWithFormat:@"分享成功"];
                
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                NSLog(@"sadsdas%@",error);
                
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }];
        [UMShareWebpageObject shareObjectWithTitle:@"测试" descr:@"234" thumImage:nil];
        
        return NO;
    }
    return YES;

}

-(void)Return
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selctor
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Push:(NSString *)number
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":number} url:UrL_ALiPayOrder success:^(id responseObject) {
        NSLog(@"挤挤%@",responseObject);
        VipALiPayVC *pay = [[VipALiPayVC alloc]init];
        NSString *AliPayWeb = [responseObject objectForKey:@"msg"];
//        pay.web = responseObject[@"msg"];
        pay.AliMSG = AliPayWeb;
        pay.ChooseTitle = @"SpBuy";
        [self.navigationController pushViewController:pay animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)PushWEIXIN:(NSString *)number
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":number,@"clientType":@"teacher"} url:UrL_WxinPay success:^(id responseObject) {
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = responseObject[@"data"][@"partnerId"];
        request.prepayId=  responseObject[@"data"][@"prepayId"];
        request.package =  responseObject[@"data"][@"package"];
        request.nonceStr= responseObject[@"data"][@"nonceStr"];
        request.timeStamp= [responseObject[@"data"][@"timeStamp"] intValue];
        request.sign=responseObject[@"data"][@"sign"];
        [WXApi sendReq:request];
    } failure:^(NSError *error) {
        
    }];
}

- (void)call{
    JSValue *Callback = self.jsContext[@"Callback"];
    FbwManager *Manager = [FbwManager shareManager];
    NSString *userid = Manager.UUserId;
    //传值给web端
    [Callback callWithArguments:@[userid]];
}


//- (void)getCall:(NSString *)callString{
//    NSLog(@"Get:%@", callString);
//    // 成功回调js的方法Callback
//    JSValue *Callback = self.jsContext[@"alerCallback"];
//    [Callback callWithArguments:nil];
//
//    //    直接添加提示框
//    //    NSString *str = @"alert('OC添加JS提示成功')";
//    //    [self.jsContext evaluateScript:str];
//    
//}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 45)/2, 10, 70, 30)];
    label.text = @"购物车";
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

-(void)BaCklick:(UIButton *)Tb1
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Btn2Click:(UIButton *)btn
{
    NSLog(@"买买买");
    
}

@end
