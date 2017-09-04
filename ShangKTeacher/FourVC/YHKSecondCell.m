//
//  YHKSecondCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "YHKSecondCell.h"

@implementation YHKSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    _YHKBankName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _YHKBankName.font = [UIFont boldSystemFontOfSize:15];
    _YHKBankName.text = @"银行名称";
    _YHKChooseBank = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_YHKBankName.frame)+20, 10, 200, 20)];
    
    _YHKChooseBank.font = [UIFont boldSystemFontOfSize:15];
    
//    [self.contentView addSubview:_YHKChooseBank];
    [self.contentView addSubview:_YHKBankName];
    
}


@end
