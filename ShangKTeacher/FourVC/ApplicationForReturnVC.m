//
//  ApplicationForReturnVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ApplicationForReturnVC.h"
@interface ApplicationForReturnVC ()<UITextViewDelegate>
{
    UITextView     * _firstTextView;
    UILabel        * _activityName;
    NSString       * _OneTime;
    NSString       * _THOrder;
}
@end
@implementation ApplicationForReturnVC
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
    if ([self.ChooseUI isEqualToString:@"NOOK"]) {
        [self createUI];
    }else{
        [self createData];
    }
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":self.OrderId} url:UrL_OrderDetails success:^(id responseObject) {
        NSLog(@"申请退货数据%@",responseObject);
        NSDictionary *DataDic = [responseObject objectForKey:@"data"];
        if ([[DataDic objectForKey:@"status"]integerValue] == 1000) {
            _OneTime = [DataDic objectForKey:@"createTime"];
            if ([[DataDic objectForKey:@"refundReason"] isKindOfClass:[NSNull class]]) {
                _THOrder = @"暂无退货原因";
            }else{
                _THOrder = [DataDic objectForKey:@"refundReason"];
            }
//            NSLog(@"时间%@",_OneTime);
//            NSLog(@"退换原因%@",_THOrder);
            [self createChoo];
        }else if([[DataDic objectForKey:@"status"]integerValue] == 1020){
            [self createThirdChoo];
        }else{
            //卖家处理
            [self createSecondChoo];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)createChoo
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/6.5)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(50, kScreenHeight/6.5/2/2, kScreenWidth-100, kScreenHeight/6.5/2)];
    LineView.backgroundColor = kAppWhiteColor;
    UILabel *LineLLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth-100, 2)];
    LineLLabel.backgroundColor = kAppLineColor;
    [LineView addSubview:LineLLabel];
    NSArray *arr = @[@"申请退货",@"卖家处理",@"退货成功"];
    for (int i=0; i<3; i++) {
        UIImageView *imageViewLayer = [[UIImageView alloc]init];
        if (i == 0) {
            imageViewLayer.frame = CGRectMake(i*(kScreenWidth-100)/3+i*40, -5, 30, 30);
        }else{
            imageViewLayer.frame = CGRectMake(i*(kScreenWidth-100)/3+i*40, 0, 20, 20);
        }
        UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(kScreenWidth-100)/3+i*40-25, CGRectGetMaxY(imageViewLayer.frame)+10, 80, 20)];
        TitleLabel.text = arr[i];
        TitleLabel.font = [UIFont systemFontOfSize:16];
        if (i == 0) {
            TitleLabel.textColor = kAppBlueColor;
        }else{
            TitleLabel.textColor = kAppLineColor;
        }
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            imageViewLayer.image = [UIImage imageNamed:@"形状-1@2x.png"];
        }else{
            imageViewLayer.image = [UIImage imageNamed:@"椭圆-3-拷贝-2@2x_81.png"];
        }
        if (i == 0) {
            UILabel *TimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(-45, CGRectGetMaxY(TitleLabel.frame)+5, kScreenWidth/3.1, 15)];
            TimeLabel.font = [UIFont systemFontOfSize:15];
            TimeLabel.adjustsFontSizeToFitWidth = YES;
            TimeLabel.textColor = kAppBlueColor;
            NSString * timeStampString = _OneTime;
            NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
            NSString *time = [objDateformat stringFromDate: date];
            TimeLabel.text = [NSString stringWithFormat:@"%@",time];
            [LineView addSubview:TimeLabel];
        }
        [LineView addSubview:imageViewLayer];
        [LineView addSubview:TitleLabel];
    }
    UILabel *LAbel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(HeadView.frame), kScreenWidth, 7)];
    LAbel.backgroundColor = kAppLineColor;
    UILabel *TuiHLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LAbel.frame)+10, 100, 20)];
    TuiHLabel.font = [UIFont boldSystemFontOfSize:16];
    TuiHLabel.text = @"退货原因";
    UILabel *TuiHuoLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(TuiHLabel.frame)+10, kScreenWidth-20, 20)];
    TuiHuoLabel.text = _THOrder;
    TuiHuoLabel.numberOfLines = 0;
    CGRect textFrame1 = TuiHuoLabel.frame;
    TuiHuoLabel.frame = CGRectMake(10, CGRectGetMaxY(TuiHLabel.frame)+10, kScreenWidth-20, textFrame1.size.height = [TuiHuoLabel.text boundingRectWithSize:CGSizeMake(textFrame1.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:TuiHuoLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
    TuiHuoLabel.frame = CGRectMake(10, CGRectGetMaxY(TuiHLabel.frame)+10, kScreenWidth-20, textFrame1.size.height);
    UILabel *MessageHLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(TuiHuoLabel.frame)+10, 100, 20)];
    MessageHLabel.font = [UIFont boldSystemFontOfSize:16];
    MessageHLabel.text = @"说明";
    UILabel *LabelSm = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(MessageHLabel.frame)+10, kScreenWidth-20, 20)];
    LabelSm.text = @"您的申请已提交,请耐心等待卖家处理哦";
    LabelSm.numberOfLines = 0;
    CGRect textFrame = LabelSm.frame;
    LabelSm.frame = CGRectMake(10, CGRectGetMaxY(MessageHLabel.frame)+10, kScreenWidth-20, textFrame.size.height = [LabelSm.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:LabelSm.font,NSFontAttributeName ,nil] context:nil].size.height);
    LabelSm.frame = CGRectMake(10, CGRectGetMaxY(MessageHLabel.frame)+10, kScreenWidth-20, textFrame.size.height);
    
    
    [HeadView  addSubview:LineView];
    [self.view addSubview:HeadView];
    [self.view addSubview:TuiHLabel];
    [self.view addSubview:LAbel];
    [self.view addSubview:MessageHLabel];
    [self.view addSubview:LabelSm];
    [self.view addSubview:TuiHuoLabel];
    
}

-(void)createSecondChoo
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/6.5)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(50, kScreenHeight/6.5/2/2, kScreenWidth-100, kScreenHeight/6.5/2)];
    LineView.backgroundColor = kAppWhiteColor;
    UILabel *LineLLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth-100, 2)];
    LineLLabel.backgroundColor = kAppLineColor;
    [LineView addSubview:LineLLabel];
    NSArray *arr = @[@"申请退货",@"卖家处理",@"退货成功"];
    for (int i=0; i<3; i++) {
        UIImageView *imageViewLayer = [[UIImageView alloc]init];
        if (i == 1) {
            imageViewLayer.frame = CGRectMake(i*(kScreenWidth-100)/3+i*40, -5, 30, 30);
        }else{
            imageViewLayer.frame = CGRectMake(i*(kScreenWidth-100)/3+i*40, 0, 20, 20);
        }
        UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(kScreenWidth-100)/3+i*40-25, CGRectGetMaxY(imageViewLayer.frame)+10, 80, 20)];
        TitleLabel.text = arr[i];
        TitleLabel.font = [UIFont systemFontOfSize:16];
        if (i == 1 || i == 0) {
            TitleLabel.textColor = kAppBlueColor;
        }else{
            TitleLabel.textColor = kAppLineColor;
        }
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 1) {
            imageViewLayer.image = [UIImage imageNamed:@"形状-1@2x.png"];
        }else if(i == 0){
            imageViewLayer.image = [UIImage imageNamed:@"椭圆-3-拷贝@2x.png"];
        }else{
            imageViewLayer.image = [UIImage imageNamed:@"椭圆-3-拷贝-2@2x_81.png"];
        }
        if (i == 0) {
            UILabel *TimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(-40, CGRectGetMaxY(TitleLabel.frame)+5, kScreenWidth/3.1, 15)];
            TimeLabel.font = [UIFont systemFontOfSize:15];
            TimeLabel.adjustsFontSizeToFitWidth = YES;
            TimeLabel.textColor = kAppBlueColor;
            NSString * timeStampString = _OneTime;
            NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
            NSString *time = [objDateformat stringFromDate: date];
            TimeLabel.text = [NSString stringWithFormat:@"%@",time];
            [LineView addSubview:TimeLabel];
        }
        [LineView addSubview:imageViewLayer];
        [LineView addSubview:TitleLabel];
    }
    UILabel *LAbel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(HeadView.frame), kScreenWidth, 7)];
    LAbel.backgroundColor = kAppLineColor;
    UILabel *TuiHLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LAbel.frame)+10, kScreenWidth/2, 20)];
    TuiHLabel.font = [UIFont boldSystemFontOfSize:16];
    TuiHLabel.text = @"卖家正在处理中，请耐心等待...";
    
    [HeadView  addSubview:LineView];
    [self.view addSubview:HeadView];
    [self.view addSubview:TuiHLabel];
    [self.view addSubview:LAbel];
}

-(void)createThirdChoo
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/6.5)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(50, kScreenHeight/6.5/2/2, kScreenWidth-100, kScreenHeight/6.5/2)];
    LineView.backgroundColor = kAppWhiteColor;
    UILabel *LineLLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth-100, 2)];
    LineLLabel.backgroundColor = kAppLineColor;
    [LineView addSubview:LineLLabel];
    NSArray *arr = @[@"申请退货",@"卖家处理",@"退货成功"];
    for (int i=0; i<3; i++) {
        UIImageView *imageViewLayer = [[UIImageView alloc]init];
        if (i == 2) {
            imageViewLayer.frame = CGRectMake(i*(kScreenWidth-100)/3+i*40, -5, 30, 30);
        }else{
            imageViewLayer.frame = CGRectMake(i*(kScreenWidth-100)/3+i*40, 0, 20, 20);
        }
        UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(kScreenWidth-100)/3+i*40-25, CGRectGetMaxY(imageViewLayer.frame)+10, 80, 20)];
        TitleLabel.text = arr[i];
        TitleLabel.font = [UIFont systemFontOfSize:16];
        TitleLabel.textColor = kAppBlueColor;
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 2) {
            imageViewLayer.image = [UIImage imageNamed:@"形状-1@2x.png"];
        }else{
            imageViewLayer.image = [UIImage imageNamed:@"椭圆-3-拷贝@2x.png"];
        }
        if (i == 0) {
            UILabel *TimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(-40, CGRectGetMaxY(TitleLabel.frame)+5, kScreenWidth/3.1, 15)];
            TimeLabel.font = [UIFont systemFontOfSize:15];
            TimeLabel.adjustsFontSizeToFitWidth = YES;
            TimeLabel.textColor = kAppBlueColor;
            NSString * timeStampString = _OneTime;
            NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
            NSString *time = [objDateformat stringFromDate: date];
            TimeLabel.text = [NSString stringWithFormat:@"%@",time];
            [LineView addSubview:TimeLabel];
        }
        [LineView addSubview:imageViewLayer];
        [LineView addSubview:TitleLabel];
    }
    UILabel *LAbel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(HeadView.frame), kScreenWidth, 7)];
    LAbel.backgroundColor = kAppLineColor;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LAbel.frame)+10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"形状-3@2x_34.png"];
    UILabel *TuiHLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, CGRectGetMaxY(LAbel.frame)+10, kScreenWidth/2, 20)];
    TuiHLabel.font = [UIFont boldSystemFontOfSize:16];
    TuiHLabel.text = @"退货成功";
    
    [HeadView  addSubview:LineView];
    [self.view addSubview:HeadView];
    [self.view addSubview:imageView];
    [self.view addSubview:TuiHLabel];
    [self.view addSubview:LAbel];
}

-(void)createUI
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/6.5)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(50, kScreenHeight/6.5/2/2, kScreenWidth-100, kScreenHeight/6.5/2)];
    LineView.backgroundColor = kAppWhiteColor;
    UILabel *LineLLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth-100, 2)];
    LineLLabel.backgroundColor = kAppLineColor;
    [LineView addSubview:LineLLabel];
    NSArray *arr = @[@"申请退货",@"卖家处理",@"退货成功"];
    for (int i=0; i<3; i++) {
        UIImageView *imageViewLayer = [[UIImageView alloc]initWithFrame:CGRectMake(i*(kScreenWidth-100)/3+i*40, 0, 20, 20)];
        UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*(kScreenWidth-100)/3+i*40-30, CGRectGetMaxY(imageViewLayer.frame)+10, 80, 20)];
        TitleLabel.text = arr[i];
        TitleLabel.font = [UIFont systemFontOfSize:16];
        TitleLabel.textColor = kAppLineColor;
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        imageViewLayer.image = [UIImage imageNamed:@"椭圆-3-拷贝-2@2x_81.png"];
        [LineView addSubview:imageViewLayer];
        [LineView addSubview:TitleLabel];
    }
    UILabel *LAbel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(HeadView.frame), kScreenWidth, 7)];
    LAbel.backgroundColor = kAppLineColor;
    UILabel *TuiHLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LAbel.frame)+10, 100, 20)];
    TuiHLabel.font = [UIFont boldSystemFontOfSize:16];
    TuiHLabel.text = @"退货原因";
    UIButton *TextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    TextBtn.frame = CGRectMake(10, CGRectGetMaxY(TuiHLabel.frame)+10, kScreenWidth-20, 130);
    TextBtn.layer.borderWidth = 1;
    TextBtn.layer.borderColor = kAppLineColor.CGColor;
    _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth, 130)];
    _firstTextView.backgroundColor = kAppWhiteColor;
    _firstTextView.tag = 10;
    _firstTextView.delegate = self;
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(6, 7, 150, 30)];
    _activityName.text = @"请输入退款原因...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    UILabel *MessageHLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(TextBtn.frame)+10, 100, 20)];
    MessageHLabel.font = [UIFont boldSystemFontOfSize:16];
    MessageHLabel.text = @"说明";
    UILabel *LabelSm = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(MessageHLabel.frame)+10, kScreenWidth-20, 20)];
    LabelSm.text = @"细则说明细则说明细则说明细则说明细则说明细则说明细则说明细则说明细则说明细则说明细则说明细则说明";
    LabelSm.numberOfLines = 0;
    CGRect textFrame = LabelSm.frame;
    LabelSm.frame = CGRectMake(10, CGRectGetMaxY(MessageHLabel.frame)+10, kScreenWidth-20, textFrame.size.height = [LabelSm.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:LabelSm.font,NSFontAttributeName ,nil] context:nil].size.height);
    LabelSm.frame = CGRectMake(10, CGRectGetMaxY(MessageHLabel.frame)+10, kScreenWidth-20, textFrame.size.height);
    UIButton *ShenQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ShenQBtn.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
    [ShenQBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [ShenQBtn addTarget:self action:@selector(TiJiaoSq)forControlEvents:UIControlEventTouchUpInside];
    [ShenQBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    ShenQBtn.backgroundColor = kAppBlueColor;
    
    
    [HeadView addSubview:LineView];
    [self.view addSubview:HeadView];
    [self.view addSubview:TuiHLabel];
    [self.view addSubview:LAbel];
    [TextBtn addSubview:_firstTextView];
    [TextBtn addSubview:_activityName];
    [self.view addSubview:MessageHLabel];
    [self.view addSubview:LabelSm];
    [self.view addSubview:ShenQBtn];
    [self.view addSubview:TextBtn];
}

-(void)TiJiaoSq
{
    __weak typeof(self) weakSelf = self;
    if (_firstTextView.text.length != 0) {
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":self.OrderId,@"refundReason":_firstTextView.text} url:UrL_AppReturnOrder success:^(id responseObject) {
            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请填写退款原因"];
    }
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
                _activityName.text =@"请输入退款原因...";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 10, 100, 30)];
    label.text = @"申请退货";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
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
