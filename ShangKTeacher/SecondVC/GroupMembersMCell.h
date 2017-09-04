//
//  GroupMembersMCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupMembersModel.h"
@interface GroupMembersMCell : UITableViewCell
@property (nonatomic,strong)UIImageView *GroupMembersImageSex;
@property (nonatomic,strong)UIButton    *GroupMembersButton;
@property (nonatomic,strong)UILabel     *GroupMembersName;
@property (nonatomic,strong)UIImageView *GroupMembersPic;
@property (nonatomic,strong)UIButton    *DeleteBtnPic;
@end
