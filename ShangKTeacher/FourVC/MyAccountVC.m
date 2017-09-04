//
//  MyAccountVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyAccountVC.h"
#import "AppDelegate.h"
#import "WithdrawalsVC.h"
#import "FinancialDetailsVC.h"
@interface MyAccountVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_TableView;
    NSString    *AccountMoney;
}
@end

@implementation MyAccountVC
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
    [self createNav];
    [self createData];
    self.view.backgroundColor = kAppWhiteColor;
    
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId} url:UrL_MyAccount success:^(id responseObject) {
        NSDictionary *Dict = [responseObject objectForKey:@"data"];
        AccountMoney = [Dict objectForKey:@"balance"];
        NSLog(@"钱呢%@",AccountMoney);
        [self createTableView];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.scrollEnabled = NO;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _TableView.tableHeaderView = [self createHeadView];
    [self.view addSubview:_TableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        WithdrawalsVC *drawals = [[WithdrawalsVC alloc]init];
        drawals.MoneyNum = AccountMoney;
        [self.navigationController pushViewController:drawals animated:YES];
    }else{
        FinancialDetailsVC *Details =[[FinancialDetailsVC alloc]init];
        [self.navigationController pushViewController:Details animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"提现",@"资金明细"];
    NSArray *PicAr = @[@"图层-72@2x_91.png",@"账户明细@2x.png"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YuE"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"YuE"];
    }
    cell.textLabel.text = arr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:PicAr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(UIView *)createHeadView
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 180)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIImageView *HeadImage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-70)/2, 30, 70, 70)];
    HeadImage.image = [UIImage imageNamed:@"图层-60@2x_70.png"];
    UILabel *YuELabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-80)/2, CGRectGetMaxY(HeadImage.frame)+15, 80, 20)];
    YuELabel.text = @"账户余额";
    YuELabel.font = [UIFont systemFontOfSize:18];
    UILabel *PriceLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120)/2, CGRectGetMaxY(YuELabel.frame)+5, 120, 30)];
    PriceLabel.text = [NSString stringWithFormat:@"¥%@",AccountMoney];
    PriceLabel.textAlignment = NSTextAlignmentCenter;
    PriceLabel.font = [UIFont boldSystemFontOfSize:22];
    
    [HeadView addSubview:PriceLabel];
    [HeadView addSubview:YuELabel];
    [HeadView addSubview:HeadImage];
    return HeadView;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"我的账户";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)click:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
