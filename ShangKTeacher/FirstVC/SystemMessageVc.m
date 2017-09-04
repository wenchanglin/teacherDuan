//
//  SystemMessageVc.m
//  ShangKTeacher
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "SystemMessageVc.h"
#import "AppDelegate.h"
#import "SystemMessageCell.h"
#import "SystemMessageModel.h"
@interface SystemMessageVc ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_TableView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}

@end

@implementation SystemMessageVc

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
    self.fd_interactivePopDisabled = YES;
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTableView];
    [self form];
    [self updown];
}

//下拉刷新
- (void)form {
    __weak SystemMessageVc *weakSelf = self;
    _TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak SystemMessageVc *weakSelf = self;
    _TableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        _page ++;
        _isPulling = NO;
        if (_page >= 50) {
            [_TableView.mj_footer endRefreshing];
            return ;
        } else {
            [weakSelf createData];
        }
    }];
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"type":@"messageTypeTeacher",@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_SystemMessage success:^(id responseObject) {
        if (_isPulling) {
            [_dataArray removeAllObjects];
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dic in arr) {
            SystemMessageModel *Model = [[SystemMessageModel alloc]init];
            [Model setDic:Dic];
            [_dataArray addObject:Model];
        }
        if (_isPulling) {
            [_TableView.mj_header endRefreshing];
        }else{
            [_TableView.mj_footer endRefreshing];
        }
        [_TableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    [self.view addSubview:_TableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"System"];
    if (!cell) {
        cell = [[SystemMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"System"];
    }
    SystemMessageModel *Model = _dataArray[indexPath.section];
    [cell configWithModel:Model];
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"消息通知";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Blick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)Blick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
