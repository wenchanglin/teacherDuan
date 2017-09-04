//
//  NumberOneCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberOneModel.h"

@interface NumberOneCell : UITableViewCell
@property (nonatomic,strong) UILabel     *NumBerContent;
@property (nonatomic,strong) UIImageView *NumberImage;

-(void)configWithModel:(NumberOneModel *)Model;
@end
