//
//  FreeBengModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FreeBengModel.h"

@implementation FreeBengModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"name"]) {
        [self setFreeCourseName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setFreeCourseprice:[dic objectForKey:@"price"]];
    }
    if ([[dic objectForKey:@"avgScore"]doubleValue]) {
        [self setFreeCourseAvgScore:[[dic objectForKey:@"avgScore"]doubleValue]];
    }
    if ([dic objectForKey:@"photoUrl"]) {
        [self setFreeCoursePhotoUrl:[dic objectForKey:@"photoUrl"]];
    }
    if ([dic objectForKey:@"sellCount"]) {
        [self setFreeCourseSellCount:[dic objectForKey:@"sellCount"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setFreeCourseId:[dic objectForKey:@"id"]];
    }
}

@end
