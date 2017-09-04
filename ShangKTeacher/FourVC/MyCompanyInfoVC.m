//
//  MyCompanyInfoVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyCompanyInfoVC.h"
#import "AppDelegate.h"
#import "CompanyCell.h"
#import "SecondInfoCell.h"
#import <TZImagePickerController.h>
@interface MyCompanyInfoVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,TZImagePickerControllerDelegate>
{
    UITableView *_TableView;
    NSMutableArray *_FirstArray;
    NSMutableArray *_SecondArray;
    NSMutableArray *_selectedPhotos;
    UITextField *_NickNameTextField;
    UITextField *_PhoneTextField;
    UITextField *_SexTextField;
    UITextField *_AgeTextField;
    UIButton    *button2;
    UIView      *NavBarview;
    NSString    *SexStr;
    SecondInfoCell *Xcell;
    CompanyCell *Ocell;
}
@property(nonatomic,strong)UILabel    * firstPlaceLabel;
@end

@implementation MyCompanyInfoVC
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
    _selectedPhotos = [NSMutableArray array];
    _FirstArray = [NSMutableArray array];
    _SecondArray = [NSMutableArray array];
    _NickNameTextField = [[UITextField alloc]init];
    _PhoneTextField = [[UITextField alloc]init];
    _SexTextField = [[UITextField alloc]init];
    _AgeTextField = [[UITextField alloc]init];
    [self createNav];
    self.view.backgroundColor = kAppWhiteColor;
    [self createTableView];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-100) style:UITableViewStyleGrouped];
    _TableView.delegate   = self;
    _TableView.scrollEnabled = YES;
    _TableView.dataSource = self;
    [self.view addSubview:_TableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 3;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&&indexPath.row == 0) {
        return 90;
    }else if (indexPath.section == 1 && indexPath.row ==2) {
        return 280;
    }
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"头像",@"昵称",@"手机号"];
    NSArray *Info = @[self.UserNickName,self.UserPhone];
    if(indexPath.section == 0){
    Ocell = [tableView dequeueReusableCellWithIdentifier:@"Kinfo"];
    if (!Ocell) {
        Ocell = [[CompanyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Kinfo"];
    }
        if (indexPath.row == 0) {
            Ocell.TitleLabel.text = arr[0];
            [Ocell.HeadPic setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.UserImage]]];
            [Ocell.HeadPic addTarget:self action:@selector(PicUserInfo:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            Ocell.TitleLabel.text = arr[indexPath.row];
            Ocell.InfoLabel.text  = Info[indexPath.row-1];
            Ocell.InfoLabel.delegate = self;
            Ocell.InfoLabel.userInteractionEnabled = NO;
            [_FirstArray addObject:Ocell.InfoLabel];
        }
        [Ocell.contentView addSubview:Ocell.HeadPic];
    return Ocell;
    }
    NSArray *ar = @[@"性别",@"年龄"];
    
    if (self.UserSex == 0) {
        SexStr = @"女";
    }else{
       SexStr = @"男";
    }
    NSInteger Age = self.UserAge;
    NSArray *inAr = @[SexStr,[NSString stringWithFormat:@"%ld",(long)Age]];
    Xcell = [tableView dequeueReusableCellWithIdentifier:@"Info"];
    if (!Xcell) {
        Xcell = [[SecondInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Info"];
    }
    if (indexPath.row == 2) {
        Xcell.SecThirdTitle.text = @"个人简介";
        Xcell.SecInfo.tag = 110;
        _firstPlaceLabel = Xcell.activityName;
        Xcell.SecInfo.delegate = self;
        Xcell.SecInfo.text = self.UserIntro;
        Xcell.SecInfo.userInteractionEnabled = NO;
        [Xcell.contentView addSubview:Xcell.SecInfo];
//        [Xcell.contentView addSubview:Xcell.activityName];
    }else{
        Xcell.SecTitleLabel.text = ar[indexPath.row];
        Xcell.SecInfoLabel.text  = inAr[indexPath.row];
        Xcell.SecInfoLabel.delegate = self;
        Xcell.SecInfoLabel.userInteractionEnabled = NO;
        [_SecondArray addObject:Xcell.SecInfoLabel];
    }
    return Xcell;
}

#pragma mark - textView 代理
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        switch (textView.tag) {
            case 110:
            {
                _firstPlaceLabel.text = @"";
            }
                break;
            default:
                break;
        }
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        switch (textView.tag) {
            case 110:
            {
                _firstPlaceLabel.text = @"请输入个人简介...";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

-(void)PicUserInfo:(UIButton *)Pic
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
        _selectedPhotos = [NSMutableArray arrayWithArray:photos];
        NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
        [Pic setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}

#pragma mark - textField 代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)createNav
{
    
    NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"个人信息";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    [button2 setTitle:@"修改" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:self action:@selector(BtnMessClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}
//编辑
-(void)BtnMessClick:(UIButton *)BtnMess
{
    button2.hidden = YES;
    UITextField *text1 = _FirstArray[0];
    UITextField *text2 = _FirstArray[1];
    UITextField *text3 = _SecondArray[0];
    UITextField *text4 = _SecondArray[1];
    Xcell.SecInfo.text = @"";
    Xcell.SecInfo.userInteractionEnabled = YES;
    text1.userInteractionEnabled = YES;
    text2.userInteractionEnabled = YES;
    text3.userInteractionEnabled = YES;
    text4.userInteractionEnabled = YES;
    [Xcell.contentView addSubview:Xcell.activityName];
    BtnMess = [UIButton buttonWithType:UIButtonTypeCustom];
    BtnMess.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
    BtnMess.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [BtnMess setTitle:@"保存" forState:UIControlStateNormal];
    [BtnMess addTarget:self action:@selector(BtnBaCunClick:) forControlEvents:UIControlEventTouchUpInside];
    [NavBarview addSubview:BtnMess];
}

-(void)BtnBaCunClick:(UIButton *)Bt
{
    UITextView *textView = [self.view viewWithTag:110];
    FbwManager *Manager = [FbwManager shareManager];
   
    _NickNameTextField = _FirstArray[0];
    _PhoneTextField = _FirstArray[1];
    _SexTextField = _SecondArray[0];
    _AgeTextField = _SecondArray[1];
     NSLog(@"%@ %@ %@ %@",_NickNameTextField.text,_PhoneTextField.text,_SexTextField.text,_AgeTextField.text);
    __weak typeof(self) weakSelf = self;
    if (_NickNameTextField.text.length != 0) {
        if (_PhoneTextField.text.length   != 0) {
            if (_SexTextField.text.length   != 0) {
                if (_AgeTextField.text.length != 0) {
                    if (textView.text.length    != 0) {
                        NSInteger GT;
                        if ([_SexTextField.text isEqualToString:@"男"]) {
                            GT = 1;
                        }else if ([_SexTextField.text isEqualToString:@"女"]){
                            GT = 2;
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"请输入正确的性别"];
                        }
                        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId,@"nickName":_NickNameTextField.text,@"sex":[NSString stringWithFormat:@"%ld",(long)GT],@"age":_AgeTextField.text,@"phone":_PhoneTextField.text,@"intro":textView.text} url:UrL_UpdataTeacherInfo success:^(id responseObject) {
                            NSLog(@"信息修改%@",responseObject);
                            if (_selectedPhotos.count != 0) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [SVProgressHUD showWithStatus:@"上传中"];
                                    NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
                                    NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"imageUserPhotoHead",@"fkPurposeId":Manager.UUserId};
                                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                    [manager POST:UrL_UploadFile
                                       parameters:Dict
                                       constructingBodyWithBlock:
                                     ^(id<AFMultipartFormData>_Nonnull formData) {
                                         [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"imageUserPhotoHead.png" mimeType:@"image/png"];
                                          } progress:nil
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              [SVProgressHUD dismiss];
                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                              
                                              NSLog(@"图片上传成功啦");
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              NSLog(@"图片上传失败啦");
                                          }];
                                });
                            }else{
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            }
                            
                        } failure:^(NSError *error) {
                        }];
                        
                      }else{
                        [SVProgressHUD showErrorWithStatus:@"请输入个人简介"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请输入年龄"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请输入性别"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
    }
}

-(void)BaCklick:(UIButton *)BaBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
