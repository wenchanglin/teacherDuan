//
//  CreateGroupThirdCell.m
//  ShangKTeacher
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "CreateGroupThirdCell.h"

@implementation CreateGroupThirdCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _GroupThirdRow = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
    _GroupThirdRow.text = @"群简介";
    _GroupThirdRow.font = [UIFont systemFontOfSize:15];
    _GroupThirdInfoRow = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_GroupThirdRow.frame)+5, kScreenWidth-20, 70)];
    _GroupThirdInfoRow.font = [UIFont systemFontOfSize:15];
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(_GroupThirdRow.frame)+8, 120, 30)];
    _activityName.text = @"请输入文字...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_GroupThirdRow];
    [self.contentView addSubview:_GroupThirdInfoRow];
    [self.contentView addSubview:_activityName];
}
@end
