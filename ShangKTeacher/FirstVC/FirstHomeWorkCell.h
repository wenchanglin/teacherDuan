//
//  FirstHomeWorkCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstHomeWorkModel.h"

@interface FirstHomeWorkCell : UITableViewCell
@property (nonatomic,strong)UILabel     *SecondContent;
@property (nonatomic,strong)UILabel     *SecNameLabel;
@property (nonatomic,strong)UILabel     *SecDateLabel;
@property (nonatomic,strong)UIImageView *PicWomen;

-(void)configWithModel:(FirstHomeWorkModel *)Model;

@end
