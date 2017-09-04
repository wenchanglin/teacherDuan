//
//  OrderSecDetailCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrderSecDetailCell.h"
@implementation OrderSecDetailCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SecDetaNameLabel       = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 20)];
    
    _SecDetaNameLabel.textAlignment = NSTextAlignmentCenter;
    _SecDetaNameLabel.font  = [UIFont boldSystemFontOfSize:15];
    _SecDetaPhoneLAbel      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_SecDetaNameLabel.frame)+20, 15, kScreenWidth-150, 20)];
    
    _SecDetaPhoneLAbel.font = [UIFont boldSystemFontOfSize:15];
    _SecDetaDiZhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_SecDetaNameLabel.frame)+10, kScreenWidth-20, 20)];
    _SecDetaDiZhiLabel.numberOfLines = 0;
    
    
    
    //    [self.contentView addSubview:_SecDetaNameLabel];
    //    [self.contentView addSubview:_SecDetaPhoneLAbel];
    //    [self.contentView addSubview:_SecDetaDiZhiLabel];
    
}
@end
