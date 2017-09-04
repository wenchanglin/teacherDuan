//
//  FinancialDetailsModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinancialDetailsModel : NSObject
@property(nonatomic,copy) NSString *FinancialCreateTime;
@property(nonatomic,copy) NSString *FinancialMoney;
@property(nonatomic,assign) NSInteger  FinancialType;
@property(nonatomic,copy) NSString *FinancialTypeNote;

-(void)setDic:(NSDictionary *)dic;
@end
