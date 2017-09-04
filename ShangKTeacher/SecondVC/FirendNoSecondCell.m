//
//  FirendNoSecondCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FirendNoSecondCell.h"
@implementation FirendNoSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FirendSecPic              = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _FirendSecPic.image        = [UIImage imageNamed:@"系统消息@2x_25.png"];
    _FirendSecSystemLabel      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FirendSecPic.frame)+10, 10, 100, 20)];
    _FirendSecSystemLabel.text = @"系统消息";
    _FirendSecSystemLabel.font = [UIFont boldSystemFontOfSize:17];
    _FirendSecTitleLabel       = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_FirendSecPic.frame)+10, kScreenWidth-20, 20)];
    _FirendSecTitleLabel.font = [UIFont systemFontOfSize:16];
    
    _FirendSecTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, CGRectGetMaxY(_FirendSecTitleLabel.frame)+10, 160, 20)];
    
    _FirendSecTimeLabel.font = [UIFont systemFontOfSize:15];
    _FirendSecChuLi = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FirendSecPic.frame)+10, CGRectGetMaxY(_FirendSecTitleLabel.frame)+10, 60, 20)];
    _FirendSecChuLi.textColor = kAppBlueColor;
    _FirendSecChuLi.text = @"已处理";
    
    [self.contentView addSubview:_FirendSecPic];
    [self.contentView addSubview:_FirendSecSystemLabel];
    [self.contentView addSubview:_FirendSecTitleLabel];
    [self.contentView addSubview:_FirendSecTimeLabel];
    [self.contentView addSubview:_FirendSecChuLi];
}

-(void)configWith:(FriendsNoticeModel *)Model
{
    NSString * timeStampString = Model.FriendsMessageCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _FirendSecTimeLabel.text = [NSString stringWithFormat:@"%@",time];
    
    _FirendSecTitleLabel.text = Model.FriendsMessageContent;
    _FirendSecTitleLabel.numberOfLines = 0;
    CGRect textFrame = _FirendSecTitleLabel.frame;
    _FirendSecTitleLabel.frame = CGRectMake(20, CGRectGetMaxY(_FirendSecSystemLabel.frame)+10, kScreenWidth-20, textFrame.size.height = [_FirendSecTitleLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_FirendSecTitleLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
    _FirendSecTitleLabel.frame = CGRectMake(20, CGRectGetMaxY(_FirendSecSystemLabel.frame)+10, kScreenWidth-20, textFrame.size.height);
}

@end
