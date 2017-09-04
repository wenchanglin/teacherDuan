//
//  PingJiaCellThird.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "PingJiaCellThird.h"

@implementation PingJiaCellThird
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight/3)];
    _firstTextView.font = [UIFont systemFontOfSize:15];
    _firstTextView.backgroundColor = kAppWhiteColor;
    [self.contentView addSubview:_firstTextView];
    _firstName = [[UILabel alloc]initWithFrame:CGRectMake(3, 2, 120, 30)];
    [self.contentView addSubview:_firstName];
    _firstName.text = @"亲，写点评论吧...";
    _firstName.font = [UIFont systemFontOfSize:15];
    _firstName.textColor = kAppGrayColor;
}
@end
