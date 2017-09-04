//
//  FirstVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FirstVC.h"
#import "AppDelegate.h"
#import "VideoClass.h"
#import "StudentHomeWorkVC.h"
#import "MyLessonsVC.h"
#import "UseHelp.h"
#import "SystemMessageVc.h"
@interface FirstVC ()

@end

@implementation FirstVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self createNav];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createView
{
    NSArray *arr = @[@"作业@2x.png",@"视频-(4)@2x.png",@"课程-(5)@2x.png"];
    NSArray *titleArr = @[@"学生作业",@"视频课堂",@"我的课程"];
    UIButton *ImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ImageBtn.frame     = CGRectMake(0, 64, kScreenWidth, kScreenHeight/4-30);
    [ImageBtn setBackgroundImage:[UIImage imageNamed:@"TeacherFirstPic.png"] forState:UIControlStateNormal];
    [ImageBtn addTarget:self action:@selector(ImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    for (int i=0; i<3; i++) {
        UIButton *ThreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ThreeBtn.backgroundColor   = kAppWhiteColor;
        ThreeBtn.tag               = 10+i;
        ThreeBtn.layer.borderWidth = 1;
        ThreeBtn.layer.borderColor = kAppLineColor.CGColor;
        ThreeBtn.frame             = CGRectMake(10+(i%2)*10+(i%2)*(kScreenWidth-30)/2, (kScreenHeight/3.1)+(i/2)*10+(i/2)*(kScreenHeight/4), (kScreenWidth-30)/2, kScreenHeight/4);
        [ThreeBtn addTarget:self action:@selector(ThreeBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageView     = [[UIImageView alloc]initWithFrame:CGRectMake(40, 20, ((kScreenWidth-30)/2-80), kScreenHeight/4-80)];
        imageView.image = [UIImage imageNamed:arr[i]];
        UILabel *Title  = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetMaxX(imageView.frame)-110)/2, CGRectGetMaxY(imageView.frame)-10, 80, 20)];
        Title.text      = titleArr[i];
        Title.font      = [UIFont systemFontOfSize:17];
        
        [imageView addSubview:Title];
        [ThreeBtn addSubview:imageView];
        [self.view addSubview:ThreeBtn];
    }
    [self.view addSubview:ImageBtn];
}

-(void)ImageBtn:(UIButton *)ImaBtn
{
    NSLog(@"首图");
    UseHelp *help = [[UseHelp alloc]init];
    [self.navigationController pushViewController:help animated:YES];
}

-(void)ThreeBtn:(UIButton *)ThreeBtn
{
    if (ThreeBtn.tag == 10) {
        NSLog(@"点击第1个按钮");
        StudentHomeWorkVC *home = [[StudentHomeWorkVC alloc]init];
        [self.navigationController pushViewController:home animated:YES];
    }else if (ThreeBtn.tag == 11){
        VideoClass *class = [[VideoClass alloc]init];
        [self.navigationController pushViewController:class animated:YES];
//        NSLog(@"点击第2个按钮");

    }else{
        NSLog(@"点击第3个按钮");
        MyLessonsVC *Lesson = [[MyLessonsVC alloc]init];
        [self.navigationController pushViewController:Lesson animated:YES];
    }
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 45)/2, 10, 70, 30)];
    label.text = @"教师端";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    [button2 setImage:[UIImage imageNamed:@"XinFeng@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(btnClck) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:label];
    [NavBarview addSubview:button2];
    [self.view addSubview:NavBarview];
}

-(void)btnClck
{
    SystemMessageVc *SysMess = [[SystemMessageVc alloc]init];
    [self.navigationController pushViewController:SysMess animated:YES];
}
@end
