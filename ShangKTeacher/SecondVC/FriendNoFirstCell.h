//
//  FriendNoFirstCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsNoticeModel.h"
@interface FriendNoFirstCell : UITableViewCell
@property (nonatomic,strong)UIImageView *FirendPic;
@property (nonatomic,strong)UILabel     *FirendSystemLabel;
@property (nonatomic,strong)UILabel     *FirendTitleLabel;
@property (nonatomic,strong)UILabel     *FirendTimeLabel;

-(void)configWith:(FriendsNoticeModel *)Model;
@end
