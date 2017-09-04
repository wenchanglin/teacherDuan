//
//  EveryLessonPinaJiaCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryLessonPinaJiaCell.h"

@implementation EveryLessonPinaJiaCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _PinaJPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    _PinaJPic.image = [UIImage imageNamed:@"图层-93@2x_57.png"];
    _PingJNickName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PinaJPic.frame)+10, 10, 50, 20)];
    _PingJNickName.font = [UIFont systemFontOfSize:16];
    _PingJScore  = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 15, 90, 20)];
    _PingJScore.font = [UIFont systemFontOfSize:16];
    _PingJContent = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PinaJPic.frame)+10, CGRectGetMaxY(_PinaJPic.frame)+5, kScreenWidth-50, 20)];
    _PingJContent.font = [UIFont systemFontOfSize:16];
    _PingJCreateTime = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, CGRectGetMaxY(_PingJScore.frame)+10, 160, 20)];
    _PingJCreateTime.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_PingJContent];
    [self.contentView addSubview:_PingJScore];
    [self.contentView addSubview:_PingJNickName];
    [self.contentView addSubview:_PinaJPic];
}

-(void)configWithModel:(EveryLessonPinaJiaModel *)Model
{
    _PingJContent.text    = Model.LessonJContent;
    NSString * timeStampString = Model.LessonJCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _PingJCreateTime.text = [NSString stringWithFormat:@"%@",time];
    
    _PingJScore.text = [NSString stringWithFormat:@"评分:%@分",Model.LessonJScore];
    _PingJNickName.text   = Model.LessonJNickName;
}

@end
