//
//  HomeWorkListCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeWorkListModel.h"

@interface HomeWorkListCell : UITableViewCell
@property (nonatomic,strong) UIImageView *WorkListImage;
@property (nonatomic,strong) UILabel     *WorkListCentent;
@property (nonatomic,strong) UILabel     *WorkListCreateTime;

-(void)setWithModel:(HomeWorkListModel *)Model;
@end
