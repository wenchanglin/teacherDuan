//
//  EveryVideoModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryVideoModel.h"

@implementation EveryVideoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"intro"]) {
        [self setEveryVideoIntro:[dic objectForKey:@"intro"]];
    }
    if ([dic objectForKey:@"fitPeople"]) {
        [self setEveryVideoFitPeople:[dic objectForKey:@"fitPeople"]];
    }
    if ([dic objectForKey:@"orgName"]) {
        [self setEveryVideoOrgName:[dic objectForKey:@"orgName"]];
    }
    if ([dic objectForKey:@"orgIntro"]) {
        [self setEveryVideoOrgIntro:[dic objectForKey:@"orgIntro"]];
    }
    if ([dic objectForKey:@"teacherName"]) {
        [self setEveryVideoTeacherName:[dic objectForKey:@"teacherName"]];
    }
    if ([dic objectForKey:@"teacherIntro"]) {
        [self setEveryVideoTeacherIntro:[dic objectForKey:@"teacherIntro"]];
    }
    if ([dic objectForKey:@"isBuy"]) {
        [self setEveryVideoIsBuy:[[dic objectForKey:@"isBuy"] integerValue]];
        NSLog(@"Model在此%ld",(long)[[dic objectForKey:@"isBuy"]integerValue]);
    }
}
@end
