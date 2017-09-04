//
//  VideoStoreModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "VideoStoreModel.h"

@implementation VideoStoreModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if (dic[@"userBase"][@"intro"]) {
        [self setVideoStoreIntro:dic[@"userBase"][@"intro"]];
    }
    if (dic[@"userBase"][@"nickName"]) {
        [self setVideoStoreName:dic[@"userBase"][@"nickName"]];
    }
    //    if (dic[@"userBase"][@"userPhotoHead"]) {
    //        [self setVideoStorePhoto:dic[@"userBase"][@"userPhotoHead"]];
    //    }
    if (dic[@"userBase"][@"userInfoStore"]) {
        [self setVideoStoreId:dic[@"userBase"][@"userInfoStore"]];
    }
    if (dic[@"userBase"][@"id"]) {
        [self setVideoStoreId:dic[@"userBase"][@"id"]];
    }
    if ([dic objectForKey:@"avgSroce"]) {
        [self setVideoStoreScore:[dic objectForKey:@"avgSroce"]];
    }
    if ([dic objectForKey:@"videoCourseCount"]) {
        [self setVideoStoreCourseCount:[dic objectForKey:@"videoCourseCount"]];
    }
}
@end
