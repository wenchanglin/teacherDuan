//
//  SystemMessageModel.m
//  ShangKTeacher
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "SystemMessageModel.h"

@implementation SystemMessageModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"content"]) {
        [self setSystemContent:[dic objectForKey:@"content"]];
    }
    if ([dic objectForKey:@"createTime"]) {
        [self setSystemTime:[dic objectForKey:@"createTime"]];
        NSLog(@"时间%@",[dic objectForKey:@"createTime"]);
    }
}
@end
