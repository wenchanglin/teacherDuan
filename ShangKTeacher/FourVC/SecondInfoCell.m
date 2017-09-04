//
//  SecondInfoCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondInfoCell.h"
@implementation SecondInfoCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SecTitleLabel        = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 80, 20)];
    _SecTitleLabel.font   = [UIFont systemFontOfSize:17];
    _SecInfoLabel         = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-120, 35, 110, 20)];
    _SecInfoLabel.font    = [UIFont systemFontOfSize:17];
    _SecInfoLabel.textAlignment = NSTextAlignmentRight;
    _SecThirdTitle        = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 80, 20)];
    _SecThirdTitle.font   = [UIFont systemFontOfSize:17];
    _SecInfo              = [[UITextView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(_SecThirdTitle.frame)+10, kScreenWidth - 35, 70)];
    _SecInfo.font         = [UIFont systemFontOfSize:17];
//    [self.contentView addSubview:_SecInfo];
    _SecInfo.backgroundColor = kAppWhiteColor;
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(_SecThirdTitle.frame)+10 ,120, 30)];
    _activityName.text = @"请输入个人简介...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_SecTitleLabel];
//    [self.contentView addSubview:_activityName];
    [self.contentView addSubview:_SecInfoLabel];
    [self.contentView addSubview:_SecThirdTitle];
    
}
@end
