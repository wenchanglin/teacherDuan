//
//  HomeWorkListVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "HomeWorkListVC.h"
#import "AppDelegate.h"
#import "EveryHomeWorkVC.h"
#import "HomeWorkListModel.h"
#import "HomeWorkListCell.h"
#import "WeiWanChengTableViewCell.h"

@interface HomeWorkListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView   * _mainScrollView;
    UIView         * _topView;
    UITableView    *_tableView;
    NSMutableArray *_dataARray;
    NSMutableArray *_dataTwoARray;
    NSInteger       _page;
    BOOL            _isPulling;
    UITableView    *_firstView;
    UITableView    *_secondView;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end

@implementation HomeWorkListVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _dataARray = [NSMutableArray array];
    _dataTwoARray = [NSMutableArray array];
    _page = 0;
    [self createNav];
    [self createData];
    [self createTopView];
    [self initMainScrollView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)initMainScrollView
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_topView.frame))];
    CGFloat width  = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag   = 10;
    _firstView.delegate = self;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag   = 11;
    _secondView.delegate = self;
    _secondView.dataSource  = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    _mainScrollView.contentSize = CGSizeMake(width*2, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [self.view       addSubview:_mainScrollView];
}

#pragma mark--------------------------分界--------------------

-(void)createTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,40)];
    _topView.backgroundColor = kAppWhiteColor;
    UIButton *BtnSJ = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 40)];
    [BtnSJ setTitle:@"已交作业" forState:UIControlStateNormal];
    BtnSJ.tag = 11;
    [BtnSJ setTitleColor:kAppBlueColor forState:UIControlStateSelected];
    [BtnSJ addTarget:self action:@selector(BtnSJ:) forControlEvents:UIControlEventTouchUpInside];
    [BtnSJ setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    BtnSJ.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UIButton *BtnXJ = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2,0, kScreenWidth/2, 40)];
    [BtnXJ setTitle:@"未交作业" forState:UIControlStateNormal];
    [BtnXJ addTarget:self action:@selector(BtnSJ:) forControlEvents:UIControlEventTouchUpInside];
    BtnXJ.tag = 12;
    [BtnXJ setTitleColor:kAppBlueColor forState:UIControlStateSelected];
    [BtnXJ setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    BtnXJ.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, 1, 38)];
    label.backgroundColor = kAppLightGrayColor;
    
    BtnSJ.selected = YES;
    self.btnSelected = BtnSJ;
    
    
    [_topView addSubview:BtnSJ];
    [_topView addSubview:BtnXJ];
    [_topView addSubview:label];
    [self.view addSubview:_topView];
    
}

//上下架
-(void)BtnSJ:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 11) {
        btnSJ.selected = YES;
        [_dataARray removeAllObjects];
        _page = 0;
        [self createData];
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else
    {
        btnSJ.selected = YES;
        [_dataTwoARray removeAllObjects];
        _page = 0;
        [self createHomeWorkId];
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }
    
    self.btnSelected = btnSJ;
}

//下拉刷新
- (void)form {
    __weak HomeWorkListVC *weakSelf = self;
    if (_firstView) {
        _firstView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createData];
        }];
    }
    if (_secondView) {
        _secondView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createHomeWorkId];
        }];
    }
    
}
//上拉加载
- (void)updown {
    __weak HomeWorkListVC *weakSelf = self;
    if (_firstView) {
        _firstView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_firstView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createData];
            }
        }];
    }
    if (_secondView) {
        _secondView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_secondView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createHomeWorkId];
            }
        }];
    }
}

////下拉刷新
//- (void)form {
//    __weak HomeWorkListVC *weakSelf = self;
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _page = 0;
//        _isPulling = YES;
//        [weakSelf createData];
//    }];
//    
//}
////上拉加载
//- (void)updown {
//    __weak HomeWorkListVC *weakSelf = self;
//    _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
//        _page ++;
//        _isPulling = NO;
//        if (_page >= 50) {
//            [_tableView.mj_footer endRefreshing];
//            return ;
//        } else {
//            [weakSelf createData];
//        }
//    }];
//}

-(void)createHomeWorkId
{
    NSLog(@"课程Id%@",self.ActivityID);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"homeworkId":self.ActivityID} url:UrL_NotApplyHomeWork success:^(id responseObject) {
        [_secondView.mj_footer endRefreshing];
        [_secondView.mj_header endRefreshing];
        if (_isPulling ) {
            [_dataTwoARray removeAllObjects];
        }else{
            NSLog(@"上拉咯");
            [_dataTwoARray removeAllObjects];
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in Arr) {
            HomeWorkListModel *Model = [[HomeWorkListModel alloc]init];
            [Model setWtithDict:Dict];
            [_dataTwoARray addObject:Model];
        }
        [_secondView reloadData];
        NSLog(@"未完成学生列表%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"homeworkId":self.ActivityID,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_HomeworkLieBiao success:^(id responseObject) {
//        NSLog(@"我给你醉醉的%@",responseObject);
        [_firstView.mj_footer endRefreshing];
        [_firstView.mj_header endRefreshing];
        if (_isPulling || Manager.IsListPulling == 3) {
            [_dataARray removeAllObjects];
            Manager.IsListPulling = 0;
        }else{
            NSLog(@"上拉咯");
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            HomeWorkListModel *Model = [[HomeWorkListModel alloc]init];
            if ([[dict objectForKey:@"user"]isKindOfClass:[NSNull class]]) {
                
            }else{
                [Model setWithDic:dict];
            }
            [Model setDic:dict];
            [_dataARray addObject:Model];
        }
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 10) {
        return _dataARray.count;
    }else{
        return _dataTwoARray.count;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        return 100;
    }else if (tableView.tag == 11){
        return 80;
    }
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 10) {
        HomeWorkListModel *Model  = _dataARray[indexPath.section];
        EveryHomeWorkVC *homeWork = [[EveryHomeWorkVC alloc]init];
        homeWork.AnswerId         = Model.WorkListId;
        homeWork.ActivityID       = self.ActivityID;
        homeWork.StudentNickName  = Model.WorkListCentent;
        [self.navigationController pushViewController:homeWork animated:YES];
    }
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
    if (tableView.tag == 10) {
        HomeWorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
        if (!cell) {
            cell = [[HomeWorkListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Chat"];
        }
        HomeWorkListModel *Model = _dataARray[indexPath.section];
        [cell setWithModel:Model];
        return cell;
    }
    WeiWanChengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JY"];
    if (!cell) {
        cell = [[WeiWanChengTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JY"];
    }
    HomeWorkListModel *Model = _dataTwoARray[indexPath.section];
    [cell configWith:Model];
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"作业列表";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaCklick:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
