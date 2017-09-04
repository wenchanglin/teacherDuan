//
//  FirstHomeWorkModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FirstHomeWorkModel.h"

@implementation FirstHomeWorkModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setWithDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"content"]) {
        [self setSecondContent:[dic objectForKey:@"content"]];
    }
}

-(void)setWithdic:(NSDictionary *)Dic
{
    _PicArr = [NSMutableArray array];
    if ([Dic objectForKey:@"photoList"]) {
        [self setSECPhotoList:[Dic objectForKey:@"photoList"]];
    }
}

-(void)setWithDict:(NSDictionary *)Dict
{
    if ([Dict objectForKey:@"location"]) {
        [self setSecondPhotoList:[Dict objectForKey:@"location"]];
        [_PicArr addObject:[Dict objectForKey:@"location"]];
    }
}

-(void)setWithDit:(NSDictionary *)Dit
{
    if ([Dit objectForKey:@"videoUrl"]) {
        [self setSecondVideoUrl:[Dit objectForKey:@"videoUrl"]];
    }
}
@end
