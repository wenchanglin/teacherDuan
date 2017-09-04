//
//  UseHelp.m
//  ShangKTeacher
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "UseHelp.h"
#import "AppDelegate.h"

@interface UseHelp ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *mylabel;
}
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation UseHelp
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
    [self creattableview];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)creattableview
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight+100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"legalecell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
    }
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"法律声明hhd.png"]];
    icon.frame = CGRectMake(120, 15,  kScreenWidth-240, 55);
    
    UILabel *ShiYLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/2)/2, CGRectGetMaxY(icon.frame)+10, kScreenWidth/2, 20)];
    ShiYLabel.text = @"上课呗教师端使用说明";
    ShiYLabel.textAlignment = NSTextAlignmentCenter;
    ShiYLabel.font = [UIFont boldSystemFontOfSize:16];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > screenSize.width) {
            if (screenSize.height == 568) {
                mylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(ShiYLabel.frame)-10, kScreenWidth-20, kScreenHeight)];
            }else{
            mylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(ShiYLabel.frame)-40, kScreenWidth-20, kScreenHeight)];
            }
        }
    }
    mylabel.numberOfLines = 0;
    mylabel.lineBreakMode = NSLineBreakByWordWrapping;
    mylabel.text = @"上课呗为全国的线下实体的中小培训机构、学生、学生家长提供互联网+教育的教育平台，将在全国600多个城市开展教育平台服务。\n\n教师端的作用：学生作业发布与作业评价、聊天交流、在线教育、在线教育商城。（教师端的帐号密码均由机构端创建，教师端无修改密码的权限）\n\n在线教育：如果您有教学视频要在全国售卖或分享，可以免费注册帐号即可成为在线教育的卖家。（免费在线教育入驻请登陆官网www.skbjypt.com）\n\n在线商城：如果您有商品想在全国售卖，可以免费注册帐号，即可成为在线商城的卖家。（免费在线商城入驻请登陆官网www.skbjypt.com）\n\n1、通过官网观看教学视频，所有的功能在官网上都有详细的视频操作介绍（官网：www.skbjypt.com）\n\n2、通过QQ客服咨询（QQ:3410933974）\n\n3、通过微信客服咨询（客服微信：skb-kf）\n\n4、通过电话咨询（客服电话：18616610235）";
    [cell.contentView addSubview:icon];
    [cell.contentView addSubview:ShiYLabel];
    [cell.contentView addSubview:mylabel];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label    = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 90)/2, 10, 90, 30)];
    label.text        = @"使用说明";
    label.textAlignment = NSTextAlignmentCenter;
    label.font        = [UIFont boldSystemFontOfSize:16];
    label.textColor   = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame     = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaBtnlick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)BaBtnlick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
