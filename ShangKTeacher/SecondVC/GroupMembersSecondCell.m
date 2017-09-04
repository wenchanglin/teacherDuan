//
//  GroupMembersSecondCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "GroupMembersSecondCell.h"

@implementation GroupMembersSecondCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _PicManager = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 90, 90)];
//    _PicManager.image = [UIImage imageNamed:@"图层-64@2x.png"];
    _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_PicManager.frame)+10, 85, 20)];
    
    _NameLabel.font = [UIFont boldSystemFontOfSize:16];
    _NameLabel.textAlignment = NSTextAlignmentCenter;
    _BoyPic   = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_NameLabel.frame)+5, CGRectGetMaxY(_PicManager.frame)+10, 20, 20)];
    
    
    //    [self.contentView addSubview:_NameLabel];
//    [self.contentView addSubview:_PicManager];
    //    [self.contentView addSubview:_BoyPic];
}

@end
