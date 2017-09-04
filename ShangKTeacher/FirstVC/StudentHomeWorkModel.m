//
//  StudentHomeWorkModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "StudentHomeWorkModel.h"

@implementation StudentHomeWorkModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"id"]) {
        [self setStudentId:[dic objectForKey:@"id"]];
        NSLog(@"%@",[dic objectForKey:@"id"]);
    }
    if ([dic objectForKey:@"name"]) {
        [self setStudentName:[dic objectForKey:@"name"]];
    }
    
    if ([dic objectForKey:@"submitCount"]) {
        [self setSubmitCount:[[dic objectForKey:@"submitCount"]integerValue]];
    }
}

-(void)setDict:(NSDictionary *)Dict
{
    if ([Dict objectForKey:@"location"]) {
        [self setStudentPhotoList:[Dict objectForKey:@"location"]];
    }
}
@end
