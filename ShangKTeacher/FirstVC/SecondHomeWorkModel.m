//
//  SecondHomeWorkModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondHomeWorkModel.h"

@implementation SecondHomeWorkModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setWithDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"userPhotoHead"]) {
        [self setThirdUserPhotoHead:[dic objectForKey:@"userPhotoHead"]];
    }
    if ([[dic objectForKey:@"type"]integerValue]) {
        [self setThirdType:[[dic objectForKey:@"type"]integerValue]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setThirdCreateTime:[dic objectForKey:@"createTime"]];
    }
}

-(void)setWithContent:(NSDictionary *)dic
{
    if ([dic objectForKey:@"content"]) {
        [self setThirdContent:[dic objectForKey:@"content"]];
    }
}

-(void)setWithVoiceUrl:(NSDictionary *)dic
{
    if ([dic objectForKey:@"location"]) {
        [self setThirdUserVoiceUrl:[dic objectForKey:@"location"]];
    }
}

-(void)setWithName:(NSDictionary *)Dict
{
    if ([Dict[@"user"][@"nickName"] isKindOfClass:[NSNull class]]) {
        [self setThirdNickName:@"暂无名字"];
    }else{
        [self setThirdNickName:Dict[@"user"][@"nickName"]];
    }
    if ([Dict[@"user"][@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
        [self setThirdNickPic:@""];
    }else{
        [self setThirdNickPic:Dict[@"user"][@"userPhotoHead"]];
    }
}

-(void)setWithJiaNAme:(NSDictionary *)dic
{
    
    [self setThirdNickName:@"暂无名字"];
    
        [self setThirdNickPic:@""];
   
    
}
@end
