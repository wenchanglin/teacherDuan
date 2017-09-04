//
//  NextHomeWorkModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "NextHomeWorkModel.h"

@implementation NextHomeWorkModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"createTime"]) {
        [self setSecondCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"content"]) {
        [self setSecondCentent:[dic objectForKey:@"content"]];
    }
    if ([dic objectForKey:@"photoList"]) {
        [self setSecondPhotoList:[dic objectForKey:@"photoList"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setSecondId:[dic objectForKey:@"id"]];
    }
}
@end
