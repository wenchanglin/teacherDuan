//
//  PingJiaModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "PingJiaModel.h"

@implementation PingJiaModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"content"]) {
        [self setPingJContent:[dic objectForKey:@"content"]];
    }
    if ([dic objectForKey:@"score"]) {
        [self setPingJScore:[dic objectForKey:@"score"]];
    }
    if ([dic objectForKey:@"nickName"]) {
        [self setPingJNickName:[dic objectForKey:@"nickName"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setPingJCreateTime:[dic objectForKey:@"createTime"]];
        NSLog(@"%@",[dic objectForKey:@"createTime"]);
    }
    if ([dic objectForKey:@"userPhotoHead"]) {
        [self setPingJUserPhotoHead:[dic objectForKey:@"userPhotoHead"]];
    }
}
@end
