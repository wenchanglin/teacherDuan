//
//  FriendYanZhengVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendYanZhengVC.h"
#define MAX_STARWORDS_LENGTH 200
@interface FriendYanZhengVC ()<UITextViewDelegate>
{
    UITextView     * _firstTextView;
    UILabel        * _activityName;
    UILabel        * _FirstLabelNum;
}
@end
@implementation FriendYanZhengVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createUI];
    self.view.backgroundColor = KAppBackBgColor;
}

-(void)createUI
{
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(10, 74, 200, 20)];
    Label.font = [UIFont boldSystemFontOfSize:16];
    Label.textColor = kAppBlueColor;
    Label.text = @"请输入验证信息";
    Label.backgroundColor = kAppClearColor;
    _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(Label.frame)+10, kScreenWidth, 200)];
    _firstTextView.backgroundColor = kAppWhiteColor;
    _firstTextView.tag = 10;
    //    _firstTextView. = 1;
    _firstTextView.delegate = self;
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(Label.frame)+10, 150, 30)];
    _activityName.text = @"我的...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    UILabel *LineLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_firstTextView.frame)+1, kScreenWidth, 1)];
    LineLabel.backgroundColor = kAppLineColor;
    _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 170, 100, 20)];
    _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
    _FirstLabelNum.font = [UIFont systemFontOfSize:16];
    _FirstLabelNum.text = @"0/200";
    
    [_firstTextView addSubview:_FirstLabelNum];
    [self.view addSubview:Label];
    [self.view addSubview:_firstTextView];
    [self.view addSubview:LineLabel];
    [self.view addSubview:_activityName];
}
#pragma mark --------TextViewDelegate------
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        switch (textView.tag) {
            case 10:
            {
                _activityName.text =@"";
            }
                break;
            default:
                break;
        }
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        switch (textView.tag) {
            case 10:
            {
                _activityName.text =@"我的..";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSString  * nsTextContent = textView.text;
    NSInteger   existTextNum = [nsTextContent length];
    _FirstLabelNum.text = [NSString stringWithFormat:@"%ld/200",(long)0+existTextNum];
    if (existTextNum > 199) {
        _FirstLabelNum.text = @"200/200";
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

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 10, 100, 30)];
    label.text = @"好友验证";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 50, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"发送" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(AddAcieveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
    
}

-(void)BaClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)AddAcieveClick:(UIButton *)btn1
{
    FbwManager *Manager = [FbwManager shareManager];
    __weak typeof(self) weakSelf = self;
    if (_firstTextView.text.length != 0) {
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fromUserId":Manager.UUserId,@"toUserId":self.FriendId,@"content":_firstTextView.text} url:UrL_AddFriend success:^(id responseObject) {
//            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            NSLog(@"好友申请发送成功");
        } failure:^(NSError *error) {
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入验证信息"];
    }
}

@end
