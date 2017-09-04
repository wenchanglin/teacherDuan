//
//  OrderDetaiCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrderDetaiCell.h"
@implementation OrderDetaiCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _OrderXiangQ = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _OrderXiangQ.font = [UIFont boldSystemFontOfSize:15];
    _OrderInfo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_OrderXiangQ.frame)+20, 10, kScreenWidth-130, 20)];
    _OrderInfo.font = [UIFont boldSystemFontOfSize:15];
    
    [self.contentView addSubview:_OrderInfo];
    [self.contentView addSubview:_OrderXiangQ];
    
}
@end
