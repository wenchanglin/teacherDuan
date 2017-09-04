//
//  ZFBFirstCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ZFBFirstCell.h"

@implementation ZFBFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    _ZfLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _ZfLabel.font = [UIFont boldSystemFontOfSize:15];
    _ZfLabel.text = @"账户金额";
    _JinELabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ZfLabel.frame)+20, 10, 200, 20)];
//    _JinELabel.text = @"¥0.00";
    _JinELabel.font = [UIFont boldSystemFontOfSize:15];
//    [self.contentView addSubview:_JinELabel];
    [self.contentView addSubview:_ZfLabel];
    
}
@end
