//
//  HomeWorkListModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "HomeWorkListModel.h"

@implementation HomeWorkListModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"createTime"]) {
        [self setWorkListCreateTime:[dic objectForKey:@"createTime"]];
    }
    
    
    if ([dic objectForKey:@"id"]) {
        [self setWorkListId:[dic objectForKey:@"id"]];
    }
}

-(void)setWithDic:(NSDictionary *)Dict
{
    if ([Dict[@"user"][@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
        [self setWorkListPhotoList:@""];
    }else{
        [self setWorkListPhotoList:Dict[@"user"][@"userPhotoHead"]];
    }
    if ([Dict[@"user"][@"nickName"] isKindOfClass:[NSNull class]]) {
        [self setWorkListCentent:@"暂无名字"];
    }else{
        [self setWorkListCentent:Dict[@"user"][@"nickName"]];
    }
}

-(void)setWtithDict:(NSDictionary *)Dic
{
    if ([[Dic objectForKey: @"userPhotoHead"] isKindOfClass:[NSNull class]]) {
        [self setWorkListUserPhotoHead:@""];
    }else{
        [self setWorkListUserPhotoHead:[Dic objectForKey: @"userPhotoHead"]];
    }
    if ([[Dic objectForKey: @"nickName"] isKindOfClass:[NSNull class]]) {
        [self setWorkListNickName:@"暂无名字"];
    }else{
        [self setWorkListNickName:[Dic objectForKey: @"nickName"]];
    }
}

@end
