//
//  AppDelegate.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AppDelegate.h"
#import "RootVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginVC.h"
#import "WXApi.h"
#import "JPUSHService.h"
#import <RongIMKit/RongIMKit.h>
#import <UMSocialCore/UMSocialCore.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource>
{
    NSString *_UserInfoImage;
    NSString *_UserInfoNickName;
    NSString *GroupPic;
    NSString *GroupNickName;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [WXApi registerApp:@"wx811f5b20d31544f4" withDescription:@"ShangKeTeacher"];
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"584a6774aed1793d65001638"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx811f5b20d31544f4" appSecret:@"c85dc70e56c68d8d4845dd3f61fcfaca" redirectURL:@"http://mobile.umeng.com/social"];
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1592760599"  appSecret:@"76778a91f0749a6fb2c7cd83a397c829" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"Launch"] || ![[defaults objectForKey:@"isLogin"]isEqualToString:@"YES"]) {
        LoginVC *yinDao = [[LoginVC alloc]init];
        [self setAPNS:launchOptions];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:yinDao];
        navi.navigationBar.backgroundColor = kAppRedColor;
        [self.window setRootViewController:navi];
        [defaults setBool:YES forKey:@"Launch"];
    }else{
        [[RCIM sharedRCIM] initWithAppKey:@"ik1qhw091hubp"];//n19jmcy5nirn9
        [self setAPNS:launchOptions];
        [self getRongyunToken];
        RootVC *mva = [[RootVC alloc]init];
        [self.window setRootViewController:mva];
        
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    FbwManager *Manager =[FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId} url:UrL_SearchTeacher success:^(id responseObject) {
        NSLog(@"教师信息%@",responseObject);
        NSDictionary *rootTDic = [responseObject objectForKey:@"data"];
        NSDictionary *diTct = [rootTDic objectForKey:@"userInfoBase"];
        if ([[diTct objectForKey:@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
            
        }else{
            _UserInfoImage = [diTct objectForKey:@"userPhotoHead"];
        }
        if ([[diTct objectForKey:@"nickName"] isKindOfClass:[NSNull class]]) {
            
        }else{
            _UserInfoNickName = [diTct objectForKey:@"nickName"];
        }
        if ([userId isEqualToString:Manager.UUserId]) {
            return completion([[RCUserInfo alloc] initWithUserId:userId name:_UserInfoNickName portrait:[NSString stringWithFormat:@"%@%@",BASEURL,_UserInfoImage]]);
        }else
        {
//            return completion([[RCUserInfo alloc] initWithUserId:userId name:@"name" portrait:@"http://pic32.nipic.com/20130827/12906030_123121414000_2.png"]);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion
{
    FbwManager *Manager =[FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId} url:UrL_SearchTeacher success:^(id responseObject) {
        NSDictionary *rootTDic = [responseObject objectForKey:@"data"];
        if ([rootTDic[@"userBase"][@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
            
        }else{
            GroupPic = rootTDic[@"userBase"][@"userPhotoHead"];
        }
        if ([rootTDic[@"userBase"][@"nickName"] isKindOfClass:[NSNull class]]) {
            
        }else{
            GroupNickName = rootTDic[@"userBase"][@"nickName"];
        }
        
        if ([groupId isEqualToString:Manager.UUserId]) {
            return completion([[RCGroup alloc]initWithGroupId:groupId groupName:GroupNickName portraitUri:[NSString stringWithFormat:@"%@%@",BASEURL,GroupPic]]);
        }else
        {
            return completion([[RCGroup alloc]initWithGroupId:groupId groupName:@"name" portraitUri:@"http://pic32.nipic.com/20130827/12906030_123121414000_2.png"]);
        }
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)setAPNS:(NSDictionary *) launchOptions {

//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//#endif
//    }
//    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    }
//    else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
//    
//    //Required
//    // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
//    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
//    //advertisingId
//    [JPUSHService setupWithOption:launchOptions appKey:@"0c2987a286c12fdbafccf143"
//                          channel:@"App Store"
//                 apsForProduction:YES
//            advertisingIdentifier:nil];
//    
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
//        if(resCode == 0){
//            NSLog(@"registrationID获取成功：%@",registrationID);
//        }
//        else{
//            NSLog(@"registrationID获取失败，code：%d",resCode);
//        }
//    }];
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"0c2987a286c12fdbafccf143"
                          channel:@"App store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
}

-(void)getRongyunToken
{
    FbwManager *Manager =[FbwManager shareManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@..%@.",[defaults objectForKey:@"UserID"],[defaults objectForKey:@"UserNickName"]);
    Manager.UUserId = [defaults objectForKey:@"UserID"];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":[defaults objectForKey:@"UserID"],@"name":[defaults objectForKey:@"UserNickName"],@"portraitUri":@""} url:UrL_GetRongYunToken success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSString *token = responseObject[@"data"][@"token"];
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            [[RCIM sharedRCIM] setGroupInfoDataSource:self];
            NSLog(@"Login successfully with userId: %@.", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"login error status: %ld.", (long)status);
        } tokenIncorrect:^{
            NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
        }];
         } failure:^(NSError *error) {
        }];
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
          }];
       }
       return YES;
      }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)applocation:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //微信 阿里pay
   return [WXApi handleOpenURL:url delegate:self];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
          }];
        }
      return YES;
     }
    return result;
}

#pragma mark - Handle WeChat Response
- (void)onResp:(BaseResp *)resp
{
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                strMsg = @"支付结果:";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"success";
                break;
            }
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"cancel";
                break;
            }
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"faile";
                break;
            }
        }
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        NSNotification * notification = [NSNotification notificationWithName:@"WXPay" object:wxPayResult];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

/**
 *极光推送
 */
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//        FbwManager *Manager = [FbwManager shareManager];
//        [JPUSHService registerDeviceToken:deviceToken];
//        [JPUSHService setTags:nil alias:Manager.UUserId callbackSelector:nil object:nil];
//    NSLog(@"唧唧%@",Manager.UUserId);
//    FbwManager *Manager = [FbwManager shareManager];
//    /// Required - 注册 DeviceToken
//    NSLog(@"%@",Manager.UUserId);
//    [JPUSHService registerDeviceToken:deviceToken];
//    [JPUSHService setTags:nil alias:@"14809183960459272" callbackSelector:nil object:nil];
//    [[YSFSDK sharedSDK] updateApnsToken:deviceToken];
          //NSLog(@"设备的devivceToken  %@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]  stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""]);
//}
//实现注册apns失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
//添加处理apns通知回调方法

#pragma mark- JPUSHRegisterDelegate
#pragma mark----------极光推送回调
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    FbwManager *Manager = [FbwManager shareManager];
    [JPUSHService setTags:nil alias:Manager.UUserId callbackSelector:nil object:nil];
    [JPUSHService registerDeviceToken:deviceToken];
}
//pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

// Required, iOS 7 Support

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
////    [JPUSHService handleRemoteNotification:userInfo];
////    completionHandler(UIBackgroundFetchResultNewData);
//    DLog(@"2-1 didReceiveRemoteNotification remoteNotification = %@", userInfo);
//    
//    // apn 内容获取：
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//    
//    DLog(@"2-2 didReceiveRemoteNotification remoteNotification = %@", userInfo);
//    if ([userInfo isKindOfClass:[NSDictionary class]])
//    {
//        NSDictionary *dict = userInfo[@"aps"];
//        NSString *content = dict[@"alert"];
//        DLog(@"content = %@", content);
//    }
//    
//    if (application.applicationState == UIApplicationStateActive)
//    {
//        // 程序当前正处于前台
//    }
//    else if (application.applicationState == UIApplicationStateInactive)
//    {
//        // 程序处于后台
//    }
//}
//
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//// 当程序在前台时, 收到推送弹出的通知
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
//{
//    NSDictionary *userInfo = notification.request.content.userInfo;
//    
//    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
//    {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    
//    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//     completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//}
//
//// 程序关闭后, 通过点击推送弹出的通知
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
//{
//    NSDictionary *userInfo = response.notification.request.content.userInfo;
//    
//    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
//    {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    
//    completionHandler();  // 系统要求执行这个方法
//}
//#endif
//
///// 绑定别名（注意：1 登录成功或者自动登录后；2 去除绑定-退出登录后）
//+ (void)JPushTagsAndAliasInbackgroundTags:(NSSet *)set alias:(NSString *)name
//{
//    // 标签分组（表示没有值）
//    NSSet *tags = set;
//    // 用户别名（自定义值，nil是表示没有值）
//    NSString *alias = name;
////    NSLog(@"tags = %@, alias = %@(registrationID = %@)", tags, alias, [self registrationID]);
//    
//    // tags、alias均无值时表示去除绑定
//    [JPUSHService setTags:tags aliasInbackground:alias];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    NSLog(@"%@",userInfo);
//    [JPUSHService handleRemoteNotification:userInfo];
//    
//}

//- (void)registerRemoteNotification
//{
//    
//#ifdef __IPHONE_8_0
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        
//        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
//    } else {
//        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
//    }
//#else
//    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
//#endif
//    
//}
////已经进入后台
//-(void)applicationDidEnterBackground:(UIApplication *)application
//{
//    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
//    NSInteger count = [[[YSFSDK sharedSDK] conversationManager] allUnreadCount];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
//    
//    // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
