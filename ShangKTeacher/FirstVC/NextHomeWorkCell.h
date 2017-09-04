//
//  NextHomeWorkCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextHomeWorkModel.h"

@interface NextHomeWorkCell : UITableViewCell
@property (nonatomic,strong) UIImageView *SecondNextImage;
@property (nonatomic,strong) UILabel     *SecondNextCentent;
@property (nonatomic,strong) UILabel     *SecondNextCreateTime;

-(void)setWithModel:(NextHomeWorkModel *)Model;
@end
