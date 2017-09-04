//
//  FinancialDetailsVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FinancialDetailsVC.h"
#import "FinancialDetailsModel.h"
#import "FinancialDetailsCell.h"

@interface FinancialDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation FinancialDetailsVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createData];
    [self createNav];
    [self createTableView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak FinancialDetailsVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak FinancialDetailsVC *weakSelf = self;
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
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",_page]} url:UrL_FinancialDetails success:^(id responseObject) {
        NSLog(@"资金%@",responseObject);
        if (_isPulling) {
            [_dataArray removeAllObjects];
        }
        NSDictionary *rootDic =[responseObject objectForKey:@"data"];
        NSArray *Arr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dic in Arr) {
            FinancialDetailsModel *Model = [[FinancialDetailsModel alloc]init];
            [Model setDic:Dic];
            [_dataArray addObject:Model];
        }
        if (_isPulling) {
            [_tableView.mj_header endRefreshing];
        }else{
            [_tableView.mj_footer endRefreshing];
        }
        [_tableView reloadData];
        NSLog(@"有几个呢%ld",(long)_dataArray.count);
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
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
    FinancialDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FinancialDetails"];
    if (!cell) {
        
        cell = [[FinancialDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FinancialDetails"];
    }
    FinancialDetailsModel *Model = _dataArray[indexPath.section];
    if (Model.FinancialType == 1) {
        cell.FinancialType.text = Model.FinancialTypeNote;
        cell.FinancialMoney.text = [NSString stringWithFormat:@"+%@元",Model.FinancialMoney];
    }else{
        cell.FinancialType.text = Model.FinancialTypeNote;
        cell.FinancialMoney.text = [NSString stringWithFormat:@"-%@元",Model.FinancialMoney];
    }
    [cell configWith:Model];
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"资金明细";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BZick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BZick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
