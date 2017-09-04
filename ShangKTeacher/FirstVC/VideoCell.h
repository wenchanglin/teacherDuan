//
//  VideoCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoClassModel.h"
@interface VideoCell : UITableViewCell
@property (nonatomic,strong)UIImageView *TextPic;
@property (nonatomic,strong)UILabel     *TextLabel;
@property (nonatomic,strong)UILabel     *priceLabel;
@property (nonatomic,strong)UILabel     *FreePeopleLabel;
@property (nonatomic,strong)UILabel     *peopleLabel;
@property (nonatomic,strong)UILabel     *FreeFenshuLabel;
@property (nonatomic,strong)UILabel     *fenshuLabel;

-(void)configWithModel:(VideoClassModel *)Model;
@end
