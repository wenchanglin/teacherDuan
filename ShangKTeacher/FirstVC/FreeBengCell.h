//
//  FreeBengCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeBengModel.h"
@interface FreeBengCell : UITableViewCell
@property (nonatomic,strong)UIImageView *FreeCourseTextPic;
@property (nonatomic,strong)UILabel     *FreeCourseTextLabel;
@property (nonatomic,strong)UILabel     *FreeCoursePriceLabel;
@property (nonatomic,strong)UILabel     *FreeCoursePeople;
@property (nonatomic,strong)UILabel     *FreeCoursePeopleLabel;
@property (nonatomic,strong)UILabel     *FreeCourseFenshuLabel;
@property (nonatomic,strong)UILabel     *FreeCourseFenShu;

-(void)configWithModel:(FreeBengModel *)Model;
@end
