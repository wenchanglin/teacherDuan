//
//  GroupSystemingSecondCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "GroupSystemingSecondCell.h"

@implementation GroupSystemingSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
    _TitleLAbel.text = @"群简介";
    _TitleLAbel.font = [UIFont boldSystemFontOfSize:15];
    _InfoLabel = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_TitleLAbel.frame)+10, kScreenWidth-20, 80)];
    _InfoLabel.font = [UIFont boldSystemFontOfSize:15];
    _ActivityName = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(_TitleLAbel.frame)+8, 120, 30)];
    _ActivityName.text = @"";
    _ActivityName.font = [UIFont systemFontOfSize:15];
    _ActivityName.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_TitleLAbel];
    [self.contentView addSubview:_InfoLabel];
    [self.contentView addSubview:_ActivityName];
}
@end
