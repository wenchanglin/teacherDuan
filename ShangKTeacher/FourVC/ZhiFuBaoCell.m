//
//  ZhiFuBaoCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ZhiFuBaoCell.h"

@implementation ZhiFuBaoCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    _ZfbLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _ZfbLabel.font = [UIFont boldSystemFontOfSize:15];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ZfbLabel.frame)+20, 10, 200, 20)];
    //    _textField.placeholder = @"请输入价格...";
    _textField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_textField];
    [self.contentView addSubview:_ZfbLabel];
    
}

@end
