//
//  StudentHomeWorkVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "StudentHomeWorkVC.h"
#import "AppDelegate.h"
#import "NextHomeWorkVC.h"
#import "StudentHomeWorkModel.h"
#import "StudentHomeWorkCell.h"

@interface StudentHomeWorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation StudentHomeWorkVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.PullPage == 3) {
        _page = 0;
        Manager.PullPage = 0;
    }
    [self createData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createTableView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak StudentHomeWorkVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak StudentHomeWorkVC *weakSelf = self;
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
    NSLog(@"传来作业的几啊%ld",(long)Manager.IsListPulling);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_HomeStudent success:^(id responseObject) {
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
            StudentHomeWorkModel *Model = [[StudentHomeWorkModel alloc]init];
            NSDictionary *Dic = [dict objectForKey:@"course"];
            [Model setDic:Dic];
            if ([[Dic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]) {
            }else{
                NSArray *RoDicArr = [Dic objectForKey:@"photoList"];
                for (NSDictionary *DiT in RoDicArr) {
                    [Model setDict:DiT];
                }
            }
            [_dataArray addObject:Model];
        }
//        if (_isPulling) {
//            [_tableView.mj_header endRefreshing];
//        }else{
//            [_tableView.mj_footer endRefreshing];
//        }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StudentHomeWorkModel *Model  = _dataArray[indexPath.section];
    NextHomeWorkVC *Home = [[NextHomeWorkVC alloc]init];
    Home.courseId = Model.StudentId;
    [self.navigationController pushViewController:Home animated:YES];
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
    StudentHomeWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
    if (!cell) {
        
        cell = [[StudentHomeWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Chat"];
    }
    StudentHomeWorkModel *Model = _dataArray[indexPath.section];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
