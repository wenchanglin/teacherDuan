//
//  SecondHomeWorkCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondHomeWorkCell.h"
@implementation SecondHomeWorkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
        _DateLabel               = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-160, 160, 150, 20)];
        _DateLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _DateLabel.adjustsFontSizeToFitWidth = YES;
        _TuPianPic               = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
        _TuPianPic.layer.cornerRadius = 20;
        _TuPianPic.layer.masksToBounds = YES;
        _NickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TuPianPic.frame)+10, 25, 120, 20)];
        _NickNameLabel.font = [UIFont systemFontOfSize:16];
        _TitleLabel              = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TuPianPic.frame)+10, CGRectGetMaxY(_NickNameLabel.frame)+15, kScreenWidth-60, 20)];
        _TitleLabel.font = [UIFont systemFontOfSize:16];
    
        [self.contentView addSubview:_DateLabel];
        [self.contentView addSubview:_TuPianPic];
    
        [self.contentView addSubview:_NickNameLabel];
}

-(void)configWithModel:(SecondHomeWorkModel *)Model
{
//    CGRect rect = [Model.ThirdContent boundingRectWithSize:CGSizeMake(kScreenWidth - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
//    _TitleLabel.frame = CGRectMake(60, 30, kScreenWidth-60, rect.size.height);
    
    NSString * timeStampString = Model.ThirdCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _DateLabel.text = [NSString stringWithFormat:@"%@",time];
    
    if ([Model.ThirdNickPic isEqualToString:@""]) {
        _TuPianPic.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_TuPianPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.ThirdNickPic]] placeholderImage:nil];
    }
    _NickNameLabel.text = Model.ThirdNickName;
}

@end
