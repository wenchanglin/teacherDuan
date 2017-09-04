//
//  AFHttpClient.m
//  ShangKTeacher
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AFHttpClient.h"
#import <SVProgressHUD.h>
@implementation AFHttpClient
+ (instancetype)shareInstance
{
    
    static AFHttpClient *singleton = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        singleton = [[AFHttpClient alloc] init];
        
    });
    
    return singleton;
    
}

-(void)startRequestMethod:(RequestMethod)method parameters:(id)parameters url:(NSString *)url success:(void (^)(id))success
{
    [self startRequestMethod:method parameters:parameters url:url success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}

-(void)startRequestMethod:(RequestMethod)method parameters:(id)parameters url:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //    AFNetworkReachabilityManager *managerRea = [AFNetworkReachabilityManager sharedManager];
    //
    //    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    //    [managerRea startMonitoring];
    //
    //    [managerRea setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //        JYLog(@"网络:%ld", (long)status);
    //        if (status) {
    //1、初始化：
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2、设置请求超时时间：
    
    manager.requestSerializer.timeoutInterval = 30.0f;
    
    //2、设置允许接收返回数据类型：
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer  serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    
    __weak __typeof(self)weakSelf = self;
    
    NSDictionary *paramDic = parameters;
    
    if (method == POST) {
        [manager POST:url parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(dict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
                [weakSelf requestFailed:error];
            }else{
                [weakSelf requestFailed:error];
            }
        }];
    }else if (method == GET){
        [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
                [weakSelf requestFailed:error];
            }else{
                [weakSelf requestFailed:error];
            }
        }];
    }
    //        }else{
    //            [SVProgressHUD showErrorWithStatus:@"未检测到网络,请检查网络!"];
    //        }
    //    }];
    
}

- (void)requestFailed:(NSError *)error

{
    
    NSLog(@"--------------\n%ld %@",(long)error.code, error.debugDescription);
    
    switch (error.code) {
            
        case AFNetworkErrorType_NoNetwork :
        {
            NSLog(@"网络链接失败，请检查网络。");
            [SVProgressHUD showErrorWithStatus:@"网络链接失败，请检查网络。"];
            break;
        }
        case AFNetworkErrorType_TimedOut :
        {
            NSLog(@"访问服务器超时，请检查网络。");
            [SVProgressHUD showErrorWithStatus:@"访问服务器超时，请检查网络。"];
            
            break;
        }
            
        case AFNetworkErrorType_3840Faild :
        {
            NSLog(@"服务器报错了，请稍后再访问。");
            [SVProgressHUD showErrorWithStatus:@"服务器报错了，请稍后再访问。"];
            break;
        }
        default:
            [SVProgressHUD showErrorWithStatus:@"加载失败,请稍后再试。"];
            break;
            
    }
    
}

@end
