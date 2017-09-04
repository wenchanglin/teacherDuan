//
//  FriendDanChatCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendDanChatCell.h"

@implementation FriendDanChatCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _FriendDanChatImageSecond = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    _FriendDanChatImageSecond.layer.cornerRadius = 30;
    _FriendDanChatImageSecond.layer.masksToBounds = YES;
    _FriendDanChatSecondName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FriendDanChatImageSecond.frame)+10, 20, kScreenWidth/2, 20)];
    _FriendDanChatSecondName.font = [UIFont boldSystemFontOfSize:16];
    _FriendDanChatSecondTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FriendDanChatImageSecond.frame)+10, CGRectGetMaxY(_FriendDanChatSecondName.frame)+10, kScreenWidth/2, 20)];
    _FriendDanChatSecondTimeLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_FriendDanChatImageSecond];
    [self.contentView addSubview:_FriendDanChatSecondName];
    [self.contentView addSubview:_FriendDanChatSecondTimeLabel];
}

-(void)configWith:(FriendDanChatModel *)Model
{
    NSString * timeStampString = Model.FriendDanChatCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _FriendDanChatSecondTimeLabel.text = [NSString stringWithFormat:@"%@",time];
    
    _FriendDanChatSecondName.text = Model.FriendDanChatNickName;
    if (Model.FriendDanChatUserPhotoHead.length != 0) {
        [_FriendDanChatImageSecond setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.FriendDanChatUserPhotoHead]] placeholderImage:nil];
    }else{
        _FriendDanChatImageSecond.image = [UIImage imageNamed:@"哭脸.png"];
    }
    
}
@end
