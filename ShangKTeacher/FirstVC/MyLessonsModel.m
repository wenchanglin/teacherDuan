//
//  MyLessonsModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyLessonsModel.h"

@implementation MyLessonsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"id"]) {
        [self setMyLessonId:[dic objectForKey:@"id"]];
//        NSLog(@"%@",[dic objectForKey:@"id"]);
    }
    if ([dic objectForKey:@"avgScore"]) {
        [self setMyLessonAvgScore:[dic objectForKey:@"avgScore"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setMyLessonPrice:[dic objectForKey:@"price"]];
//        NSLog(@"%@",[dic objectForKey:@"price"]);
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setMyLessonCreateTime:[dic objectForKey:@"createTime"]];
//        NSLog(@"%@",[dic objectForKey:@"createTime"]);
    }
    
    if ([dic objectForKey:@"submitCount"]) {
        [self setMyLessonSubmitCount:[dic objectForKey:@"submitCount"]];
    }
    if ([dic objectForKey:@"buyCount"]) {
        [self setMyLessonBuyCount:[dic objectForKey:@"buyCount"]];
    }
    if ([dic objectForKey:@"name"]) {
        [self setMyLessonName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"fitPeople"]) {
        [self setMyLessonFitPeople:[dic objectForKey:@"fitPeople"]];
    }
    if ([dic objectForKey:@"briefIntro"]) {
        [self setMyLessonBriefIntro:[dic objectForKey:@"briefIntro"]];
        
    }
}

-(void)setDict:(NSDictionary *)Dict
{
    if ([Dict objectForKey:@"location"]) {
        [self setMyLessonPhotoList:[Dict objectForKey:@"location"]];
    }
}
@end
