//
//  MyVideoPinaJiaVC.m
//  ShangKTeacher
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#define MAX_STARWORDS_LENGTH 40
#import "MyVideoPinaJiaVC.h"
#import "PingJiaCellSecond.h"
#import "PingJiaCellThird.h"
@interface MyVideoPinaJiaVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    UITableView *_tableView;
    UILabel     *_FirstLabelNum;
}
@property(nonatomic,strong)UILabel  * firstPlaceLabel;
@end

@implementation MyVideoPinaJiaVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)FABiao
{
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    UITextView *TextView =[self.view viewWithTag:1000];
    if (TextView.text.length != 0) {
        if (self.ratingLabel.text.length != 0) {
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"videoCourseId":self.VideoId,@"userId":Manager.UUserId,@"content":TextView.text,@"score":self.ratingLabel.text} url:UrL_VideoPingLun success:^(id responseObject) {
                if ([[responseObject objectForKey:@"errcode"]integerValue]!=0) {
                    [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"亲,请打描述分数"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"亲,请输入评论"];
    }
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)style:UITableViewStyleGrouped];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *ShenQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ShenQBtn.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
    [ShenQBtn setTitle:@"发表评价" forState:UIControlStateNormal];
    [ShenQBtn addTarget:self action:@selector(FABiao)forControlEvents:UIControlEventTouchUpInside];
    [ShenQBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    ShenQBtn.backgroundColor = kAppBlueColor;
    
    [self.view addSubview:ShenQBtn];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 50;
    }else if (indexPath.section == 1){
        return kScreenHeight/3;
    }
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0){
        PingJiaCellSecond *cell = [tableView dequeueReusableCellWithIdentifier:@"Gtr"];
        if (!cell) {
            cell = [[PingJiaCellSecond alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Gtr"];
        }
        self.ratingView = [[TPFloatRatingView alloc]init];
        self.ratingView.frame = CGRectMake(CGRectGetMaxX(cell.LabelMiaoS.frame)+2, 10, 150, 30);
        self.ratingView.delegate = self;
        self.ratingView.emptySelectedImage = [UIImage imageNamed:@"图层-85-拷贝-4@2x_88.png"];
        self.ratingView.fullSelectedImage = [UIImage imageNamed:@"图层-85-拷贝-4@2x.png"];
        self.ratingView.contentMode = UIViewContentModeScaleAspectFill;
        self.ratingView.maxRating = 5;
        self.ratingView.minRating = 1;
        self.ratingView.rating = 2.5;
        self.ratingView.editable = YES;
        self.ratingView.halfRatings = YES;
        self.ratingView.floatRatings = NO;
        self.ratingLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ratingView.frame)+10, 10, 40, 30)];
        self.ratingLabel.font = [UIFont boldSystemFontOfSize:16];
        self.ratingLabel.backgroundColor = kAppClearColor;
        self.ratingLabel.textAlignment = NSTextAlignmentCenter;
        self.ratingLabel.text = [NSString stringWithFormat:@"%.2f", self.ratingView.rating];
        
        [cell.contentView addSubview:self.ratingView];
        [cell.contentView addSubview:self.ratingLabel];
        return cell;
    }
    PingJiaCellThird *cell = [tableView dequeueReusableCellWithIdentifier:@"Hot"];
    if (!cell) {
        cell = [[PingJiaCellThird alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Hot"];
    }
    cell.firstTextView.tag = 1000;
    cell.firstTextView.delegate  = self;
    _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 170, 100, 20)];
    _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
    _FirstLabelNum.font = [UIFont systemFontOfSize:16];
    _FirstLabelNum.text = @"0/40";
    
    [cell.firstTextView addSubview:_FirstLabelNum];
    _firstPlaceLabel  = cell.firstName;
    return cell;
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

#pragma mark - TPFloatRatingViewDelegate

- (void)floatRatingView:(TPFloatRatingView *)ratingView ratingDidChange:(CGFloat)rating
{
    self.ratingLabel.text = [NSString stringWithFormat:@"%.2f", rating];
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
            case 1000:
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
            case 1000:
            {
                _firstPlaceLabel.text =@"亲，写点评论吧...";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITextView *tedxt = [self.view viewWithTag:1000];
    [tedxt resignFirstResponder];
    [self.view endEditing:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"视频评价";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kAppWhiteColor;
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
