//
//  VideoClassModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "VideoClassModel.h"

@implementation VideoClassModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"name"]) {
        [self setVideoName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setVideoprice:[dic objectForKey:@"price"]];
    }
    if ([[dic objectForKey:@"avgScore"]doubleValue]) {
        [self setVideoAvgScore:[[dic objectForKey:@"avgScore"]doubleValue]];
    }
    if ([dic objectForKey:@"photoUrl"]) {
        [self setVideoPhotoUrl:[dic objectForKey:@"photoUrl"]];
    }
    if ([dic objectForKey:@"sellCount"]) {
        [self setVideoSellCount:[dic objectForKey:@"sellCount"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setVideoId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"videoUrl"]) {
        [self setVideoUrl:[dic objectForKey:@"videoUrl"]];
    }
}
@end
