//
//  FriendsNoticeModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendsNoticeModel.h"

@implementation FriendsNoticeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"messageContent"]) {
        [self setFriendsMessageContent:[dic objectForKey:@"messageContent"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setFriendsMessageId:[dic objectForKey:@"id"]];
    }
    if ([[dic objectForKey:@"status"]integerValue]) {
        [self setFriendsMessageStatus:[[dic objectForKey:@"status"]integerValue]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setFriendsMessageCreateTime:[dic objectForKey:@"createTime"]];
    }
}
@end
