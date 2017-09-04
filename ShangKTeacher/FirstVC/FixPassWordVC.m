//
//  FixPassWordVC.m
//  ShangKTeacher
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FixPassWordVC.h"
#import "basicTextField.h"
#import "LoginVC.h"
@interface FixPassWordVC ()

@end

@implementation FixPassWordVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kAppWhiteColor;
    [self createNav];
    [self createUI];
    
}

-(void)createUI
{
    NSArray *arr = @[@"请输入当前密码",@"请输入新密码",@"请确认新密码"];
    for (int i=0; i<3; i++) {
        basicTextField *textField       = [[basicTextField alloc]initWithFrame:CGRectMake(20, 100+i*60, kScreenWidth - 40, 40)];
        [textField leftViewRectForBounds:CGRectMake(-20, 0, 20, 25)];
        textField.backgroundColor    = kAppWhiteColor;
        textField.tag                = 100+i;
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        textField.layer.borderWidth  = 0.4;
        textField.layer.cornerRadius = 20;
        textField.enabled            = true;
        textField.placeholder        = arr[i];
        textField.layer.borderColor  = kAppLineColor.CGColor;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *PIc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 25)];
        PIc.image = [UIImage imageNamed:@"图层-46@2x_68.png"];
        textField.leftView           = PIc;
        textField.leftViewMode       = UITextFieldViewModeAlways;
        
        [self.view addSubview:textField];
    }
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LoginBtn.backgroundColor    = kAppBlueColor;
    LoginBtn.layer.borderWidth  = 0.1;
    LoginBtn.layer.cornerRadius = 20;
    LoginBtn.frame = CGRectMake(20, kScreenHeight/2+60, kScreenWidth-40, 40);
    [LoginBtn setTitle:@"确定" forState:UIControlStateNormal];
    [LoginBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    [LoginBtn addTarget:self action:@selector(LoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:LoginBtn];
}

-(void)LoginBtn:(UIButton *)loginBtn
{
    NSLog(@"确定");
    __weak typeof(self) weakSelf = self;
    NSUserDefaults *defaults        = [NSUserDefaults standardUserDefaults];
    UITextField *OldTextField       = [self.view viewWithTag:100];
    UITextField *NewTextField       = [self.view viewWithTag:101];
    NSLog(@"看看userName%@",[defaults objectForKey:@"UinfoUser"]);
    UITextField *QueRenNewPasswordTextField = [self.view viewWithTag:102];
    if ([NewTextField.text isEqualToString:QueRenNewPasswordTextField.text]) {
        if (NewTextField.text.length > 5) {
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userName":[defaults objectForKey:@"UinfoUser"],@"roleType":@"teacher",@"newPassword":NewTextField.text,@"oldPassword":OldTextField.text} url:UrL_NewPassWord success:^(id responseObject) {
            if ([[responseObject objectForKey:@"msg"]isEqualToString:@"验证失败"]||[[responseObject objectForKey:@"msg"]isEqualToString:@"用户不存在"]||[[responseObject objectForKey:@"msg"]isEqualToString:@"旧密码不正确"]) {
//                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
            }else{
//                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//                [weakSelf.navigationController popViewControllerAnimated:YES];
                LoginVC *login = [[LoginVC alloc]init];
//                MAnager.FirstIsLogin = @"NO";
                [weakSelf.navigationController pushViewController:login animated:YES];
            }
        } failure:^(NSError *error) {
        }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入六位以上密码"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 110)/2, 10, 110, 30)];
    label.text = @"修改登录密码";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(klick) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)klick
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
