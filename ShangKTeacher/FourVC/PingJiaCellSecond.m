//
//  PingJiaCellSecond.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "PingJiaCellSecond.h"

@implementation PingJiaCellSecond
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _LabelMiaoS = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    _LabelMiaoS.text = @"描述相符:";
    _LabelMiaoS.font = [UIFont boldSystemFontOfSize:17];
    
    [self.contentView addSubview:_LabelMiaoS];
    
}
@end
