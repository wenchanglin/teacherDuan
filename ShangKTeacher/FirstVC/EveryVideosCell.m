//
//  EveryVideosCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryVideosCell.h"
@implementation EveryVideosCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-200)];
    _mainScrollView.scrollEnabled = NO;
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _FirstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,width,height)];
    _FirstView.backgroundColor = kAppWhiteColor;
    _FirstOneTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, kScreenWidth, 20)];
    
    _FirstOneTitle.font = [UIFont systemFontOfSize:16];
    _FirstZuTOneTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 70, 20)];
    _FirstZuTOneTitle.text = @"适用人群";
    _FirstZuTOneTitle.font = [UIFont boldSystemFontOfSize:17];
    _LineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, kScreenWidth - 20, 1)];
    _LineLabel.backgroundColor = kAppLineColor;
    _SecondOneTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, kScreenWidth, 20)];
    
    _SecondOneTitle.font = [UIFont systemFontOfSize:16];
    _OrganizationTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, kScreenWidth-100, 20)];
    _OrganizationTitle.text = @"机构/讲师介绍";
    _OrganizationTitle.font = [UIFont boldSystemFontOfSize:17];
    _LineTwoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, kScreenWidth - 20, 1)];
    _LineTwoLabel.backgroundColor = kAppLineColor;
    _HeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 220, 50, 50)];
    _HeadImage.image = [UIImage imageNamed:@"图层-93@2x_57.png"];
    _FinalOrangizationLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 225, kScreenWidth-150, 15)];
    _FinalOrangizationLabel.font = [UIFont boldSystemFontOfSize:17];
    _FinalTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 251, kScreenWidth - 90, 15)];
    _FinalTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _FinalTitle.font = [UIFont systemFontOfSize:15];
    _TeacherImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_FinalTitle.frame)+25, 50, 50)];
    _TeacherImage.image = [UIImage imageNamed:@"图层-93@2x_57.png"];
    _FinalTeacherNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(_FinalTitle.frame)+30, kScreenWidth-150, 15)];
    _FinalTeacherNameLabel.font = [UIFont boldSystemFontOfSize:17];
    _FinalTeacherIntroTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(_FinalTeacherNameLabel.frame)+10, kScreenWidth-150, 15)];
    _FinalTeacherIntroTitle.font = [UIFont systemFontOfSize:15];
    
    [_FirstView addSubview:_FirstOneTitle];
    [_FirstView addSubview:_LineLabel];
    [_FirstView addSubview:_FinalTitle];
    [_FirstView addSubview:_LineTwoLabel];
    [_FirstView addSubview:_HeadImage];
    [_FirstView addSubview:_FinalOrangizationLabel];
    [_FirstView addSubview:_OrganizationTitle];
    [_FirstView addSubview:_FirstZuTOneTitle];
    [_FirstView addSubview:_FinalTeacherNameLabel];
    [_FirstView addSubview:_FinalTeacherIntroTitle];
    [_FirstView addSubview:_TeacherImage];
    [_FirstView addSubview:_SecondOneTitle];
    
    _SecondView = [[UIView alloc]initWithFrame:CGRectMake(width, 0,width,height-64)];
    _SecondView.backgroundColor = kAppWhiteColor;
    _SecondTableView.backgroundColor = kAppWhiteColor;
    _SecondTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, width, height-64) style:UITableViewStyleGrouped];
    [_SecondView addSubview:_SecondTableView];
    _mainScrollView.backgroundColor = kAppWhiteColor;
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,40)];
    _topView.backgroundColor = kAppWhiteColor;
    
    NSArray *arr = @[@"详情",@"评价"];
    for (int i=0; i<2; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i+i*(kScreenWidth-1)/2, 0, (kScreenWidth-1)/2, 40);
        button.tag = 10+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kAppBlueColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(BtnLose:) forControlEvents:UIControlEventTouchUpInside];
        if (i > 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-1)/2 + i, 0, 1, 38)];
            label.backgroundColor = kAppLightGrayColor;
            [_topView addSubview:label];
        }
        if (button.tag == 10) {
            button.selected = YES;
            self.btnSelected = button;
        }
        [_topView addSubview:button];
    }
    [_mainScrollView addSubview:_FirstView];
    [_mainScrollView addSubview:_SecondView];
    [self.contentView addSubview:_mainScrollView];
    [self.contentView addSubview:_topView];
}

-(void)BtnLose:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 10) {
        btnSJ.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else if(btnSJ.tag == 11)
    {
        btnSJ.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }
    self.btnSelected = btnSJ;
}

-(void)configWithModel:(EveryVideoModel *)Model
{
    _FirstOneTitle.text  = Model.EveryVideoIntro;
    _FirstOneTitle.numberOfLines = 0;
    CGRect textFrame    = _FirstOneTitle.frame;
    _FirstOneTitle.frame  = CGRectMake(10, 50, kScreenWidth, textFrame.size.height = [_FirstOneTitle.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_FirstOneTitle.font,NSFontAttributeName ,nil] context:nil].size.height);
    _FirstOneTitle.frame  = CGRectMake(10, 50, kScreenWidth, textFrame.size.height);
    _SecondOneTitle.text = Model.EveryVideoFitPeople;
    _FinalOrangizationLabel.text = Model.EveryVideoOrgName;
    _FinalTitle.text     = Model.EveryVideoOrgIntro;
    _FinalTeacherNameLabel.text = Model.EveryVideoTeacherName;
    _FinalTeacherIntroTitle.text = Model.EveryVideoTeacherIntro;
}



@end
