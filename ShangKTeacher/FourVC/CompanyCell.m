//
//  CompanyCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "CompanyCell.h"
@implementation CompanyCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _HeadPic           = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80, 10, 70, 70)];
    _HeadPic.layer.cornerRadius = 35;
    _HeadPic.layer.masksToBounds = YES;
    _TitleLabel        = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 80, 20)];
    _TitleLabel.font   = [UIFont systemFontOfSize:17];
    _InfoLabel         = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-140, 35, 130, 20)];
    _InfoLabel.font    = [UIFont systemFontOfSize:17];
    _InfoLabel.textAlignment = NSTextAlignmentRight;
//    _InfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    [self.contentView addSubview:_TitleLabel];
    
    [self.contentView addSubview:_InfoLabel];
}

@end
