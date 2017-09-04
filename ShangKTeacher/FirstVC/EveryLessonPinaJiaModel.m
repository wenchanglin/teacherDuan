//
//  EveryLessonPinaJiaModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryLessonPinaJiaModel.h"

@implementation EveryLessonPinaJiaModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"content"]) {
        [self setLessonJContent:[dic objectForKey:@"content"]];
    }
    if ([dic objectForKey:@"score"]) {
        [self setLessonJScore:[dic objectForKey:@"score"]];
    }
    if ([dic objectForKey:@"nickname"]) {
        [self setLessonJNickName:[dic objectForKey:@"nickname"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setLessonJCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"userPhotoHead"]) {
        [self setLessonJUserPhotoHead:[dic objectForKey:@"userPhotoHead"]];
    }
}

@end
