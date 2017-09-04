//
//  SecondCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _ImageSecond = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    _SecondName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageSecond.frame)+10, 20, kScreenWidth/2, 20)];
    _SecondName.font = [UIFont boldSystemFontOfSize:16];
    _SecondTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageSecond.frame)+10, CGRectGetMaxY(_SecondName.frame)+10, kScreenWidth/2, 20)];
    _SecondTimeLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_ImageSecond];
    [self.contentView addSubview:_SecondName];
    [self.contentView addSubview:_SecondTimeLabel];
}

-(void)configWith:(SecondModel *)Model
{
    NSString * timeStampString = Model.SecondCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _SecondTimeLabel.text = [NSString stringWithFormat:@"%@",time];
    _SecondName.text = Model.SecondName;
    if ([Model.SecondChatGroupPhotoUrl isKindOfClass:[NSNull class]]) {
        _ImageSecond.image =[UIImage imageNamed:@"icon-群组头像.png"];
    }else{
        [_ImageSecond setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.SecondChatGroupPhotoUrl]] placeholderImage:nil];
    }
}

@end
