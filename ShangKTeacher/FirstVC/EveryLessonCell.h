//
//  EveryLessonCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EveryLessonCell : UITableViewCell
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UIView       *topView;
@property(nonatomic, strong)UIButton     *btnSelected;
@property (nonatomic,strong)UIView       *FirstView;
@property (nonatomic,strong)UIView       *SecondView;
@property (nonatomic,strong)UILabel      *FirstOneTitle;
@property (nonatomic,strong)UILabel      *FirstZuTOneTitle;
@property (nonatomic,strong)UILabel      *SecondOneTitle;
@property (nonatomic,strong)UILabel      *LineLabel;
@property (nonatomic,strong)UITableView  *SecondTableView;
//@property (nonatomic,strong)UILabel      *OrganizationTitle;
//@property (nonatomic,strong)UILabel      *LineTwoLabel;
//@property (nonatomic,strong)UIImageView  *HeadImage;
//@property (nonatomic,strong)UILabel      *FinalOrangizationLabel;
//@property (nonatomic,strong)UILabel      *FinalTitle;
@end
