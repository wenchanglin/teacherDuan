//
//  FinancialDetailsModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FinancialDetailsModel.h"

@implementation FinancialDetailsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"createTime"]) {
        [self setFinancialCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"money"]) {
        [self setFinancialMoney:[dic objectForKey:@"money"]];
    }
    if ([[dic objectForKey:@"type"]integerValue]) {
        [self setFinancialType:[[dic objectForKey:@"type"]integerValue]];
    }
    if ([dic objectForKey:@"note"]) {
        [self setFinancialTypeNote:[dic objectForKey:@"note"]];
    }
    
}
@end
