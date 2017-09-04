//
//  SetAdministratorCell.m
//  ShangKTeacher
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "SetAdministratorCell.h"

@implementation SetAdministratorCell

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
    _AddimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    
    _AddNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_AddimageView.frame)+10, 30, 100, 20)];
    _AddNameLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_AddNameLabel];
    [self.contentView addSubview:_AddimageView];
}

-(void)configWithModel:(FriendDanChatModel *)Model
{
    if ([Model.FriendDanChatUserPhotoHead isKindOfClass:[NSNull class]]) {
        _AddimageView.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_AddimageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.FriendDanChatUserPhotoHead]] placeholderImage:nil];
    }
    _AddNameLabel.text  = Model.FriendDanChatNickName;
}

@end
