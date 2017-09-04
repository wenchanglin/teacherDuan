//
//  SecondVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SecondVC.h"
#import "AppDelegate.h"
#import "FriendsNoticeVC.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatWithFriendVc.h"
#import "SecondCell.h"
#import "SecondModel.h"
#import "FriendDanChatModel.h"
#import "FriendDanChatCell.h"
#import "CreateGroupVC.h"
@interface SecondVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * _mainScrollView;
    UIView       * _topView;
    UITableView  * _firstView;
    UITableView  * _secondView;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataTwoArray;
    BOOL            btnIsLight;
    NSInteger       _page;
    BOOL            _isPulling;
    
}
@property(nonatomic, strong)UIButton *btnSelected;
@end

@implementation SecondVC

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = NO;
    [self createData];
    [self createTwoData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    _dataTwoArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTopView];
    [self initMainScrollView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak SecondVC *weakSelf = self;
    if (_firstView) {
        _firstView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createData];
        }];
    }
    if (_secondView){
        _secondView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createTwoData];
        }];
    }
}
//上拉加载
- (void)updown {
    __weak SecondVC *weakSelf = self;
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
    if (_secondView){
        _secondView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_secondView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createTwoData];
             }
        }];
    }
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_ChatGroupsQuery success:^(id responseObject) {
//        if (_isPulling || Manager.IsListPulling == 3) {
            [_dataArray removeAllObjects];
//            Manager.IsListPulling = 0;
//        }
        
//        NSLog(@"群组信息%@",responseObject);
        NSDictionary *RootDic =[responseObject objectForKey:@"data"];
        NSArray *ARr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dic in ARr) {
            NSDictionary *SuDic = [Dic objectForKey:@"chatGroup"];
            SecondModel *Model = [[SecondModel alloc]init];
            [Model setDic:SuDic];
            [_dataArray addObject:Model];
        }
        if (_isPulling) {
            [_firstView.mj_header endRefreshing];
        }else{
            [_firstView.mj_footer endRefreshing];
        }
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTwoData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"type":@1,@"page":[NSString stringWithFormat:@"%ld",_page]} url:UrL_FriendQuery success:^(id responseObject) {
//        if (_isPulling) {
            [_dataTwoArray removeAllObjects];
//        }
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        NSArray *arr = [Dict objectForKey:@"iData"];
        for (NSDictionary *dict in arr) {
            FriendDanChatModel *Model =[[FriendDanChatModel alloc]init];
            [Model setDic:dict];
            [_dataTwoArray addObject:Model];
        }
        if (_isPulling) {
            [_secondView.mj_header endRefreshing];
        }else{
            [_secondView.mj_footer endRefreshing];
        }
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}


-(void)initMainScrollView
{
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_topView.frame)-44)];
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag = 10;
    _firstView.delegate = self;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator = NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag = 11;
    _secondView.delegate = self;
    _secondView.dataSource = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator = NO;
    _mainScrollView.contentSize = CGSizeMake(width*2, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [self.view addSubview:_mainScrollView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 10) {
        return _dataArray.count;
    }else if (tableView.tag == 11){
        return _dataTwoArray.count;
    }
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    FbwManager *Manager = [FbwManager shareManager];
    if (tableView.tag == 10){
        SecondModel *Model = _dataArray[indexPath.section];
        NSLog(@"群组Id%@",Model.SecondId);
        ChatWithFriendVc *chat = [[ChatWithFriendVc alloc]init];
        chat.conversationType = ConversationType_GROUP;
        chat.targetId = Model.SecondId;//单聊对方ID
        chat.QuTitle = @"Qun";
        chat.NavTitleStr = Model.SecondName;
        chat.GroupId = Model.SecondId;
        [self.navigationController pushViewController:chat animated:YES];
    }else if (tableView.tag == 11) {
        FriendDanChatModel *Model = _dataTwoArray[indexPath.section];
        ChatWithFriendVc *chat = [[ChatWithFriendVc alloc]init];
        chat.conversationType = ConversationType_PRIVATE;
        chat.targetId = Model.FriendDanChatId; //Manager.UUserId;//[defaults objectForKey:@"UserId"];//Model.FriendDanChatId;//单聊对方ID
        chat.UserInfoId = Model.FriendDanChatId;
        chat.QuTitle = @"Dan";
        chat.NavTitleStr = Model.FriendDanChatNickName;
        [self.navigationController pushViewController:chat animated:YES];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        return 80;
    }else if (tableView.tag == 11){
        return 80;
    }
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ck"];
        if (!cell) {
            cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CK"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        SecondModel *Model = _dataArray[indexPath.section];
        [cell configWith:Model];
        return cell;
    }else if (tableView.tag == 11){
        
        FriendDanChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Jack"];
        if (!cell) {
            cell = [[FriendDanChatCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Jack"];
        }
        FriendDanChatModel *Model = _dataTwoArray[indexPath.section];
        [cell configWith:Model];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Rose"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Rose"];
    }
    return cell;

}


-(void)createTopView
{
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,40)];
    _topView.backgroundColor = kAppWhiteColor;
    UIButton *BtnSJ = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 40)];
    [BtnSJ setTitle:@"群组" forState:UIControlStateNormal];
    BtnSJ.tag = 11;
    [BtnSJ setTitleColor:kAppBlueColor forState:UIControlStateSelected];
    [BtnSJ addTarget:self action:@selector(BtnSJ:) forControlEvents:UIControlEventTouchUpInside];
    [BtnSJ setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    BtnSJ.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    UIButton *BtnXJ = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2,0, kScreenWidth/2, 40)];
    [BtnXJ setTitle:@"好友" forState:UIControlStateNormal];
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
-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 45)/2, 10, 70, 30)];
    label.text = @"交流圈";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 70, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setTitle:@"创建群组" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BtnQunClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    [button2 setImage:[UIImage imageNamed:@"系统消息@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnMessClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BtnQunClick:(UIButton *)btn
{
    //NSLog(@"1");
    CreateGroupVC *group = [[CreateGroupVC alloc]init];
    [self.navigationController pushViewController:group animated:YES];
}

//上下架
-(void)BtnSJ:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 11) {
        btnSJ.selected = YES;
        [_dataArray removeAllObjects];
        [self createData];
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else
    {
        btnSJ.selected = YES;
        [_dataTwoArray removeAllObjects];
        [self createTwoData];
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }
    
    self.btnSelected = btnSJ;
}

-(void)BtnMessClick:(UIButton *)MessBtn
{
    FriendsNoticeVC *notice = [[FriendsNoticeVC alloc]init];
    [self.navigationController pushViewController:notice animated:YES];
}

@end
