//
//  WeiWanChengTableViewCell.h
//  ShangKTeacher
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeWorkListModel.h"
@interface WeiWanChengTableViewCell : UITableViewCell
@property (nonatomic,strong)UIButton    *HeadImage;
@property (nonatomic,strong)UILabel     *NameLabel;

-(void)configWith:(HomeWorkListModel *)Model;
@end
