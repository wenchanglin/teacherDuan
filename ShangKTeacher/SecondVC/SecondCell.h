//
//  SecondCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondModel.h"
@interface SecondCell : UITableViewCell
@property (nonatomic,strong)UIImageView  *ImageSecond;
@property (nonatomic,strong)UILabel      *SecondName;
@property (nonatomic,strong)UILabel      *SecondTimeLabel;

-(void)configWith:(SecondModel *)Model;
@end
