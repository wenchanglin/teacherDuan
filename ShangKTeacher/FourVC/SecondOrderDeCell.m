//
//  SecondOrderDeCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondOrderDeCell.h"
@implementation SecondOrderDeCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _PriceDeLAbel      = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-120, 10, 110, 20)];
    _PriceDeLAbel.adjustsFontSizeToFitWidth = YES;
    _PriceDeLAbel.font = [UIFont boldSystemFontOfSize:17];
    
    //    [self.contentView addSubview:_PriceDeLAbel];
}
@end
