//
//  LoginVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "basicTextField.h"
#import "RootVC.h"
#import <RongIMKit/RongIMKit.h>
@interface LoginVC ()<RCIMUserInfoDataSource>
{
    NSString *_token;
}
@end

@implementation LoginVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    [self createView];
    self.view.backgroundColor = kAppBlackColor;
}

-(void)createView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/4.7)/2, kScreenHeight/7.5, kScreenWidth/4.7, kScreenWidth/4.7)];
    imageView.image = [UIImage imageNamed:@"teacher-1副本Y.png"];
    UILabel *DuanLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-kScreenWidth/4.7)/2+(kScreenWidth/4.7-80)/2, CGRectGetMaxY(imageView.frame)+10, 80, 20)];
    DuanLabel.text = @"(教师端)";
    DuanLabel.textAlignment = NSTextAlignmentCenter;
    DuanLabel.font = [UIFont boldSystemFontOfSize:18];
    DuanLabel.textColor = kAppWhiteColor;
    NSArray *arr = @[@"请输入您的账号",@"请输入您的密码"];
    NSArray *PicArr = @[@"图层-47@2x.png",@"图层-46@2x.png"];
    for (int i=0; i<2; i++) {
        basicTextField *textField       = [[basicTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(DuanLabel.frame)+20+i*60, kScreenWidth - 40, 40)];
        [textField leftViewRectForBounds:CGRectMake(-20, 0, 20, 25)];
        textField.backgroundColor    = kAppWhiteColor;
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        textField.layer.borderWidth  = 0.1;
        textField.layer.cornerRadius = 20;
        textField.tag                = 100+i;
        if (textField.tag == 101) {
            textField.secureTextEntry = YES;
        }
        textField.enabled            = true;
        textField.placeholder        = arr[i];
        textField.layer.borderColor  = kAppWhiteColor.CGColor;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *PIc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 25)];
        PIc.image = [UIImage imageNamed:PicArr[i]];
        textField.leftView           = PIc;
        textField.leftViewMode       = UITextFieldViewModeAlways;
        
        [self.view addSubview:textField];
    }
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LoginBtn.backgroundColor    = kAppBlueColor;
    LoginBtn.layer.borderWidth  = 0.1;
    LoginBtn.layer.cornerRadius = 20;
    LoginBtn.frame = CGRectMake(20, kScreenHeight/2+60, kScreenWidth-40, 40);
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(LoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    
    [self.view addSubview:imageView];
    [self.view addSubview:DuanLabel];
    [self.view addSubview:LoginBtn];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)LoginBtn:(UIButton *)Login
{
    FbwManager *Manager = [FbwManager shareManager];
    UITextField *UserNameTextField     = [self.view viewWithTag:100];
    UITextField *UserPassWordTextField = [self.view viewWithTag:101];
    NSLog(@"登录");
    __weak typeof(self) weakSelf = self;
    if (UserNameTextField.text.length  != 0) {
        if (UserPassWordTextField.text.length != 0) {
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userName":UserNameTextField.text,@"roleType":@"teacher",@"password":UserPassWordTextField.text} url:UrL_Login success:^(id responseObject) {
                if ([[responseObject objectForKey:@"errcode"]integerValue] != 0) {
                    [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
                }else{
                    RootVC *firsr = [[RootVC alloc]init];
                    NSDictionary *rootDic = [responseObject objectForKey:@"data"];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:@"YES"  forKey:@"isLogin"];
                    Manager.UUserId = [rootDic objectForKey:@"id"];
                    [defaults setObject:[rootDic objectForKey:@"id"] forKey:@"UserID"];
                    [defaults setObject:[rootDic objectForKey:@"intro"] forKey:@"UserIntro"];
                    [defaults setObject:[rootDic objectForKey:@"phone"] forKey:@"UserPhone"];
                    [defaults setObject:[rootDic objectForKey:@"sex"] forKey:@"UserSex"];
                    [defaults setObject:[rootDic objectForKey:@"username"] forKey:@"UinfoUser"];
                    
                    [UIView animateWithDuration:2 animations:^{
                        weakSelf.view.alpha = 0;
                    } completion:^(BOOL finished) {
                        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                        delegate.window.rootViewController = firsr;
                    }];
                    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId} url:UrL_SearchTeacher success:^(id responseObject) {
                        NSLog(@"看看%@",responseObject);
                        NSDictionary *rootTDic = [responseObject objectForKey:@"data"];
                        NSString *OrgName   = rootTDic[@"userInfoOrg"][@"userBase"][@"nickName"];
                        NSLog(@"这是%@",OrgName);
                        NSDictionary *diTct = [rootTDic objectForKey:@"userInfoBase"];
                        [defaults setObject:[diTct objectForKey:@"userPhotoHead"]forKey:@"UserPhoto"];
                        [defaults setObject:[diTct objectForKey:@"nickName"]forKey:@"UserNickName"];
//                        [defaults setObject:[diTct objectForKey:@"username"] forKey:@"UinfoUser"];
                        [defaults setObject:OrgName forKey:@"OrgName"];
                        [defaults synchronize];
                        [weakSelf getRongyunToken];
                    } failure:^(NSError *error) {
                        
                    }];
                }
            } failure:^(NSError *error) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入您的密码"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入您的账号"];
    }

}

#pragma mark - 获取融云token
//获取融云token
- (void)getRongyunToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@..%@.",[defaults objectForKey:@"UserID"],[defaults objectForKey:@"UserNickName"]);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":[defaults objectForKey:@"UserID"],@"name":[defaults objectForKey:@"UserNickName"],@"portraitUri":@""} url:UrL_GetRongYunToken success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        _token = RootDic[@"token"];//获取返回的token
        NSLog(@"token%@",_token);
//        初始化融云
        [[RCIM sharedRCIM] initWithAppKey:@"ik1qhw091hubp"];
//        [[RCIMClient sharedRCIMClient]initWithAppKey:@"n19jmcy5nirn9"];//mgb7ka1nbmxug
        [[RCIM sharedRCIM] connectWithToken:_token success:^(NSString *userId) {
            //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            NSLog(@"Login successfully with userId: %@.", userId);
            
        } error:^(RCConnectErrorCode status) {
            NSLog(@"login error status: %ld.", (long)status);
        } tokenIncorrect:^{
            NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
        }];
    } failure:^(NSError *error) {
    }];
}

@end
