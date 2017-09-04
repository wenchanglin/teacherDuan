//
//  ThirdVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ThirdVC.h"
#import "MyOrderCar.h"
#import "VipALiPayVC.h"
#import "AppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WXApi.h"
#import "NSObject+PerformSelector.h"
#import <UMSocialCore/UMSocialCore.h>

@protocol JSObjcDelegate <JSExport>

//tianbai对象用的JavaScript方法，必须声明！！！
- (void)call;
- (void)getCall:(NSString *)callString;
@end

@interface ThirdVC ()<UIWebViewDelegate,JSObjcDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property (strong, nonatomic)  UIWebView *webView;

@end

@implementation ThirdVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.backgroundColor = kAppBlackColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"post" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(post) name:@"post" object:nil];
    [self createNav];
    self.view.backgroundColor = kAppWhiteColor;
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-44);
    _webView.delegate = self;
    [_webView sizeToFit];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"onlingshop" ofType:@"html" inDirectory:@"www/onlingshopping"]]]];
    [self.view addSubview:_webView];
}

-(void)Return
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cllaCk
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    __weak typeof(self) weakSelf = self;
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"tianbai"] = self;
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    _jsContext[@"show"] = ^(NSDictionary *param) {
        VipALiPayVC *pay = [[VipALiPayVC alloc]init];
        [weakSelf.navigationController pushViewController:pay animated:YES];
    };
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlstr = request.URL.absoluteString;
    
    NSRange range = [urlstr
                     rangeOfString:@"ios://"];
    
    if(range.length!=0)
    {
        
        NSString *method = [urlstr substringFromIndex:(range.location+range.length)];
        SEL selctor = NSSelectorFromString(method);
        [self performSelector:selctor withObject:nil];
    }
    
    NSString *scheme=@"hq://";NSLog(@"file:%@",urlstr);
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

-(void)Push:(NSString *)number
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":number} url:UrL_ALiPayOrder success:^(id responseObject) {
        //        NSLog(@"挤挤%@",responseObject);
        VipALiPayVC *pay = [[VipALiPayVC alloc]init];
        NSString *AliPayWeb = [responseObject objectForKey:@"msg"];
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


- (void)post
{
    //使用alert注意此处最好延迟执行,否则可能程序卡死,未测试非延迟情况下传值问题,延迟执行成功
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        FbwManager *Manager = [FbwManager shareManager];
        //        [self.webView stringByEvaluatingJavaScriptFromString:@"alert('hello')"];
        NSString *userid = Manager.UUserId;
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"post('%@');",userid]];
    });
    
}
- (void)call{
    // 之后在回调js的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"Callback"];
    FbwManager *Manager = [FbwManager shareManager];
    NSString *userid = Manager.UUserId;
    //传值给web端
    [Callback callWithArguments:@[userid]];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"商城";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setImage:[UIImage imageNamed:@"购物车-(1)@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(Btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)Btn2Click:(UIButton *)btn
{
    MyOrderCar *car = [[MyOrderCar alloc]init];
    [self.navigationController pushViewController:car animated:YES];
}

@end
