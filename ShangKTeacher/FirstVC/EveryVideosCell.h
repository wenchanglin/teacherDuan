//
//  EveryVideosCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryVideoModel.h"
@interface EveryVideosCell : UITableViewCell
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UIView       *topView;
@property(nonatomic, strong)UIButton     *btnSelected;
@property (nonatomic,strong)UIView       *FirstView;
@property (nonatomic,strong)UIView       *SecondView;
@property (nonatomic,strong)UILabel      *FirstOneTitle;
@property (nonatomic,strong)UILabel      *FirstZuTOneTitle;
@property (nonatomic,strong)UILabel      *SecondOneTitle;
@property (nonatomic,strong)UILabel      *LineLabel;
@property (nonatomic,strong)UILabel      *OrganizationTitle;
@property (nonatomic,strong)UILabel      *LineTwoLabel;
@property (nonatomic,strong)UIImageView  *HeadImage;
@property (nonatomic,strong)UILabel      *FinalOrangizationLabel;
@property (nonatomic,strong)UILabel      *FinalTitle;
@property (nonatomic,strong)UIImageView  *TeacherImage;
@property (nonatomic,strong)UILabel      *FinalTeacherNameLabel;
@property (nonatomic,strong)UILabel      *FinalTeacherIntroTitle;
@property (nonatomic,strong)UITableView  *SecondTableView;

-(void)configWithModel:(EveryVideoModel *)Model;
@end
