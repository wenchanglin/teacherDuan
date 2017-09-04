//
//  NextHomeWorkVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "NextHomeWorkVC.h"
#import "HomeWorkListVC.h"
#import "NextHomeWorkModel.h"
#import "NextHomeWorkCell.h"
#import "PublishJobVC.h"
#import "VideoVC.h"

@interface NextHomeWorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    UIView         * PushView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation NextHomeWorkVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.PullPage == 3) {
        _page = 0;
        Manager.PullPage = 0;
    }
    [self  createData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [PushView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _page = 0;
    _dataArray = [NSMutableArray array];
    [self  createNav];
    [self  createTableView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak NextHomeWorkVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
    
}
//上拉加载
- (void)updown {
    __weak NextHomeWorkVC *weakSelf = self;
    _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        _page ++;
        _isPulling = NO;
        if (_page >= 50) {
            [_tableView.mj_footer endRefreshing];
            return ;
        } else {
            [weakSelf createData];
        }
    }];
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
//    NSLog(@"我笑出声%ld",Manager.IsListPulling);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.courseId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_HomeworkIssue success:^(id responseObject) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
      if (_isPulling || Manager.IsListPulling == 3) {
          [_dataArray removeAllObjects];
          Manager.IsListPulling = 0;
      }else{
          NSLog(@"上拉咯");
      }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            NextHomeWorkModel *Model = [[NextHomeWorkModel alloc]init];
            [Model setDic:dict];
            [_dataArray addObject:Model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NextHomeWorkModel *Model = _dataArray[indexPath.section];
    HomeWorkListVC *list = [[HomeWorkListVC alloc]init];
    list.ActivityID = Model.SecondId;
    [self.navigationController pushViewController:list animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextHomeWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatIn"];
    if (!cell) {
        
        cell = [[NextHomeWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatIn"];
    }
    NextHomeWorkModel *Model = _dataArray[indexPath.section];
    [cell setWithModel:Model];
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"学生作业";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 80, 10, 80, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"发布作业" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(AddAchieveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}

-(void)BaClick:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}
//发布作业弹窗
-(void)AddAchieveClick:(UIButton *)btn1
{
    NSArray *arr = @[@"照片@2x.png",@"视频-(5)@2x.png"];
    NSArray *Tit = @[@"文字/图片",@"视频"];
    PushView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-322, kScreenWidth, 322)];
    PushView.backgroundColor = kAppWhiteColor;
    UILabel *TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120)/2, 20, 120, 30)];
    TitleLAbel.textAlignment = NSTextAlignmentCenter;
    TitleLAbel.text = @"选择作业类型";
    TitleLAbel.font = [UIFont boldSystemFontOfSize:16];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(60+i*((kScreenWidth-120-100)/2)+i*100, 80, (kScreenWidth-120-100)/2, (kScreenWidth-120-100)/2);
        button.tag = 10+i;
        [button addTarget:self action:@selector(ChooseTn:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        UILabel *TitArLabel = [[UILabel alloc]initWithFrame:CGRectMake(60+i*(((kScreenWidth-120-100)/2))+i*100+((kScreenWidth-120-100)/2-80)/2, CGRectGetMaxY(button.frame)+10, 80, 20)];
        TitArLabel.font = [UIFont systemFontOfSize:17];
        TitArLabel.text = Tit[i];
        TitArLabel.textAlignment = NSTextAlignmentCenter;
        [PushView addSubview:button];
        [PushView addSubview:TitArLabel];
    }
    UIButton *CloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.backgroundColor = kAppWhiteColor;
    CloseBtn.frame = CGRectMake(0, 322-50, kScreenWidth, 50);
    [CloseBtn setImage:[UIImage imageNamed:@"关闭@2x_7.png"] forState:UIControlStateNormal];
    [CloseBtn addTarget:self action:@selector(CloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [PushView addSubview:TitleLAbel];
    [PushView addSubview:CloseBtn];
    
    [[[UIApplication sharedApplication].windows lastObject]addSubview:PushView];
}

-(void)ChooseTn:(UIButton *)ChooBtn
{
    if (ChooBtn.tag == 10) {
        NSLog(@"文字");
        PublishJobVC *job = [[PublishJobVC alloc]init];
        job.courseId = self.courseId;
        job.NavTitle = @"发布图文作业";
        NSLog(@"图文%@",job.courseId);
        [self.navigationController pushViewController:job animated:YES];
        
    }else{
        NSLog(@"视频");
        PublishJobVC *job = [[PublishJobVC alloc]init];
        job.NavTitle = @"发布视频作业";
        job.courseId = self.courseId;
        NSLog(@"视频%@",job.courseId);
//        VideoVC *job =[[ VideoVC alloc]init];
        [self.navigationController pushViewController:job animated:YES];
    }
}

-(void)CloseBtn:(UIButton *)CloseBtn
{
    NSLog(@"关闭");
    [PushView removeFromSuperview];
}


@end
