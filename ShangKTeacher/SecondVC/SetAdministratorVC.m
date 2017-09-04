//
//  SetAdministratorVC.m
//  ShangKTeacher
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "SetAdministratorVC.h"
#import "FriendDanChatModel.h"
#import "SetAdministratorCell.h"
@interface SetAdministratorVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_tableView;
    NSMutableArray  *_dataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}

@end

@implementation SetAdministratorVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTableView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak SetAdministratorVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak SetAdministratorVC *weakSelf = self;
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
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"type":@1,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_FriendQuery success:^(id responseObject) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        if (_isPulling) {
            [_dataArray removeAllObjects];
        }
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr = [Dict objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            FriendDanChatModel *Model =[[FriendDanChatModel alloc]init];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
    SetAdministratorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlsJs"];
    if (!cell) {
        cell = [[SetAdministratorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AlsJs"];
    }
    if ([self.WhereCome isEqualToString:@"SystemQunManager"]) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-100, 25, 90, 30);
    [button setTitle:@"设为管理员" forState:UIControlStateNormal];
    button.backgroundColor = kAppBlueColor;
    button.tag = indexPath.section;
    [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button addTarget:self action:@selector(AdminSet:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:button];
    }else if ([self.WhereCome isEqualToString:@"ChangeManager"]){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth-100, 25, 90, 30);
        [button setTitle:@"更换管理员" forState:UIControlStateNormal];
        button.backgroundColor = kAppBlueColor;
        button.tag = indexPath.section;
        [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [button addTarget:self action:@selector(ChangeAdminSet:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }else{
        UIButton *AddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        AddBtn.layer.borderColor = kAppLineColor.CGColor;
        AddBtn.layer.borderWidth = 1;
        AddBtn.tag = indexPath.section;
        [AddBtn setTitle:@"添加" forState:UIControlStateNormal];
        AddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [AddBtn addTarget:self action:@selector(AddFriendBtn:) forControlEvents:UIControlEventTouchUpInside];
        [AddBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        AddBtn.frame = CGRectMake(kScreenWidth - 90, 30, 80, 20);
        [cell.contentView addSubview:AddBtn];
    }
    FriendDanChatModel *Model = _dataArray[indexPath.section];
    [cell configWithModel:Model];
    return cell;
}

-(void)AdminSet:(UIButton *)Admin
{
    NSLog(@"设为管理员");
    FbwManager *Manager = [FbwManager shareManager];
    FriendDanChatModel *Model = _dataArray[Admin.tag];
    Manager.TeacherId = Model.FriendDanChatId;
    Manager.TeacherNAme = Model.FriendDanChatNickName;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ChangeAdminSet:(UIButton *)Change
{
    NSLog(@"更换管理员");
    FriendDanChatModel *Model = _dataArray[Change.tag];
    NSArray *arr = @[@{@"id":Model.FriendDanChatId}];
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.GroupID,@"userId":jsonStr} url:UrL_ChangeGroupsAdmin success:^(id responseObject) {
       
        [self.navigationController popViewControllerAnimated:YES];
//        [self createManger];
    } failure:^(NSError *error) {
    }];
}

-(void)AddFriendBtn:(UIButton *)Bt
{
    
    FriendDanChatModel *Model = _dataArray[Bt.tag];
    __weak typeof(self) weakSelf = self;
    NSArray *arr = @[@{@"id":Model.FriendDanChatId}];
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"添加好友进群%@",jsonStr);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.GroupID,@"userIdListStr":jsonStr} url:UrL_AddStudent success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        //        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
    }];
    
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    if ([self.WhereCome isEqualToString:@"SystemQunManager"]||[self.WhereCome isEqualToString:@"ChangeManager"]) {
        label.text = @"设置群管理";
    }else{
       label.text = @"好友列表";
    }
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
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
