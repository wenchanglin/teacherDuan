//
//  CreateGroupVC.m
//  ShangKTeacher
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "CreateGroupVC.h"
#import "AppDelegate.h"
#import "CreateGroupFirstCell.h"
#import "CreateGroupSEcCell.h"
#import "FbwManager.h"
#import "CreateGroupThirdCell.h"
#import "CreateGroupFourCell.h"
#import "SetAdministratorVC.h"
#import <TZImagePickerController.h>
@interface CreateGroupVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,TZImagePickerControllerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_selectedPhotos;
    UITextField *_QunNameTit;
    UILabel     *Tbutton;
    UIButton    *button2;
}
@property(nonatomic,strong)UILabel     * firstPlaceLabel;
@end

@implementation CreateGroupVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.TeacherId == nil) {
        Tbutton.text = @"请选择群管理";
    }else{
        Tbutton.text = Manager.TeacherNAme;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedPhotos = [NSMutableArray array];
    _QunNameTit = [[UITextField alloc]init];
    [self createNav];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 1;
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
    if (indexPath.section==0&&indexPath.row==1) {
        return 50;
    }else if (indexPath.section==0&&indexPath.row==2){
        return 120;
    }else if (indexPath.section==1){
        return 50;
    }
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        CreateGroupFirstCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FirCe"];
        if (!cell) {
            cell = [[CreateGroupFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirCe"];
        }
        [cell.GroupFirstPic setBackgroundImage:[UIImage imageNamed:@"我的@2xs副本.png"] forState:UIControlStateNormal];
        [cell.GroupFirstPic addTarget:self action:@selector(TapPicIn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cell.GroupFirstPic];
        
        return cell;
    }else if (indexPath.section==0&&indexPath.row==1){
        CreateGroupSEcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecCe"];
        if (!cell) {
            cell = [[CreateGroupSEcCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecCe"];
        }
        _QunNameTit = cell.GroupInfoRow;
        return cell;
    }else if (indexPath.section==0&&indexPath.row==2){
        CreateGroupThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCe"];
        if (!cell) {
            cell = [[CreateGroupThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdCe"];
        }
        cell.GroupThirdInfoRow.tag = 109;
        cell.GroupThirdInfoRow.delegate  = self;
        _firstPlaceLabel             = cell.activityName;
        return cell;
    }
    CreateGroupFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fill"];
    if (!cell) {
        cell = [[CreateGroupFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Fill"];
    }
    
    UITapGestureRecognizer *TAp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChooseBtn:)];
    Tbutton = [[UILabel alloc]init];
    Tbutton.userInteractionEnabled = YES;
    Tbutton.frame = CGRectMake(kScreenWidth-110, 15, 100, 20);
    FbwManager *Manager = [FbwManager shareManager];
    if (Manager.TeacherId == nil) {
        Tbutton.text = @"请选择群管理";
    }else{
        Tbutton.text = Manager.TeacherNAme;
    }
    Tbutton.font = [UIFont systemFontOfSize:15];
    Tbutton.textColor = kAppBlackColor;
    [Tbutton addGestureRecognizer:TAp];
    [cell.contentView addSubview:Tbutton];
    
    return cell;
}

-(void)TapPicIn:(UIButton *)TAp
{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
        _selectedPhotos = [NSMutableArray arrayWithArray:photos];
        NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
        [TAp setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)ChooseBtn:(UIButton *)bTN
{
//    NSLog(@"选择管理器");
    SetAdministratorVC *administra = [[SetAdministratorVC alloc]init];
    administra.WhereCome = @"SystemQunManager";
    [self.navigationController pushViewController:administra animated:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITextView *tedxt = [self.view viewWithTag:109];
    [tedxt resignFirstResponder];

    [self.view endEditing:YES];
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
            case 109:
            {
                _firstPlaceLabel.text =@"";
            }
                break;
            default:
                break;
        }
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        switch (textView.tag) {
            case 109:
            {
                _firstPlaceLabel.text =@"请输入文字...";
            }
                break;
            default:
                break;
        }
    }
    return YES;
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
    
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"创建群组";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Balick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"保存" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SavingClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
    
}
//保存
-(void)SavingClick:(UIButton *)SaveBtn
{
    FbwManager *Manager = [FbwManager shareManager];
    UITextView *textView = [self.view viewWithTag:109];
    __weak typeof(self) weakSelf = self;
    if (_QunNameTit.text.length != 0) {
        if (textView.text.length    != 0) {
            if (_selectedPhotos.count   != 0) {
                if (![Tbutton.text isEqualToString:@"请选择群管理"]) {
                    button2.userInteractionEnabled = NO;
                    SaveBtn.userInteractionEnabled = NO;
                    NSArray *arr = @[@{@"id":Manager.TeacherId}];//Manager.UserAddAdminId
                    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"教师id%@",jsonStr);
                    NSLog(@"name%@",_QunNameTit.text);
                    NSLog(@"intro%@",textView.text);
                    NSLog(@"%@",Manager.UUserId);
                    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_QunNameTit.text,@"intro":textView.text,@"createUserId":Manager.UUserId,@"administratorsId":jsonStr} url:UrL_ChatGroups success:^(id responseObject) {
                        //                        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                        NSString *STR = [RootDic objectForKey:@"id"];
                        NSLog(@"鸡毛%@",STR);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD showWithStatus:@"上传中"];
                            NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageChatPhoto",
                                                   @"fkPurposeId":STR};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:@"imageChatPhoto.png"
                                                         mimeType:@"image/png"];
                             } progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //                                      [SVProgressHUD showSuccessWithStatus:
                                      //                                       [responseObject objectForKey:@"msg"]];
//                                      
                                      NSLog(@"图片上传成果啦");
                                      [SVProgressHUD dismiss];
                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                    } failure:^(NSError *error) {
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"请选择群管理"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"请选择群头像"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入群简介"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入群名称"];
    }
}

-(void)Balick:(UIButton *)BaBtn
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
