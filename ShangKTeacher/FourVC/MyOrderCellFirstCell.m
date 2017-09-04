//
//  MyOrderCellFirstCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyOrderCellFirstCell.h"
@implementation MyOrderCellFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    
    _TopImage         = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _TopImage.image   = [UIImage imageNamed:@"商城-(4)@2x.png"];
    _DaiFuTitle      = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 10, 90, 20)];
    _DaiFuTitle.textColor = kAppRedColor;
    _DaiFuTitle.textAlignment = NSTextAlignmentCenter;
    _DaiFuTitle.font   = [UIFont boldSystemFontOfSize:15];
    _HanGuoTitle       = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 130, 20)];
    
    _HanGuoTitle.font  = [UIFont boldSystemFontOfSize:15];
    
    [self.contentView addSubview:_TopImage];
    [self.contentView addSubview:_DaiFuTitle];
    [self.contentView addSubview:_HanGuoTitle];
}

-(void)configWithModel:(MyOrderModel *)Model
{
    NSLog(@"%@",Model.MyOrderStoreName);
    _HanGuoTitle.text = Model.MyOrderStoreName;
}

@end
