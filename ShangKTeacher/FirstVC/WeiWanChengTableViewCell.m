//
//  WeiWanChengTableViewCell.m
//  ShangKTeacher
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "WeiWanChengTableViewCell.h"

@implementation WeiWanChengTableViewCell

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
    _HeadImage = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    _HeadImage.layer.cornerRadius = 25;
    _HeadImage.layer.masksToBounds = YES;
    _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_HeadImage.frame)+10, 30, kScreenWidth/2, 20)];
    _NameLabel.font = [UIFont boldSystemFontOfSize:15];
    _NameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_HeadImage];
    [self.contentView addSubview:_NameLabel];
}

-(void)configWith:(HomeWorkListModel *)Model
{
    if (Model.WorkListUserPhotoHead == nil) {
        [_HeadImage setBackgroundImage:[UIImage imageNamed:@"哭脸.png"] forState:UIControlStateNormal];
    }else{
        [_HeadImage setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.WorkListUserPhotoHead]] placeholderImage:nil];
    }
    _NameLabel.text = Model.WorkListNickName;
}

@end
