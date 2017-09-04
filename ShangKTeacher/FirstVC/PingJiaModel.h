//
//  PingJiaModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PingJiaModel : NSObject
@property(nonatomic,copy) NSString *PingJContent;
@property(nonatomic,copy) NSString *PingJScore;
@property(nonatomic,copy) NSString *PingJUserPhotoHead;
@property(nonatomic,copy) NSString *PingJNickName;
@property(nonatomic,copy) NSString *PingJCreateTime;

-(void)setDic:(NSDictionary *)dic;
@end
