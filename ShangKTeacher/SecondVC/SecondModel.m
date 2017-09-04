//
//  SecondModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondModel.h"

@implementation SecondModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"chatGroupPhotoUrl"]) {
        [self setSecondChatGroupPhotoUrl:[dic objectForKey:@"chatGroupPhotoUrl"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setSecondCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"createUserId"]) {
        [self setSecondCreateUserId:[dic objectForKey:@"createUserId"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setSecondId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"intro"]) {
        [self setSecondIntro:[dic objectForKey:@"intro"]];
    }
    if ([dic objectForKey:@"name"]) {
        [self setSecondName:[dic objectForKey:@"name"]];
    }
}
@end
