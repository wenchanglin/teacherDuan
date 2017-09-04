//
//  StudentHomeWorkCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentHomeWorkModel.h"

@interface StudentHomeWorkCell : UITableViewCell
@property (nonatomic,strong) UIImageView *StudentImage;
@property (nonatomic,strong) UILabel     *StudentName;
@property (nonatomic,strong) UILabel     *StudentFaBuZuoye;

-(void)setWithModel:(StudentHomeWorkModel *)Model;
@end
