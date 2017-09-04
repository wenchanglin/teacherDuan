//
//  FirendNoSecondCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsNoticeModel.h"
@interface FirendNoSecondCell : UITableViewCell
@property (nonatomic,strong)UIImageView *FirendSecPic;
@property (nonatomic,strong)UILabel     *FirendSecSystemLabel;
@property (nonatomic,strong)UILabel     *FirendSecTitleLabel;
@property (nonatomic,strong)UILabel     *FirendSecTimeLabel;
@property (nonatomic,strong)UILabel     *FirendSecChuLi;

-(void)configWith:(FriendsNoticeModel *)Model;
@end
