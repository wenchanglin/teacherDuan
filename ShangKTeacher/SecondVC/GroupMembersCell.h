//
//  GroupMembersCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupMembersCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *PicImageView;
@property (nonatomic,strong)  UIImageView *BoyImage;
@property (nonatomic,strong)  UIImageView *GirlImage;
@property (nonatomic,strong)  UIImageView *JiaMImage;
@property (nonatomic,strong)  UILabel     *FirstTitle;
@property (nonatomic,strong)  UILabel     *BoyNumTitle;
@property (nonatomic,strong)  UILabel     *GirlNumTitle;
@property (nonatomic,strong)  UILabel     *JiaMNumTitle;
@property (nonatomic,strong)  UILabel     *SecondTitle;

@end
