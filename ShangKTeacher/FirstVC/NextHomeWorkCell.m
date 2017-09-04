//
//  NextHomeWorkCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "NextHomeWorkCell.h"

@implementation NextHomeWorkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SecondNextImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _SecondNextImage.image = [UIImage imageNamed:@"作业@2x_48.png"];
    _SecondNextCentent = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_SecondNextImage.frame)+10, 15, kScreenWidth - 120, 30)];
    _SecondNextCentent.font = [UIFont systemFontOfSize:16];
    _SecondNextCreateTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_SecondNextImage.frame)+10, CGRectGetMaxY(_SecondNextCentent.frame)+15, kScreenWidth - 120, 20)];
    _SecondNextCreateTime.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_SecondNextCreateTime];
    [self.contentView addSubview:_SecondNextCentent];
    [self.contentView addSubview:_SecondNextImage];
}

-(void)setWithModel:(NextHomeWorkModel *)Model
{
    NSString * timeStampString = Model.SecondCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _SecondNextCreateTime.text = [NSString stringWithFormat:@"%@",time];
    _SecondNextCentent.text = Model.SecondCentent;
}
@end
