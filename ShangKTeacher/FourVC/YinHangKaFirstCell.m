//
//  YinHangKaFirstCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "YinHangKaFirstCell.h"

@implementation YinHangKaFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _YHKLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _YHKLabel.font = [UIFont boldSystemFontOfSize:15];
    _YHKtextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_YHKLabel.frame)+20, 10, 200, 20)];
    _YHKtextField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_YHKtextField];
    [self.contentView addSubview:_YHKLabel];
}

@end
