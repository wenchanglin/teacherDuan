//
//  GroupSystemingVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#define MAX_STARWORDS_LENGTH 40
#import "GroupSystemingVC.h"
#import "GroupSystemingCell.h"
#import "GroupSystemingSecondCell.h"
#import <TZImagePickerController.h>
@interface GroupSystemingVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>
{
    UITableView *_tableView;
    UIButton    *Fixbutton2;
    UIView      *NavBarview;
    UILabel     *_FirstLabelNum;
    GroupSystemingSecondCell *Xcell;
    NSMutableArray *_selectedPhotos;
}
@property(nonatomic,strong)UILabel     * firstPlaceLabel;
@end

@implementation GroupSystemingVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedPhotos = [NSMutableArray array];
    [self createNav];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }else if(indexPath.row == 2){
        return 130;
    }
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *Arr = @[@"群头像",@"群名称"];
    if (indexPath.row == 2) {
        Xcell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
        if (!Xcell) {
            Xcell = [[GroupSystemingSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Chat"];
        }
        Xcell.InfoLabel.delegate = self;
        Xcell.InfoLabel.text = self.QunIntro;
        Xcell.InfoLabel.userInteractionEnabled = NO;
        _firstPlaceLabel     = Xcell.ActivityName;
        Xcell.InfoLabel.tag = 17;
        _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, CGRectGetMaxY(Xcell.InfoLabel.frame)-25, 100, 20)];
        _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
        _FirstLabelNum.font = [UIFont systemFontOfSize:16];
        _FirstLabelNum.text = @"0/40";
        [Xcell.contentView addSubview:_FirstLabelNum];
        return Xcell;
    }else{
        GroupSystemingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatOne"];
        if (!cell) {
            
            cell = [[GroupSystemingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatOne"];
        }
        cell.QunFirstLabel.text = Arr[indexPath.row];
        if (indexPath.row == 1) {
            cell.QunSecondInfo = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-120, 15, 110, 20)];
            cell.QunSecondInfo.text = self.QunName;
            cell.QunSecondInfo.enabled = NO;
            cell.QunSecondInfo.textAlignment = NSTextAlignmentRight;
            cell.QunSecondInfo.delegate = self;
            cell.QunSecondInfo.tag = 108;
        }else{
            cell.ImageView = [UIButton buttonWithType:UIButtonTypeCustom];
            cell.ImageView.frame = CGRectMake(kScreenWidth-80, 10, 70, 70);
            cell.ImageView.layer.cornerRadius = 35;
            cell.ImageView.layer.masksToBounds = YES;
            if ([self.QunPhotoHead isKindOfClass:[NSNull class]]) {
                [cell.ImageView setBackgroundImage:[UIImage imageNamed:@"icon-群组头像.png"] forState:UIControlStateNormal];
            }else{
                [cell.ImageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.QunPhotoHead]] placeholderImage:nil];
            }
            [cell.ImageView addTarget:self action:@selector(ChangePic:) forControlEvents:UIControlEventTouchUpInside];
        }
        [cell.contentView addSubview:cell.QunSecondInfo];
        [cell.contentView addSubview:cell.ImageView];
        return cell;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSString  * nsTextContent = textView.text;
    NSInteger   existTextNum = [nsTextContent length];
    _FirstLabelNum.text = [NSString stringWithFormat:@"%ld/40",(long)0+existTextNum];
    if (existTextNum > 39) {
        _FirstLabelNum.text = @"40/40";
        [SVProgressHUD showErrorWithStatus:@"输入内容过长咯"];
    }
    //        NSLog(@"剩余：%ld",100-existTextNum);
    //        NSLog(@"剩余：%ld",0+existTextNum);
    NSString *toBeString               = textView.text;
    NSArray *current                   = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode  = [current firstObject];
    NSString *lang = [currentInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange     = [textView markedTextRange];
        UITextPosition *position       = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                NSRange rangeIndex     = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                if (rangeIndex.length  == 1){
                    textView.text      = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                }else{
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }else{
        }
    }else {
        if (toBeString.length > MAX_STARWORDS_LENGTH){
            NSRange rangeIndex     = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length  == 1){
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

-(void)ChangePic:(UIButton *)Chan
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *photosArr ,BOOL isSelectOriginalPhoto) {
        _selectedPhotos = [NSMutableArray arrayWithArray:photos];
        NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
        [Chan setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)createNav
{
    NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 10, 100, 30)];
    label.text = @"设置群资料";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    Fixbutton2       = [UIButton buttonWithType:UIButtonTypeCustom];
    Fixbutton2.frame           = CGRectMake(kScreenWidth - 70, 10, 40, 30);
    Fixbutton2.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [Fixbutton2 setTitle:@"修改" forState:UIControlStateNormal];
    [Fixbutton2 addTarget:self action:@selector(BianJClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:Fixbutton2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BianJClick:(UIButton *)Biaj
{
    Fixbutton2.hidden = YES;
    Xcell.InfoLabel.text = @"";
    _firstPlaceLabel.text = @"请输入文字...";
    Xcell.InfoLabel.userInteractionEnabled = YES;
    Biaj = [UIButton buttonWithType:UIButtonTypeCustom];
    Biaj.frame = CGRectMake(kScreenWidth - 70, 10, 40, 30);
    Biaj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [Biaj setTitle:@"保存" forState:UIControlStateNormal];
    [Biaj addTarget:self action:@selector(BtnBaoCunClickCk:) forControlEvents:UIControlEventTouchUpInside];
    [NavBarview addSubview:Biaj];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        switch (textView.tag) {
            case 17:
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
            case 17:
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

#pragma mark - textField 代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 102:
            //            _TableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-271-64);
            break;
        default:
            break;
    }
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

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing: YES];
}

-(void)BtnBaoCunClickCk:(UIButton *)BaoC
{
    UITextView *TextView =[self.view viewWithTag:17];
    __weak typeof(self) weakSelf = self;
    if (TextView.text.length  != 0) {
        if (_selectedPhotos.count != 0) {
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.QunId,@"intro":TextView.text} url:UrL_UpdateChatGroup success:^(id responseObject) {
                NSLog(@"修改群资料%@",responseObject);
                 [SVProgressHUD showWithStatus:@"上传中"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSData *imageData  = UIImagePNGRepresentation(_selectedPhotos[0]);
                    NSDictionary *Dict = @{@"fileType":@"image",@"filePurpose":@"imageChatPhoto",@"fkPurposeId":self.QunId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    [manager POST:UrL_UploadFile
                       parameters:Dict
                      constructingBodyWithBlock:
                     ^(id<AFMultipartFormData>_Nonnull formData) {
                         [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"imageChatPhoto.png" mimeType:@"image/png"];
                     } progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              [SVProgressHUD dismiss];
                              [weakSelf.navigationController popViewControllerAnimated:YES];
                              NSLog(@"图片上传成功啦");
                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              NSLog(@"图片上传失败啦");
                          }];
                });
//                [weakSelf.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请上传头像"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入群简介"];
    }
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
