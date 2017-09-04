//
//  WithdrawalsVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "WithdrawalsVC.h"
#import "AppDelegate.h"
#import "ZhiFuBaoCell.h"
#import "ZFBFirstCell.h"
#import "YinHangKaFirstCell.h"
#import "YHKSecondCell.h"
#import "TePopList.h"

@interface WithdrawalsVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView       * _topView;
    UIScrollView * _mainScrollView;
    UITableView  * _firstView;
    UITableView  * _secondView;
    UITextField  * _ZFBCardNum;
    UITextField  * _ZFBName;
    UITextField  * _ZFBMoneyNum;
    UITextField  * _YhkCardNum;
    UITextField  * _YhkName;
    UITextField  * _YhkKaiHuBank;
    UITextField  * _YhkMoneyNum;
    NSMutableArray *_ZfbArr;
    NSMutableArray *_YhkArr;
    NSInteger      _ChooseBank;
    YHKSecondCell  *Xcell;
    NSInteger      selected;
    NSString      *BanKName;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end
@implementation WithdrawalsVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _ZFBCardNum   = [[UITextField alloc]init];
    _ZFBName      = [[UITextField alloc]init];
    _ZFBMoneyNum  = [[UITextField alloc]init];
    _YhkCardNum   = [[UITextField alloc]init];
    _YhkName      = [[UITextField alloc]init];
    _YhkKaiHuBank = [[UITextField alloc]init];
    _YhkMoneyNum  = [[UITextField alloc]init];
    _ZfbArr       = [NSMutableArray array];
    _YhkArr       = [NSMutableArray array];
    selected = 10;
    [self createNav];
    [self createTopView];
    [self initMainScrollView];
}

-(void)initMainScrollView
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_topView.frame))];
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag = 10;
    _firstView.delegate = self;
    _firstView.dataSource = self;
    _firstView.scrollEnabled = NO;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag = 11;
    _secondView.delegate = self;
    _secondView.dataSource = self;
    _secondView.scrollEnabled = NO;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    _mainScrollView.contentSize = CGSizeMake(width*2, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [self.view addSubview:_mainScrollView];
    
    UIButton *BTn       = [UIButton buttonWithType:UIButtonTypeCustom];
    BTn.frame           = CGRectMake(10, kScreenHeight/2+70, kScreenWidth-20, 50);
    BTn.backgroundColor = kAppBlueColor;
    [BTn setTitle:@"提现" forState:UIControlStateNormal];
    [BTn addTarget:self action:@selector(MoneyUserTx:) forControlEvents:UIControlEventTouchUpInside];
    [BTn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    
    [self.view addSubview:BTn];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [textField resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark-------------------------tableview代理---------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        
        if (section == 0) {
            return 1;
        }
        return 3;
    }
    if (section == 0) {
        return 1;
    }
    else if (section == 2){
        return 4;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 10) {
        
        return 2;
    }
    return 3;
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
    NSArray *ZFBarr      = @[@"支付宝号",@"姓名",@"提现金额"];
    NSArray *ZFBPlaceHod = @[@"请输入您的支付宝号",@"请输入您的姓名",@"请输入提现金额"];
    NSArray *YHKBarr     = @[@"银行卡号",@"姓名",@"开户行",@"提现金额"];
    NSArray *YHKPlaceHod = @[@"请输入您的银行卡号",@"请输入您的姓名",@"请输入银行开户行",@"请输入提现金额"];
    if (tableView.tag == 10) {
        if (indexPath.section == 1) {
            ZhiFuBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Kf"];
            if (!cell) {
                cell = [[ZhiFuBaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Kf"];
            }
            if (indexPath.row == 0 || indexPath.row == 2) {
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            }
            cell.ZfbLabel.text         = ZFBarr[indexPath.row];
            cell.textField.placeholder = ZFBPlaceHod[indexPath.row];
            cell.textField.delegate = self;
            [_ZfbArr addObject:cell.textField];
            return cell;
        }
    }
    if (indexPath.section == 2) {
        YinHangKaFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHK"];
        if (!cell) {
            cell = [[YinHangKaFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHK"];
        }
        if (indexPath.row == 0 || indexPath.row == 3) {
            cell.YHKtextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        cell.YHKLabel.text            = YHKBarr[indexPath.row];
        cell.YHKtextField.placeholder = YHKPlaceHod[indexPath.row];
        cell.YHKtextField.delegate = self;
        [_YhkArr addObject:cell.YHKtextField];
        return cell;
    }
    else if (indexPath.section == 1){
        Xcell = [tableView dequeueReusableCellWithIdentifier:@"YHKCell"];
        if (!Xcell) {
            Xcell = [[YHKSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHKCell"];
        }
        Xcell.YHKChooseBank.text = @"请选择银行";
        [Xcell.contentView addSubview:Xcell.YHKChooseBank];
        UIButton *JianTouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [JianTouBtn setBackgroundImage:[UIImage imageNamed:@"图层-69-拷贝@2x.png"] forState:UIControlStateNormal];
        JianTouBtn.frame     = CGRectMake(kScreenWidth - 30, 15, 10, 10);
        [Xcell.contentView addSubview:JianTouBtn];
        return Xcell;
    }
    ZFBFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Huan"];
    if (!cell) {
        cell = [[ZFBFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Huan"];
    }
    cell.JinELabel.text = [NSString stringWithFormat:@"¥%@",self.MoneyNum];
    [cell.contentView addSubview:cell.JinELabel];
    return cell;
}

//提现
-(void)MoneyUserTx:(UIButton *)MoneyBtn
{
    _ZFBCardNum  = _ZfbArr[0];
    _ZFBName     = _ZfbArr[1];
    _ZFBMoneyNum = _ZfbArr[2];
    _YhkCardNum  = _YhkArr[0];
    _YhkName     = _YhkArr[1];
    _YhkKaiHuBank= _YhkArr[2];
    _YhkMoneyNum = _YhkArr[3];
    FbwManager *Manager = [FbwManager shareManager];
    NSLog(@"看看选的%ld",(long)_ChooseBank);
    NSLog(@"卡号%@",_YhkCardNum.text);
    NSLog(@"金额%@",_YhkMoneyNum.text);
    NSLog(@"名字%@",_YhkName.text);
    NSLog(@"开户行%@",_YhkKaiHuBank.text);
    NSLog(@"金额已有%ld",[self.MoneyNum integerValue]);
    if (_ChooseBank == 1) {
        if (_ZFBCardNum.text.length  != 0) {
            if (_ZFBName.text.length    != 0) {
                if (_ZFBMoneyNum.text.length  != 0) {
                    if (self.MoneyNum > 0) {
                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"money":_ZFBMoneyNum.text,@"cashType":@1,@"userAliAccount":_ZFBCardNum.text} url:UrL_MoneyOrder success:^(id responseObject) {
                            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                        } failure:^(NSError *error) {
                        }];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"余额不足"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入支付宝号"];
        }
    }else{
        
        if (_YhkCardNum.text.length  != 0) {
            if (_YhkName.text.length      != 0) {
                if (_YhkKaiHuBank.text.length  != 0) {
                    if (_YhkMoneyNum.text.length   != 0) {
                        if (selected == 0 || selected == 1 || selected == 2) {
                            if (self.MoneyNum > 0) {
                                if (selected == 0) {
                                    BanKName = @"ABC";
                                }else if (selected == 1){
                                    BanKName = @"ICBC";
                                }else if (selected == 2){
                                    BanKName = @"BOC";
                                }
                                NSLog(@"你好好看看%@",BanKName);
                                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"money":_YhkMoneyNum.text,@"cashType":@2,@"userAliAccount":@"",@"bankType":BanKName,@"bankCard":_YhkCardNum.text,@"bankName":_YhkName.text,@"bankAccount":_YhkKaiHuBank.text} url:UrL_MoneyOrder success:^(id responseObject) {
                                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                                    NSLog(@"%@",responseObject);
                                } failure:^(NSError *error) {
                                }];
                            }else{
                                [SVProgressHUD showErrorWithStatus:@"余额不足"];
                            }
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"请选择银行"];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请输入开户行"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入银行卡号"];
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 11) {
    if (indexPath.section == 1) {
        NSLog(@"选择银行");
        TePopList *pop = [[TePopList alloc]initWithListDataSource:@[@"中国农业银行",@"中国工商银行",@"中国银行"] withSelectedBlock:^(NSInteger select) {
            NSLog( @"%li" ,(long)select);
            selected = select;
            if (selected == 0) {
                Xcell.YHKChooseBank.text = @"中国农业银行";
            }else if (selected == 1){
                Xcell.YHKChooseBank.text = @"中国工商银行";
            }else if (selected == 2){
                Xcell.YHKChooseBank.text = @"中国银行";
            }else{
                Xcell.YHKChooseBank.text = @"中国农业银行";
            }
            
          }];
        [pop show];
        [pop selectIndex:selected];
        [_secondView reloadData];
      }
        
   }
    
}

#pragma mark----------------UITextFieldDelegate---------
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)createTopView
{
    _topView        = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,60)];
    _topView.backgroundColor = kAppWhiteColor;
    NSArray *arr    = @[@"支付宝@2x_39.png",@"银行卡@2x.png"];
    NSArray *arrPic = @[@"支付宝@2x.png",@"银行卡@2x_52.png"];
    NSArray *Title  = @[@"支付宝",@"银行卡"];
    for (int i=0; i<2; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i+i*(kScreenWidth-65)/2, 0, (kScreenWidth-65)/2, 60);
        button.tag  = 10+i;
        [button setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:arrPic[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(BtClose:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *ZFLabel = [[UILabel alloc]initWithFrame:CGRectMake(i+120, 25, 60, 10)];
        ZFLabel.text     = Title[i];
        ZFLabel.font     = [UIFont systemFontOfSize:16];
        if (button.tag   == 10) {
            button.selected  = YES;
            _ChooseBank = 1;
            self.btnSelected = button;
        }
        [button addSubview:ZFLabel];
        [_topView addSubview:button];
    }
    [self.view addSubview:_topView];
}

-(void)BtClose:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 10) {
        btnSJ.selected = YES;
        _ChooseBank = 1;
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else
    {
        btnSJ.selected = YES;
        _ChooseBank = 2;
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }
    self.btnSelected = btnSJ;
}


-(void)createNav
{
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 40)/2, 10, 40, 30)];
    label.text = @"提现";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
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
