//
//  FinancialDetailsCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FinancialDetailsCell.h"

@implementation FinancialDetailsCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FinancialType = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    _FinancialType.font =[UIFont boldSystemFontOfSize:17];
//    _FinancialType.textAlignment = NSTextAlignmentCenter;
    _FinancialTime = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_FinancialType.frame)+15, kScreenWidth/2, 15)];
    _FinancialTime.font =[UIFont systemFontOfSize:14];
    _FinancialMoney = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-80, 25, 70, 20)];
    _FinancialMoney.textColor = kAppOrangeColor;
    _FinancialMoney.font =[UIFont boldSystemFontOfSize:17];
    _FinancialMoney.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_FinancialType];
    [self.contentView addSubview:_FinancialTime];
    [self.contentView addSubview:_FinancialMoney];
    
}

-(void)configWith:(FinancialDetailsModel *)Model
{
    NSString * timeStampString = Model.FinancialCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _FinancialTime.text = [NSString stringWithFormat:@"%@",time];
}
@end
