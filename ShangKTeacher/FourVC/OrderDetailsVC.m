//
//  OrderDetailsVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrderDetailsVC.h"
#import "AppDelegate.h"
#import "OrderDeCell.h"
#import "SecondOrderDeCell.h"
#import "OrderDetaiCell.h"
#import "OrderSecDetailCell.h"
#import "OrderThirdDetailCell.h"
#import "OrderDeModel.h"
#import "ArrowView.h"
#import "ApplicationForReturnVC.h"
#import "ThirdOrderDetailsVC.h"
#import "PayMoneyOrderVC.h"
@interface OrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataArray;
    NSArray        *InfoArr;
    ArrowView      *_arrowView;
}
@end

@implementation OrderDetailsVC

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
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    self.view.backgroundColor = kAppWhiteColor;
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
    if ([self.IsHidden isEqualToString:@"YES"]) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64-44) style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        UIView *XuanFView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
        XuanFView.backgroundColor = kAppWhiteColor;
        UIButton *bTn             = [UIButton buttonWithType:UIButtonTypeCustom];
        bTn.frame                 = CGRectMake(kScreenWidth-90, 0, 90, 44);
        bTn.backgroundColor       = kAppBlueColor;
        [bTn setTitle:@"支付" forState:UIControlStateNormal];
        [bTn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        [bTn addTarget:self action:@selector(bTnFang:) forControlEvents:UIControlEventTouchUpInside];
        
        [XuanFView addSubview:bTn];
        [self.view addSubview:XuanFView];
    }else if ([self.IsHidden isEqualToString:@"YESNO"]) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64-44) style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        UIView *XuanFView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
        XuanFView.backgroundColor = kAppWhiteColor;
        UIButton *bTn             = [UIButton buttonWithType:UIButtonTypeCustom];
        bTn.frame                 = CGRectMake(kScreenWidth-90, 0, 90, 44);
        bTn.backgroundColor       = kAppBlueColor;
        [bTn setTitle:@"查看退货" forState:UIControlStateNormal];
        [bTn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        [bTn addTarget:self action:@selector(LookTH:) forControlEvents:UIControlEventTouchUpInside];
        
        [XuanFView addSubview:bTn];
        [self.view addSubview:XuanFView];
    }else if ([self.IsHidden isEqualToString:@"HONO"]){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64-44) style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        UIView *XuanFView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
        XuanFView.backgroundColor = kAppWhiteColor;
        UIButton *bTn             = [UIButton buttonWithType:UIButtonTypeCustom];
        bTn.frame                 = CGRectMake(kScreenWidth-90, 0, 90, 44);
        bTn.backgroundColor       = kAppBlueColor;
        [bTn setTitle:@"确认收货" forState:UIControlStateNormal];
        [bTn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        [bTn addTarget:self action:@selector(QRShouH:) forControlEvents:UIControlEventTouchUpInside];
        
        [XuanFView addSubview:bTn];
        [self.view addSubview:XuanFView];
        
    }else{
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"看看有几个%ld",self.GoodCount);
    if (section == 0) {
        //        return self.GoodCount+1;
        return _dataArray.count + 1;
    }
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == _dataArray.count){
        return 40;
    }else if (indexPath.section == 1){
        if (indexPath.row == 5) {
            return 100;
        }else if (indexPath.row == 6){
            return 120;
        }
        return 50;
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
    NSArray *arr = @[@"下单时间",@"订单编号",@"订单状态",@"快递公司",@"快递单号"];
    if ([self.IsHidden isEqualToString:@"YESNO"]){
        InfoArr = @[[NSString stringWithFormat:@"%@",self.OrderReceiveTime],@"12655886532",@"退货中",@"申通快递",@"256859899666"];
    }else if ([self.IsHidden isEqualToString:@"HONO"])
    {
        InfoArr = @[[NSString stringWithFormat:@"%@",self.OrderReceiveTime],@"12655886532",@"已发货",@"申通快递",@"256859899666"];
    }else if ([self.IsHidden isEqualToString:@"YES"]){
        InfoArr = @[[NSString stringWithFormat:@"%@",self.OrderReceiveTime],@"12655886532",@"待付款",@"申通快递",@"256859899666"];
    }
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
    }else if (indexPath.section==1&&indexPath.row==5){
        OrderSecDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"See"];
        if (!cell) {
            cell = [[OrderSecDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"See"];
        }
        cell.SecDetaNameLabel.text  = self.OrderReceiveName;
        cell.SecDetaPhoneLAbel.text = self.OrderReceivePhone;
        cell.SecDetaDiZhiLabel.text = self.OrderReceiveAddress;
        CGRect textFrame        = cell.SecDetaDiZhiLabel.frame;
        cell.SecDetaDiZhiLabel.frame = CGRectMake(10, CGRectGetMaxY(cell.SecDetaNameLabel.frame)+10, kScreenWidth - 20, textFrame.size.height = [cell.SecDetaDiZhiLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:cell.SecDetaDiZhiLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
        cell.SecDetaDiZhiLabel.frame = CGRectMake(10, CGRectGetMaxY(cell.SecDetaNameLabel.frame)+10, kScreenWidth - 20, textFrame.size.height);
        
        [cell.contentView addSubview:cell.SecDetaNameLabel];
        [cell.contentView addSubview:cell.SecDetaPhoneLAbel];
        [cell.contentView addSubview:cell.SecDetaDiZhiLabel];
        return cell;
    }else if (indexPath.section==1&&indexPath.row==6){
        OrderThirdDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderThird"];
        if (!cell) {
            cell = [[OrderThirdDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderThird"];
        }
        return cell;
    }
    OrderDetaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chatb"];
    if (!cell) {
        cell = [[OrderDetaiCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Chatb"];
    }
    cell.OrderXiangQ.text = arr[indexPath.row];
    cell.OrderInfo.text = InfoArr[indexPath.row];
    if (indexPath.section==1&&indexPath.row==2) {
        cell.OrderInfo.textColor = kAppOrangeColor;
    }
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"订单详情";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)bTnFang:(UIButton *)PayBtn
{
    NSLog(@"点击支付");
    PayMoneyOrderVC *Pay = [[PayMoneyOrderVC alloc]init];
    NSLog(@"你妹%@",self.OrderSumPrice);
    Pay.SumPrice =  [self.OrderSumPrice doubleValue];
    Pay.OrderId  =  self.OrderId;
    Pay.PayMoneyChoose = @"SpBuy";
    [self.navigationController pushViewController:Pay animated:YES];
    
}

-(void)QRShouH:(UIButton *)QR
{
    __weak typeof(self) weakSelf = self;
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"我已收到货,同意付款!"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            //            Model = _dataTwoArray[QRBtn.tag];
            ThirdOrderDetailsVC *Details = [[ThirdOrderDetailsVC alloc]init];
            Details.OrderId = weakSelf.OrderId;
            Details.OrderFkGoodBaseId = weakSelf.OrderFkGoodBaseId;
            Details.OrderSumPrice = weakSelf.OrderSumPrice;
            Details.OrderSinglePrice = weakSelf.OrderSinglePrice;
            Details.OrderGoodBasePhotoUrl = weakSelf.OrderGoodBasePhotoUrl;
            Details.OrderStoreName = weakSelf.OrderStoreName;
            Details.OrderGoodBaseName = weakSelf.OrderGoodBaseName;
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":weakSelf.OrderId} url:UrL_QRShouHuo success:^(id responseObject) {
                [weakSelf.navigationController pushViewController:Details animated:YES];
            } failure:^(NSError *error) {
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)LookTH:(UIButton *)THg
{
    ApplicationForReturnVC *Forreturn = [[ApplicationForReturnVC alloc]init];
    Forreturn.ChooseUI = @"OK";
    Forreturn.OrderId = self.OrderId;
    [self.navigationController pushViewController:Forreturn animated:YES];
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
