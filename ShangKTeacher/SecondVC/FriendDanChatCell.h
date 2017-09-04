//
//  FriendDanChatCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDanChatModel.h"
@interface FriendDanChatCell : UITableViewCell
@property (nonatomic,strong)UIImageView  *FriendDanChatImageSecond;
@property (nonatomic,strong)UILabel      *FriendDanChatSecondName;
@property (nonatomic,strong)UILabel      *FriendDanChatSecondTimeLabel;

-(void)configWith:(FriendDanChatModel *)Model;
@end
