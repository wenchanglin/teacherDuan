//
//  SetAdministratorCell.h
//  ShangKTeacher
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDanChatModel.h"
@interface SetAdministratorCell : UITableViewCell
@property (nonatomic,strong)UIImageView *AddimageView;
@property (nonatomic,strong)UILabel *AddNameLabel;

-(void)configWithModel:(FriendDanChatModel *)Model;
@end
