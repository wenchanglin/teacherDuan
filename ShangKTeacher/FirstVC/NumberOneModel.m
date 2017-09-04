//
//  NumberOneModel.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "NumberOneModel.h"

@implementation NumberOneModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setWithDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"content"]) {
        [self setNumBerContent:[dic objectForKey:@"content"]];
    }
}

-(void)setWithdic:(NSDictionary *)Dic
{
    _PicArr = [NSMutableArray array];
    if ([Dic objectForKey:@"photoList"]) {
        [self setNumBerPhotoList:[Dic objectForKey:@"photoList"]];
    }
}

-(void)setWithDict:(NSDictionary *)Dict
{
    if ([Dict objectForKey:@"location"]) {
        [self setNumBerPhotoLoaction:[Dict objectForKey:@"location"]];
        [_PicArr addObject:[Dict objectForKey:@"location"]];
    }
}

-(void)setWithDit:(NSDictionary *)Dit
{
    if ([Dit objectForKey:@"videoUrl"]) {
        [self setNumBerVideoUrl:[Dit objectForKey:@"videoUrl"]];
    }
}
@end
