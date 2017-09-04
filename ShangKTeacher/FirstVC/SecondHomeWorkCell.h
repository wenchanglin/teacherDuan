//
//  SecondHomeWorkCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondHomeWorkModel.h"
@interface SecondHomeWorkCell : UITableViewCell
@property (nonatomic,strong)UIImageView *TuPianPic;
@property (nonatomic,strong)UILabel     *DateLabel;
@property (nonatomic,strong)UILabel     *TitleLabel;
@property (nonatomic,strong)UILabel     *NickNameLabel;

-(void)configWithModel:(SecondHomeWorkModel *)Model;
@end
