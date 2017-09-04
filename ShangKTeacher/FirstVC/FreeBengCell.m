//
//  FreeBengCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FreeBengCell.h"

@implementation FreeBengCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FreeCourseTextPic         = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 80)];
    _FreeCourseTextLabel       = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, kScreenWidth - 120, 15)];
    _FreeCourseTextLabel.font  = [UIFont boldSystemFontOfSize:16];
    
    _FreeCoursePriceLabel      = [[UILabel alloc]initWithFrame:CGRectMake(105, 40, kScreenWidth - 120, 15)];
    _FreeCoursePriceLabel.font = [UIFont boldSystemFontOfSize:16];
    
    _FreeCoursePriceLabel.textColor = kAppRedColor;
    _FreeCoursePeopleLabel     = [[UILabel alloc]initWithFrame:CGRectMake(105, 70, 20, 15)];
    _FreeCoursePeopleLabel.font = [UIFont systemFontOfSize:15];
    _FreeCoursePeople      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FreeCoursePeopleLabel.frame)+1, 70, 100, 15)];
    _FreeCoursePeople.font = [UIFont systemFontOfSize:15];
    _FreeCoursePeople.text = @"人已学习";
    _FreeCourseFenshuLabel     = [[UILabel alloc]initWithFrame:CGRectMake(215, 70, 35, 15)];
    _FreeCourseFenshuLabel.font = [UIFont systemFontOfSize:15];
    _FreeCourseFenshuLabel.textAlignment = NSTextAlignmentCenter;
    _FreeCourseFenshuLabel.textColor = kAppOrangeColor;
    _FreeCourseFenShu          = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FreeCourseFenshuLabel.frame)+1, 70, 15, 15)];
    _FreeCourseFenShu.text     = @"分";
    _FreeCourseFenShu.font     = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_FreeCourseTextPic];
    [self.contentView addSubview:_FreeCourseTextLabel];
    [self.contentView addSubview:_FreeCoursePriceLabel];
    [self.contentView addSubview:_FreeCourseFenshuLabel];
    [self.contentView addSubview:_FreeCourseFenShu];
    [self.contentView addSubview:_FreeCoursePeopleLabel];
    [self.contentView addSubview:_FreeCoursePeople];
}

-(void)configWithModel:(FreeBengModel *)Model
{
    _FreeCoursePeopleLabel.text = [NSString stringWithFormat:@"%@",Model.FreeCourseSellCount];
    _FreeCoursePeopleLabel.textColor = kAppOrangeColor;
    _FreeCourseFenshuLabel.text = [NSString stringWithFormat:@"%.2f",Model.FreeCourseAvgScore];
    _FreeCourseTextLabel.text  = Model.FreeCourseName;
    if ([Model.FreeCoursePhotoUrl isKindOfClass:[NSNull class]]) {
        _FreeCourseTextPic.image   = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_FreeCourseTextPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.FreeCoursePhotoUrl]] placeholderImage:nil];
    }
}

@end
