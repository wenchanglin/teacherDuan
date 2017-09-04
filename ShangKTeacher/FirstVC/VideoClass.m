//
//  VideoClass.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "VideoClass.h"
#import "AppDelegate.h"
#import "VideoCell.h"
#import "EveryVideosVC.h"
#import "FreeVideoVC.h"
#import "SearchVC.h"
#import "VideoClassModel.h"
@interface VideoClass ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_TableView;
    NSMutableArray *_dataArray;
}
@end

@implementation VideoClass

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createData];
    [self createNav];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _TableView.tableHeaderView = [self createHeadView];
    [self.view addSubview:_TableView];
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"sort":@"sellCount",@"status":@2} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *ARR = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in ARR) {
            VideoClassModel *Model = [[VideoClassModel alloc]init];
            [Model setDic:dict];
            [_dataArray addObject:Model];
        }
        [_TableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VideoClassModel *Model = _dataArray[indexPath.row];
    EveryVideosVC *video = [[EveryVideosVC alloc]init];
    video.videoCourseId = Model.VideoId;
    video.videoCourseName = Model.VideoName;
    video.videoCoursePrice = Model.Videoprice;
    video.videoCourseUrl    = Model.VideoUrl;
    video.videoCourseSellCount = Model.VideoSellCount;
    [self.navigationController pushViewController:video animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"畅销视频";
}

//取消悬浮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _TableView)
    {
        CGFloat sectionHeaderHeight = 28;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Video"];
    if (!cell) {
        cell = [[VideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Video"];
    }
    VideoClassModel *Model = _dataArray[indexPath.row];
    [cell configWithModel:Model];
    return cell;
}

-(UIView *)createHeadView
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    HeadView.backgroundColor = kAppWhiteColor;
    NSArray *PicArr = @[@"图层-75@3x_3.png",@"图层-75-拷贝@3x.png"];
    NSArray *TitleArr = @[@"免费课程",@"收费课程"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*20+i*(kScreenWidth - 40)/2, 15, (kScreenWidth - 40)/2, 120);
        [button setImage:[UIImage imageNamed:PicArr[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(objectBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(((kScreenWidth - 40)/2/2-25)+i*20+i*(kScreenWidth - 40)/2, HeadView.frame.size.height/2, 100, 20)];
        label.font =[UIFont boldSystemFontOfSize:20];
        label.text = TitleArr[i];
        label.textColor = kAppWhiteColor;
        
        [HeadView addSubview:button];
        [HeadView addSubview:label];
    }
    return HeadView;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"视频课堂";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BKlick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 15, 20, 20);
    [button2 setImage:[UIImage imageNamed:@"icon_search_white.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnMeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
    
}

-(void)objectBtn:(UIButton *)objcBtn
{
    if (objcBtn.tag == 10) {
        FreeVideoVC *Course = [[FreeVideoVC alloc]init];
        Course.NAvTit = @"免费课程";
        [self.navigationController pushViewController:Course animated:YES];
    }else{
        FreeVideoVC *Course = [[FreeVideoVC alloc]init];
        Course.NAvTit = @"收费课程";
        [self.navigationController pushViewController:Course animated:YES];
    }
}

-(void)BKlick:(UIButton *)btn
{
    if ([self.PayTit isEqualToString:@"Alerady"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}
//视频搜索
-(void)BtnMeClick:(UIButton *)btn
{
    SearchVC *search = [[SearchVC alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}
@end
