//
//  GroupMembersCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "GroupMembersCell.h"

@implementation GroupMembersCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _PicImageView       = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 90)];
    _FirstTitle         = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PicImageView.frame)+10, 15, kScreenWidth-120, 20)];
    
    _FirstTitle.font    = [UIFont boldSystemFontOfSize:16];
    _BoyImage           = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PicImageView.frame)+10, CGRectGetMaxY(_FirstTitle.frame)+10, 15, 15)];
    _BoyImage.image     = [UIImage imageNamed:@"形状-1-拷贝-2@2x_29.png"];
    _BoyNumTitle        = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_BoyImage.frame)+5, CGRectGetMaxY(_FirstTitle.frame)+10, 50, 15)];
//    _BoyNumTitle.text   = @"135人";
    _BoyNumTitle.font   = [UIFont boldSystemFontOfSize:15];
    _GirlImage          = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_BoyNumTitle.frame)+3, CGRectGetMaxY(_FirstTitle.frame)+10, 15, 15)];
    _GirlImage.image    = [UIImage imageNamed:@"形状-2-拷贝@2x_49.png"];
    _GirlNumTitle       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_GirlImage.frame)+5, CGRectGetMaxY(_FirstTitle.frame)+10, 50, 15)];
//    _GirlNumTitle.text  = @"110人";
    _GirlNumTitle.font  = [UIFont boldSystemFontOfSize:15];
    _JiaMImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_GirlNumTitle.frame)+3, CGRectGetMaxY(_FirstTitle.frame)+10, 15, 15)];
    _JiaMImage.image    = [UIImage imageNamed:@"icon_sex_secret.png"];
    _JiaMNumTitle       = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_JiaMImage.frame)+5, CGRectGetMaxY(_FirstTitle.frame)+10, 50, 15)];
//    _JiaMNumTitle.text  = @"140人";
    _JiaMNumTitle.font  = [UIFont boldSystemFontOfSize:15];
    _SecondTitle        = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PicImageView.frame)+10, CGRectGetMaxY(_GirlNumTitle.frame)+10, kScreenWidth-125, 20)];
    _SecondTitle.font = [UIFont systemFontOfSize:14];
    
//    [self.contentView addSubview:_PicImageView];
    [self.contentView addSubview:_JiaMImage];
    [self.contentView addSubview:_BoyImage];
//    [self.contentView addSubview:_BoyNumTitle];
//    [self.contentView addSubview:_GirlNumTitle];
    [self.contentView addSubview:_GirlImage];
//    [self.contentView addSubview:_JiaMNumTitle];
    
}

@end
