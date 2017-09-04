//
//  CreateGroupSEcCell.m
//  ShangKTeacher
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "CreateGroupSEcCell.h"

@implementation CreateGroupSEcCell

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
    _GroupSecRow = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
    _GroupSecRow.text = @"群名称";
    _GroupSecRow.font = [UIFont systemFontOfSize:15];
    _GroupInfoRow = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-110, 15, 100, 20)];
    _GroupInfoRow.placeholder= @"请输入群名称";
    _GroupInfoRow.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_GroupSecRow];
    [self.contentView addSubview:_GroupInfoRow];
}
@end
