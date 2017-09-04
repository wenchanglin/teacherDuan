//
//  FriendUserInfoSecondCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendUserInfoSecondCell.h"

@implementation FriendUserInfoSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _InfoSecondTit = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
    _InfoSecondInfo = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-120, 20, 110, 20)];
    _InfoSecondInfo.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_InfoSecondTit];
    [self.contentView addSubview:_InfoSecondInfo];
}
@end
