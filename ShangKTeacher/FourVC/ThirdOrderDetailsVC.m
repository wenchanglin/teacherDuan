//
//  ThirdOrderDetailsVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ThirdOrderDetailsVC.h"
#import "OrderDeCell.h"
#import "SecondOrderDeCell.h"
#import "OrderDetaiCell.h"
#import "OrderSecDetailCell.h"
#import "OrderThirdDetailCell.h"
#import "OrderDeModel.h"
#import "PingJiaCellSecond.h"
#import "PingJiaCellThird.h"
@interface ThirdOrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@property(nonatomic,strong)UILabel  * firstPlaceLabel;
@end

@implementation ThirdOrderDetailsVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)FABiao
{
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    NSLog(@"3一路走过来的ID%@",self.OrderFkGoodBaseId);
    NSLog(@"你看看啊不一样吧%@",self.OrderId);
    UITextView *TextView =[self.view viewWithTag:1000];
    if (TextView.text.length != 0) {
        if (self.ratingLabel.text.length != 0) {
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"storeGoodBaseId":self.OrderFkGoodBaseId,@"userId":Manager.UUserId,@"content":TextView.text,@"score":self.ratingLabel.text} url:UrL_AddGoodComment success:^(id responseObject) {
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":self.OrderId} url:UrL_AddOrderComment success:^(id responseObject) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } failure:^(NSError *error) {
                }];
            } failure:^(NSError *error) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"亲,请打描述分数"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"亲,请输入评论"];
    }
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":self.OrderId} url:UrL_OrderDetails success:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"list"];
        for (NSDictionary *Dict in Arr) {
            OrderDeModel *Model = [[OrderDeModel alloc]init];
            [Model setDic:Dict];
            [_dataArray addObject:Model];
        }
        NSLog(@"积极%ld",(unsigned long)_dataArray.count);
        [self createTableView];
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"看看有几个%ld",self.GoodCount);
    if (section == 0) {
        //        return self.GoodCount+1;
        return _dataArray.count + 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == _dataArray.count){
        return 40;
    }else if (indexPath.section == 1){
        return 50;
    }else if (indexPath.section == 2){
        return kScreenHeight/3;
    }
    return 110;
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
    if (section == 0) {
        return 50;
    }else if (section == 1){
        return 5;
    }
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (section == 0) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        imageView.image = [UIImage imageNamed:@"商城-(4)@2x.png"];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 15, kScreenWidth-200, 20)];
        label.text = self.OrderStoreName;
        label.font = [UIFont systemFontOfSize:16];
        headView.backgroundColor = kAppWhiteColor;
        [headView addSubview:label];
        [headView addSubview:imageView];
        view = headView;
    }
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        OrderDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstDe"];
        if (!cell) {
            cell = [[OrderDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstDe"];
        }
        if (indexPath.section==0&&indexPath.row==_dataArray.count){
            SecondOrderDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondDe"];
            if (!cell) {
                cell = [[SecondOrderDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondDe"];
            }
            cell.PriceDeLAbel.text = [NSString stringWithFormat:@"合计:%@元",self.OrderSumPrice];
            [cell.contentView addSubview:cell.PriceDeLAbel];
            return cell;
        }else{
            OrderDeModel *Model = _dataArray[indexPath.row];
            [cell configWithModel:Model];
        }
        return cell;
    }else if (indexPath.section == 1){
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
    PingJiaCellThird *cell = [tableView dequeueReusableCellWithIdentifier:@"Ho"];
    if (!cell) {
        cell = [[PingJiaCellThird alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ho"];
    }
    cell.firstTextView.tag = 1000;
    cell.firstTextView.delegate  = self;
    _firstPlaceLabel  = cell.firstName;
    return cell;
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
    [self.view endEditing:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"评价";
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
