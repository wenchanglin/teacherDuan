//
//  CreateGroupFourCell.m
//  ShangKTeacher
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "CreateGroupFourCell.h"

@implementation CreateGroupFourCell

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
    _GroupFourRow = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
    _GroupFourRow.text = @"群管理";
    _GroupFourRow.font = [UIFont systemFontOfSize:15];
    _GroupFourInfoRow = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-110, 20, 100, 20)];
    _GroupFourInfoRow.placeholder= @"请选择群管理";
    _GroupFourInfoRow.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_GroupFourRow];
    //[self.contentView addSubview:_GroupFourInfoRow];
}
@end
