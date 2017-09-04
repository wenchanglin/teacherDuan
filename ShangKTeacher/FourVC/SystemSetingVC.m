//
//  SystemSetingVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SystemSetingVC.h"
#import "AppDelegate.h"
#import "LoginVC.h"
#import "FixPassWordVC.h"
#import "ArrowView.h"
#import "FeedBackVC.h"
#import "AboutUS.h"
#import <SDWebImageManager.h>
#import "ContactCustomerService.h"
#import "FALViewC.h"
#import "UseHelpVC.h"
@interface SystemSetingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_dataArr;
    NSArray *_GtrArr;
    NSArray *_DetailText;
    ArrowView    * _arrowView;
    NSInteger  _ClashNum;
}
@end

@implementation SystemSetingVC
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
     _DetailText = [NSArray array];
    [self createTableView];
   
    _dataArr = [NSArray array];
    _GtrArr  = [NSArray array];
    _dataArr = @[@"使用帮助",@"联系客服",@"关于我们"];
    _GtrArr  = @[@"意见反馈",@"法律声明",@"清除缓存"];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        _ClashNum = (unsigned long)[files  count];
        //        NSLog(@"我就看看你多大%ld",_ClashNum);
        _DetailText = @[@"",@"",[NSString stringWithFormat:@"%ldK",(long)_ClashNum]];
    });
    [self.view addSubview:_tableView];
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 3;
    }else if(section == 2){
        return 3;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSLog(@"修改登录密码");
        FixPassWordVC *FixPass = [[FixPassWordVC alloc]init];
        [self.navigationController pushViewController:FixPass animated:YES];
    }else if (indexPath.section == 1&& indexPath.row == 0) {
        NSLog(@"使用帮助");
        UseHelpVC *UserH = [[UseHelpVC alloc]init];
        [self.navigationController pushViewController:UserH animated:YES];
    }else if (indexPath.section == 1&& indexPath.row == 1){
        NSLog(@"联系客服");
        ContactCustomerService *Service = [[ContactCustomerService alloc]init];
        [self.navigationController pushViewController:Service animated:YES];
    }else if (indexPath.section == 1&& indexPath.row == 2){
        NSLog(@"关于我们");
        AboutUS *about = [[AboutUS alloc]init];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.section == 2&& indexPath.row == 0){
        NSLog(@"意见反馈");
        FeedBackVC *Feed = [[FeedBackVC alloc]init];
        [self.navigationController pushViewController:Feed animated:YES];
    }else if (indexPath.section == 2&& indexPath.row == 1){
        NSLog(@"法律声明");
        FALViewC *Fal = [[FALViewC alloc]init];
        [self.navigationController pushViewController:Fal animated:YES];
    }else if (indexPath.section == 2&& indexPath.row == 2){
        NSLog(@"清楚缓存");
        __weak typeof(self) weakSelf = self;
        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
        [_arrowView setBackgroundColor:[UIColor clearColor]];
        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定清楚缓存？"];
        [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
            }else if (button.tag == 11){
                [weakSelf clearCache];
                [SVProgressHUD showSuccessWithStatus:@"清理成功"];
                [weakSelf createTableView];
            }
        
        }];
        [weakSelf createTableView];
        [weakSelf.tableView reloadData];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];
    }else if (indexPath.section == 3&& indexPath.row == 0){
        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
        [_arrowView setBackgroundColor:[UIColor clearColor]];
        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"您确定要退出吗？"];
        __weak typeof(self) weakSelf = self;
        [_arrowView setSelectBlock:^(UIButton *button){
            if (button.tag == 10) {
            }else if (button.tag == 11){
                LoginVC *login = [[LoginVC alloc]init];
                [NSUserDefaults standardUserDefaults];
                [weakSelf.navigationController pushViewController:login animated:YES];
            }
        }];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
        [_arrowView showArrowView:YES];
    }
}

//-(void)hsUpdateApp
//{
//    //2先获取当前工程项目版本号
//    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
//
//    //3从网络获取appStore版本号
//    NSError *error;
//    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
//    if (response == nil) {
//        NSLog(@"你没有连接网络哦");
//        return;
//    }
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    if (error) {
//        NSLog(@"hsUpdateAppError:%@",error);
//        return;
//    }
//    NSArray *array = appInfoDic[@"results"];
//    NSDictionary *dic = array[0];
//    NSString *appStoreVersion = dic[@"version"];
//    //打印版本号
//    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
//    //4当前版本号小于商店版本号,就更新
//    if([currentVersion floatValue] < [appStoreVersion floatValue])
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
//        [alert show];
//    }else{
//        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
//    }
//}
//
//- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    //5实现跳转到应用商店进行更新
//    if(buttonIndex==1)
//    {
//        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
//        [[UIApplication sharedApplication] openURL:url];
//    }
//

-(void)clearCache
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[ NSFileManager defaultManager ]  subpathsAtPath :cachPath];
        NSLog ( @"files :%lu" ,(unsigned long)[files  count ]);
        for (NSString * p in files)
        {
            NSError * error;
            NSString * path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    });
    [SVProgressHUD showWithStatus:@"清理中"];
    [self.tableView reloadData];
    [self createTableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatIn"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ChatIn"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"修改登录密码";
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = _dataArr[indexPath.row];
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = _GtrArr[indexPath.row];
        if (_DetailText.count != 0) {
            cell.detailTextLabel.text = _DetailText[indexPath.row];
        }else{
        }
    }
    if (indexPath.section == 3) {
        cell.textLabel.text = @"退出登录";
    }
    
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"系统设置";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaKclick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BaKclick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
