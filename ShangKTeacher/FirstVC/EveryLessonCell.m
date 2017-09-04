//
//  EveryLessonCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryLessonCell.h"
@implementation EveryLessonCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    _mainScrollView.scrollEnabled = NO;
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _FirstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,width,height)];
    _FirstView.backgroundColor = kAppWhiteColor;
    _FirstOneTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, kScreenWidth, 20)];
    
    _FirstOneTitle.font = [UIFont systemFontOfSize:16];
    _FirstZuTOneTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_FirstOneTitle.frame)+30, 70, 20)];
    _FirstZuTOneTitle.text = @"适用人群";
    _FirstZuTOneTitle.font = [UIFont boldSystemFontOfSize:17];
    _LineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_FirstZuTOneTitle.frame)+10, kScreenWidth - 20, 1)];
    _LineLabel.backgroundColor = kAppLineColor;
    _SecondOneTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_LineLabel.frame)+10, kScreenWidth, 20)];
    
    _SecondOneTitle.font = [UIFont systemFontOfSize:16];
    
    [_FirstView addSubview:_FirstOneTitle];
    [_FirstView addSubview:_LineLabel];
    [_FirstView addSubview:_FirstZuTOneTitle];
    [_FirstView addSubview:_SecondOneTitle];
    
    _SecondView = [[UIView alloc]initWithFrame:CGRectMake(width, 0,width,height)];
    _SecondTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, width, height) style:UITableViewStyleGrouped];
    _SecondTableView.backgroundColor = kAppWhiteColor;
    [_SecondView addSubview:_SecondTableView];
    _SecondView.backgroundColor = kAppWhiteColor;
    _mainScrollView.backgroundColor = kAppBlueColor;
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


@end
