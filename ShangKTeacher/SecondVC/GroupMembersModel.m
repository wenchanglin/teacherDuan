//
//  GroupMembersModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "GroupMembersModel.h"

@implementation GroupMembersModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"id"])       {
        [self setGroupMembersId:[dic objectForKey:@"id"]];
        //        NSLog(@"爆炸%@",[dic objectForKey:@"id"]);
    }
    if ([dic[@"userInfoBase"][@"nickName"] isKindOfClass:[NSNull class]])       {
        [self setGroupMembersName:@"暂无姓名"];
    }else{
       [self setGroupMembersName:dic[@"userInfoBase"][@"nickName"]];
    }
    if ([dic[@"userInfoBase"][@"sex"]isKindOfClass:[NSNull class]])       {
        //        NSLog(@"爆炸%@",[dic objectForKey:@"Sex"]);
    }else{
        [self setGroupMembersSex:[dic[@"userInfoBase"][@"sex"]integerValue]];
    }
    if (dic[@"userInfoBase"][@"intro"])       {
        [self setGroupMembersIntro:dic[@"userInfoBase"][@"intro"]];
    }
    if (dic[@"userInfoBase"][@"userPhotoHead"])       {
        [self setGroupMembersUserPhotoHead:dic[@"userInfoBase"][@"userPhotoHead"]];
    }
//        if ([dic[@"userInfoBase"][@"isFriend"]integerValue])       {
//            [self setIsFriend:[dic[@"userInfoBase"][@"isFriend"]integerValue]];
//             NSLog(@"爆炸%ld",[dic[@"userInfoBase"][@"isFriend"]integerValue]);
//        }
    if ([dic objectForKey:@"fkUserId"])       {
        [self setGroupMembersFkId:[dic objectForKey:@"fkUserId"]];
        NSLog(@"你瞧%@",[dic objectForKey:@"fkUserId"]);
    }
}
@end
