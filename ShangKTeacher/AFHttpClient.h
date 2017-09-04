//
//  AFHttpClient.h
//  ShangKTeacher
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <UIKit+AFNetworking.h>

typedef NS_ENUM(NSUInteger,RequestMethod) {
    POST = 0,
    GET,
    PUT,
    PATCH,
    DELETE
};

typedef NS_ENUM(NSInteger, AFNetworkErrorType) {
    AFNetworkErrorType_TimedOut = NSURLErrorTimedOut,
    AFNetworkErrorType_UnURL = NSURLErrorUnsupportedURL,
    AFNetworkErrorType_NoNetwork = NSURLErrorNotConnectedToInternet,
    AFNetworkErrorType_404Failed = NSURLErrorBadServerResponse,
    AFNetworkErrorType_3840Faild = 3840,
};

@interface AFHttpClient : NSObject
+ (instancetype)shareInstance;

- (void)startRequestMethod:(RequestMethod)method

                parameters:(id)parameters

                       url:(NSString *)url

                   success:(void (^)(id responseObject))success;

- (void)startRequestMethod:(RequestMethod)method

                parameters:(id)parameters

                       url:(NSString *)url

                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;



@end
