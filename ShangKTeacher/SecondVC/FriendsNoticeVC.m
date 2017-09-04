//
//  FriendsNoticeVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendsNoticeVC.h"
#import "AppDelegate.h"
#import "FriendNoFirstCell.h"
#import "FirendNoSecondCell.h"
#import "FriendsNoticeModel.h"
@interface FriendsNoticeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation FriendsNoticeVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    [self createTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    NSLog(@"你看呗%@",Manager.UUserId);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"myUserBaseId":Manager.UUserId} url:UrL_FriendMessageCenter success:^(id responseObject) {
        NSLog(@"你瞧%@",responseObject);
        [_dataArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in Arr) {
            FriendsNoticeModel *Model = [[FriendsNoticeModel alloc]init];
            [Model setDic:Dict];
            [_dataArray addObject:Model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    NSLog(@"你说好不好啊");
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
    FriendsNoticeModel *Model = _dataArray[indexPath.section];
    if (Model.FriendsMessageStatus == 1) {
        return 170;
    }else{
        return 120;
    }
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
    FriendsNoticeModel *Model = _dataArray[indexPath.section];
    NSLog(@"积极%ld",(long)Model.FriendsMessageStatus);
    if (Model.FriendsMessageStatus == 1) {
        FriendNoFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoFir"];
        if (!cell) {
            cell = [[FriendNoFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoFir"];
        }
        NSArray *arr = @[@"拒绝",@"同意"];
        for (int i=0; i<2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = indexPath.section;
            button.frame = CGRectMake((kScreenWidth-(kScreenWidth/5)*2)/3+i*(kScreenWidth/5)*2, 90, kScreenWidth/5, 30);
            [button setTitle:arr[i] forState:UIControlStateNormal];
            if ([button.titleLabel.text isEqualToString:@"拒绝"]) {
                button.backgroundColor = kAppGrayColor;
            }else{
                button.backgroundColor = kAppBlueColor;
            }
            [button setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(BTNFF:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configWith:Model];
        return cell;
    }else{
        FirendNoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatInfo"];
        if (!cell) {
            
            cell = [[FirendNoSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatInfo"];
            [cell configWith:Model];
        }
        return cell;
    }
}
-(void)BTNFF:(UIButton *)btn
{
    FriendsNoticeModel *Model = _dataArray[btn.tag];
    __weak typeof(self) weakSelf = self;
    if ([btn.titleLabel.text isEqualToString:@"拒绝"]) {
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"makeFriendApplyId":Model.FriendsMessageId,@"result":@3} url:UrL_NoFriend success:^(id responseObject) {
           [weakSelf createData];
        } failure:^(NSError *error) {
        }];
    }else{
        NSLog(@"同意");
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"makeFriendApplyId":Model.FriendsMessageId,@"result":@2} url:UrL_NoFriend success:^(id responseObject) {
         [weakSelf createData];
        } failure:^(NSError *error) {
        }];
        //        [self createTableView];
//        [_tableView reloadData];
    }
}

-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"好友通知";
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
@end
