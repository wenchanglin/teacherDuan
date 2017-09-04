//
//  FriendNoFirstCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendNoFirstCell.h"
@implementation FriendNoFirstCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FirendPic              = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _FirendPic.image        = [UIImage imageNamed:@"系统消息@2x_25.png"];
    _FirendSystemLabel      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FirendPic.frame)+10, 10, 100, 20)];
    _FirendSystemLabel.text = @"系统消息";
    _FirendSystemLabel.font = [UIFont boldSystemFontOfSize:17];
    _FirendTitleLabel       = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_FirendSystemLabel.frame)+10, kScreenWidth-20, 20)];
    _FirendTitleLabel.font = [UIFont systemFontOfSize:16];
    _FirendTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, 150, 160, 20)];
    _FirendTimeLabel.adjustsFontSizeToFitWidth = YES;
    _FirendTimeLabel.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_FirendPic];
    [self.contentView addSubview:_FirendSystemLabel];
    [self.contentView addSubview:_FirendTitleLabel];
    [self.contentView addSubview:_FirendTimeLabel];
}

-(void)configWith:(FriendsNoticeModel *)Model
{
    NSString * timeStampString = Model.FriendsMessageCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _FirendTimeLabel.text = [NSString stringWithFormat:@"%@",time];

    _FirendTitleLabel.text = Model.FriendsMessageContent;
    _FirendTitleLabel.numberOfLines = 0;
    CGRect textFrame = _FirendTitleLabel.frame;
    _FirendTitleLabel.frame = CGRectMake(20, CGRectGetMaxY(_FirendSystemLabel.frame)+10, kScreenWidth-20, textFrame.size.height = [_FirendTitleLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_FirendTitleLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
    _FirendTitleLabel.frame = CGRectMake(20, CGRectGetMaxY(_FirendSystemLabel.frame)+10, kScreenWidth-20, textFrame.size.height);
}

@end
