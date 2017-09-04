//
//  SearchModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"name"]) {
        [self setSearchName:[dic objectForKey:@"name"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setSearchId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"price"]) {
        [self setSearchPrice:[dic objectForKey:@"price"]];
    }
    if ([dic objectForKey:@"avgScore"]) {
        [self setSearchAvgScore:[dic objectForKey:@"avgScore"]];
    }
    if ([dic objectForKey:@"sellCount"]) {
        [self setSearchSellCount:[dic objectForKey:@"sellCount"]];
    }
    if ([dic objectForKey:@"photoUrl"]) {
        [self setSearchPhotoUrl:[dic objectForKey:@"photoUrl"]];
    }
    
}

@end
