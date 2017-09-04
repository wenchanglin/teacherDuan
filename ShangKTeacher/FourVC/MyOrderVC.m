//
//  MyOrderVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#import "MyOrderVC.h"
#import "AppDelegate.h"
#import "MyOrderCell.h"
#import "OrderDetailsVC.h"
#import "MyOrderModel.h"
#import "ArrowView.h"
#import "MyOrderCellFirstCell.h"
#import "MyOrderCellFourCell.h"
#import "ApplicationForReturnVC.h"
#import "ThirdOrderDetailsVC.h"
#import "OrderDeModel.h"
#import "OrderDeCell.h"
#import "PayMoneyOrderVC.h"
#define Array @[@"待付款",@"待收货",@"待评价",@"退货",@"历史订单"]
@interface MyOrderVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * _mainScrollView;
    UITableView  * _secondView;
    UITableView  * _thirdView;
    NSMutableArray *_dataTwoArray;
    NSMutableArray *_dataThreeArray;
    NSMutableArray *_PingArray;
    UITableView  * _fourView;
    NSMutableArray *_dataFourArray;
    ArrowView     * _arrowView;
    MyOrderModel  *Model;
    OrderDeModel * XModel;
}
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation MyOrderVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
    [self creattitilebtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataOneArray = [NSMutableArray array];
    _PingArray = [NSMutableArray array];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = kAppWhiteColor;
    [self createNav];
}
//待付款
-(void)createData
{
    NSLog(@"第1商店");
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"status":@10} url:UrL_MyOrder success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [_PingArray removeAllObjects];
        [_dataOneArray removeAllObjects];
        [_dataFiveArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            Model = [[MyOrderModel alloc]init];
            [Model setDic:Dict];
            NSArray *ART = [Dict objectForKey:@"list"];
            for (NSDictionary *Dic in ART) {
                [Model setDicGt:Dic];
            }
            [_dataOneArray addObject:Model];
        }
        [self creatTableview];
    } failure:^(NSError *error) {
    }];
}

////待收货
-(void)createTwoData
{
    NSLog(@"第2商店");
    FbwManager *Manager = [FbwManager shareManager];
    _dataTwoArray = [NSMutableArray array];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"status":@20} url:UrL_MyOrder success:^(id responseObject) {
        NSLog(@"吓死%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        [_dataFiveArray removeAllObjects];
        [_PingArray removeAllObjects];
        [_dataOneArray removeAllObjects];
        [_dataFourArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            Model = [[MyOrderModel alloc]init];
            [Model setDic:Dict];
            NSArray *ART = [Dict objectForKey:@"list"];
            for (NSDictionary *Dic in ART) {
                [Model setDicGt:Dic];
            }
            [_dataTwoArray addObject:Model];
        }NSLog(@"我不信%ld",(unsigned long)_dataTwoArray.count);
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}
//待评价
-(void)createThreeData
{
    NSLog(@"第3商店");
    FbwManager *Manager = [FbwManager shareManager];
    _dataThreeArray = [NSMutableArray array];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"status":@40} url:UrL_MyOrder success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [_dataFiveArray removeAllObjects];
        [_PingArray removeAllObjects];
        [_dataOneArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            Model = [[MyOrderModel alloc]init];
            [Model setDic:Dict];
            NSArray *ART = [Dict objectForKey:@"list"];
            for (NSDictionary *Dic in ART) {
                [Model setDicGt:Dic];
            }
            [_dataThreeArray addObject:Model];
        }
        [_thirdView reloadData];
        
    } failure:^(NSError *error) {
    }];
}

-(void)createFourData
{
    FbwManager *Manager = [FbwManager shareManager];
    _dataFourArray = [NSMutableArray array];
    NSLog(@"第4商店");
    [_dataFiveArray removeAllObjects];
    [_dataOneArray removeAllObjects];
    [_PingArray removeAllObjects];
    [_dataThreeArray removeAllObjects];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"status":@1000} url:UrL_MyOrder success:^(id responseObject) {
        NSLog(@"%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            Model = [[MyOrderModel alloc]init];
            [Model setDic:Dict];
            NSLog(@"等待%@",Model.MyOrderSumPrice);
            NSArray *ART = [Dict objectForKey:@"list"];
            for (NSDictionary *Dic in ART) {
                [Model setDicGt:Dic];
            }
            [_dataFourArray addObject:Model];
        }
        [_fourView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createFiveData
{
    FbwManager *Manager = [FbwManager shareManager];
    _dataFiveArray = [NSMutableArray array];
    NSLog(@"第5商店");
    [self creatTableview];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId} url:UrL_MyOrder success:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
        [_dataOneArray removeAllObjects];
        [_PingArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            Model = [[MyOrderModel alloc]init];
            [Model setDic:Dict];
            NSArray *ART = [Dict objectForKey:@"list"];
            for (NSDictionary *Dic in ART) {
                [Model setDicGt:Dic];
            }
            [_dataFiveArray addObject:Model];
        }
        [_fiveView reloadData];
    } failure:^(NSError *error) {
    }];
}

#pragma mark-----------------------滑动-----------------------

-(void)creattitilebtn
{
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    topview.backgroundColor = kAppWhiteColor;
    [self.view addSubview:topview];
    _array = [[NSMutableArray alloc]init];
    for(int i = 0; i < 5; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth/5*i, 0, kScreenWidth/5, 40);
        [btn setTitle:Array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if(i == self.num)
        {
            [btn setTitleColor:kAppBlueColor forState:UIControlStateNormal];
            if (i == 0) {
                [self createData];
                _mainScrollView.contentOffset = CGPointMake(0,0);
            }else if (i == 1){
                [self createTwoData];
                [self creatTableview];
                _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
            }else if (i == 2){
                [self createThreeData];
                [self creatTableview];
                _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
            }
            else if (i == 3){
                [self createFourData];
                [self creatTableview];
                _mainScrollView.contentOffset = CGPointMake(3*kScreenWidth,0);
            }else if (i == 4){
                [self createFiveData];
                _mainScrollView.contentOffset = CGPointMake(4*kScreenWidth,0);
            }
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 800+i;
        [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [_array addObject:btn];
        [topview addSubview:btn];
        
    }
    _label = [[UILabel alloc]initWithFrame:CGRectMake(self.num*kScreenWidth/5, 38, kScreenWidth/5, 2)];
    _label.backgroundColor = kAppBlueColor;
    
    [topview addSubview:_label];
}

#pragma mark-----------------------点击切换-----------------------

-(void)change:(UIButton *)btn
{
    if(btn.tag == 800)
    {
        [self createData];
        _mainScrollView.contentOffset = CGPointMake(0,0);
        for(int i = 0; i < _array.count; i++)
        {
            [_array[i] setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            [_array[0] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.5 animations:^{
            _label.frame = CGRectMake(0, 38, kScreenWidth/5, 2);
        }];
    }
    if(btn.tag == 801)
    {
        [self createTwoData];
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
        for(int i = 0; i < _array.count; i++)
        {
            [_array[i] setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            [_array[1] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.5 animations:^{
            _label.frame = CGRectMake(kScreenWidth/5, 38, kScreenWidth/5, 2);
        }];
    }
    if(btn.tag == 802)
    {
        [self createThreeData];
        _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
        for(int i = 0; i < _array.count; i++)
        {
            [_array[i] setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            [_array[2] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.5 animations:^{
            _label.frame = CGRectMake(kScreenWidth/5*2, 38, kScreenWidth/5, 2);
        }];
    }
    if(btn.tag == 803)
    {
        [self createFourData];
        _mainScrollView.contentOffset = CGPointMake(3*kScreenWidth,0);
        for(int i = 0; i < _array.count; i++)
        {
            [_array[i] setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            [_array[3] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.5 animations:^{
            _label.frame = CGRectMake(kScreenWidth/5*3, 38, kScreenWidth/5, 2);
        }];
    }
    if(btn.tag == 804)
    {
        [self createFiveData];
        _mainScrollView.contentOffset = CGPointMake(4*kScreenWidth,0);
        for(int i = 0; i < _array.count; i++)
        {
            [_array[i] setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            [_array[4] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
        }
        [UIView animateWithDuration:0.5 animations:^{
            _label.frame = CGRectMake(kScreenWidth/5*4, 38, kScreenWidth/5, 2);
        }];
    }
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    int num = _mainScrollView.contentOffset.x/kScreenWidth;
//    if(num == 0)
//    {
//       [self createData];
//        for(int i = 0; i < _array.count; i++)
//        {
//
//            [_array[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [_array[0] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
//        }
//        [UIView animateWithDuration:0.5 animations:^{
//            _label.frame = CGRectMake(0, 38, kScreenWidth/5, 2);
//        }];
//    }
//    if(num == 1)
//    {
//        for(int i = 0; i < _array.count; i++)
//        {
//            [_array[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [_array[1] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
//        }
//        [UIView animateWithDuration:0.5 animations:^{
//            _label.frame = CGRectMake(kScreenWidth/5, 38, kScreenWidth/5, 2);
//        }];
//
//    }
//    if(num == 2)
//    {
//        for(int i = 0; i < _array.count; i++)
//        {
//            [_array[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [_array[2] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
//        }
//        [UIView animateWithDuration:0.5 animations:^{
//            _label.frame = CGRectMake(kScreenWidth/5*2, 38, kScreenWidth/5, 2);
//        }];
//
//    }
//    if(num == 3)
//    {
//        for(int i = 0; i < _array.count; i++)
//        {
//            [_array[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [_array[3] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
//        }
//        [UIView animateWithDuration:0.5 animations:^{
//            _label.frame = CGRectMake(kScreenWidth/5*3, 38, kScreenWidth/5, 2);
//        }];
//
//    }
//    if(num == 4)
//    {
//        [self createFiveData];
//        for(int i = 0; i < _array.count; i++)
//        {
//
//            [_array[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [_array[4] setTitleColor:kAppBlueColor forState:UIControlStateNormal];
//        }
//        [UIView animateWithDuration:0.5 animations:^{
//            _label.frame = CGRectMake(kScreenWidth/5*4, 38, kScreenWidth/5, 2);
//        }];
//
//    }
//}

//创建tableview
-(void)creatTableview
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,104, kScreenWidth, kScreenHeight-104)];
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag = 20;
    _firstView.delegate = self;
    _firstView.backgroundColor = kAppWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag = 21;
    _secondView.backgroundColor = kAppWhiteColor;
    _secondView.delegate = self;
    _secondView.dataSource = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    
    _thirdView = [[UITableView alloc]initWithFrame:CGRectMake(2*width, 0,width,height) style:UITableViewStyleGrouped];
    _thirdView.tag = 22;
    _thirdView.backgroundColor = kAppWhiteColor;
    _thirdView.delegate = self;
    _thirdView.dataSource = self;
    _thirdView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _thirdView.showsVerticalScrollIndicator=NO;
    
    _fourView = [[UITableView alloc]initWithFrame:CGRectMake(3*width, 0,width,height) style:UITableViewStyleGrouped];
    _fourView.tag = 23;
    _fourView.backgroundColor = kAppWhiteColor;
    _fourView.delegate = self;
    _fourView.dataSource = self;
    _fourView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fourView.showsVerticalScrollIndicator=NO;
    
    _fiveView = [[UITableView alloc]initWithFrame:CGRectMake(4*width, 0,width,height) style:UITableViewStyleGrouped];
    _fiveView.tag = 24;
    _fiveView.delegate = self;
    _fiveView.dataSource = self;
    _fiveView.backgroundColor = kAppWhiteColor;
    _fiveView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fiveView.showsVerticalScrollIndicator=NO;
    
    _mainScrollView.contentSize = CGSizeMake(width*5, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [_mainScrollView addSubview:_thirdView];
    [_mainScrollView addSubview:_fourView];
    [_mainScrollView addSubview:_fiveView];
    [self.view addSubview:_mainScrollView];
}
#pragma mark --tableview的代理协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 20) {
        return _dataOneArray.count;
    }else if (tableView.tag == 21){
        return _dataTwoArray.count;
    }else if (tableView.tag == 22){
        return _dataThreeArray.count;
    }else if (tableView.tag == 23){
        return _dataFourArray.count;
    }else if (tableView.tag == 24){
        return _dataFiveArray.count;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 20) {
        Model = _dataOneArray[section];
        //        NSLog(@"积极%ld",Model.ListArr.count);
        return Model.ListArr.count+2;
    }else if (tableView.tag == 21){
        Model = _dataTwoArray[section];
        NSLog(@"积极%ld",(unsigned long)Model.ListArr.count);
        return Model.ListArr.count+2;
    }else if (tableView.tag == 22){
        Model = _dataThreeArray[section];
        NSLog(@"积极%ld",(unsigned long)Model.ListArr.count);
        return Model.ListArr.count+2;
    }else if (tableView.tag == 23){
        Model = _dataFourArray[section];
        NSLog(@"积极%ld",(unsigned long)Model.ListArr.count);
        return Model.ListArr.count+2;
    }else if (tableView.tag == 24){
        Model = _dataFiveArray[section];
        NSLog(@"积极%ld",(unsigned long)Model.ListArr.count);
        return Model.ListArr.count+2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 20) {
        Model = _dataOneArray[indexPath.section];
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == Model.ListArr.count+1){
            return 90;
        }
        if (Model.ListArr.count > 1) {
            return 60 *Model.ListArr.count;
        }else{
            return 110 *Model.ListArr.count;
        }
        
    }else if (tableView.tag == 21) {
        Model = _dataTwoArray[indexPath.section];
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == Model.ListArr.count+1){
            return 90;
        }
        if (Model.ListArr.count > 1) {
            return 60 *Model.ListArr.count;
        }else{
            return 110 *Model.ListArr.count;
        }
    }else if (tableView.tag == 22) {
        Model = _dataThreeArray[indexPath.section];
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == Model.ListArr.count+1){
            return 90;
        }
        if (Model.ListArr.count > 1) {
            return 60 *Model.ListArr.count;
        }else{
            return 110 *Model.ListArr.count;
        }
    }else if (tableView.tag == 23) {
        Model = _dataFourArray[indexPath.section];
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == Model.ListArr.count+1){
            return 50;
        }
        if (Model.ListArr.count > 1) {
            return 60 *Model.ListArr.count;
        }else{
            return 110 *Model.ListArr.count;
        }
    }else if (tableView.tag == 24){
        Model = _dataFiveArray[indexPath.section];
        if (indexPath.row == 0) {
            return 40;
        }else if (indexPath.row == Model.ListArr.count+1){
            return 50;
        }
        if (Model.ListArr.count > 1) {
            return 60  *Model.ListArr.count;
        }else{
            return 110 *Model.ListArr.count;
        }
    }
    return 230;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 20 || tableView.tag == 21 ||tableView.tag == 24 || tableView.tag == 23) {
        
        OrderDetailsVC *Details = [[OrderDetailsVC alloc]init];
        if (tableView.tag == 20) {
            Model = _dataOneArray[indexPath.section];
            Details.IsHidden = @"YES";
            
        }else if (tableView.tag == 21){
            Model = _dataTwoArray[indexPath.section];
            Details.IsHidden = @"HONO";
        }else if (tableView.tag == 23){
            Model = _dataFourArray[indexPath.section];
            Details.IsHidden = @"YESNO";
        }else if (tableView.tag == 24){
            Model = _dataFiveArray[indexPath.section];
            Details.IsHidden = @"NO";
        }
        Details.OrderId = Model.MyOrderId;
        Details.OrderSumPrice = Model.MyOrderSumPrice;
        Details.OrderFkGoodBaseId = Model.MyOrderFkGoodBaseId;
        
        Details.OrderSinglePrice = Model.MyOrderGoodSinglePrice;
        Details.OrderGoodBasePhotoUrl = Model.MyOrderStoreGoodBasePhotoUrl;
        Details.OrderStoreName = Model.MyOrderStoreName;
        Details.OrderGoodBaseName = Model.MyOrderStoreGoodBaseName;
        Details.OrderReceiveName = Model.MyOrderReceiveName;
        Details.OrderReceiveTime = Model.MyOrderCreateTime;
        Details.OrderReceivePhone = Model.MyOrderReceivePhone;
        Details.OrderReceiveAddress = Model.MyOrderReceiveAddress;
        [self.navigationController pushViewController:Details animated:YES];
        
    }else if (tableView.tag == 22){
        ThirdOrderDetailsVC *Details = [[ThirdOrderDetailsVC alloc]init];
        Details.OrderId = Model.MyOrderId;
        Details.OrderFkGoodBaseId = Model.MyOrderFkGoodBaseId;
        Details.OrderSumPrice = Model.MyOrderSumPrice;
        Details.OrderSinglePrice = Model.MyOrderGoodSinglePrice;
        Details.OrderGoodBasePhotoUrl = Model.MyOrderStoreGoodBasePhotoUrl;
        Details.OrderStoreName = Model.MyOrderStoreName;
        Details.OrderGoodBaseName = Model.MyOrderStoreGoodBaseName;
        [self.navigationController pushViewController:Details animated:YES];
    }
}

-(void)PingJia:(UIButton *)PTn
{
    Model = _dataThreeArray[PTn.tag];
    ThirdOrderDetailsVC *Details = [[ThirdOrderDetailsVC alloc]init];
    Details.OrderId = Model.MyOrderId;
    Details.OrderFkGoodBaseId =  Model.MyOrderFkGoodBaseId;
    Details.OrderSumPrice = Model.MyOrderSumPrice;
    Details.OrderSinglePrice = Model.MyOrderGoodSinglePrice;
    Details.OrderGoodBasePhotoUrl = Model.MyOrderStoreGoodBasePhotoUrl;
    Details.OrderStoreName = Model.MyOrderStoreName;
    Details.OrderGoodBaseName = Model.MyOrderStoreGoodBaseName;
    [self.navigationController pushViewController:Details animated:YES];
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
    if (tableView.tag == 20) {
        if (indexPath.row == 0) {
            MyOrderCellFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"First"];
            if (!cell) {
                cell = [[MyOrderCellFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"First"];
            }
            Model = _dataOneArray[indexPath.section];
            cell.DaiFuTitle.text = @"待付款";
            [cell configWithModel:Model];
            [cell.contentView addSubview:cell.DaiFuTitle];
            return cell;
        }else if (indexPath.row == Model.ListArr.count+1){
            MyOrderCellFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Four"];
            if (!cell) {
                cell = [[MyOrderCellFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Four"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    deleteBtn.layer.borderColor = kAppLineColor.CGColor;
                    deleteBtn.layer.borderWidth = 1;
                    deleteBtn.tag = indexPath.section;
                    [deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [deleteBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                    [deleteBtn addTarget:self action:@selector(Btn:) forControlEvents:UIControlEventTouchUpInside];
                    deleteBtn.frame = CGRectMake(kScreenWidth - 160, CGRectGetMaxY(cell.SpHEjiTitle.frame)+10, 65, 30);
                    UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [modifyBtn setTitle:@"支付" forState:UIControlStateNormal];
                    modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [modifyBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                    modifyBtn.layer.borderColor = kAppLineColor.CGColor;
                    modifyBtn.tag = indexPath.section;
                    modifyBtn.layer.borderWidth = 1;
                    modifyBtn.frame = CGRectMake(kScreenWidth - 90, CGRectGetMaxY(cell.SpHEjiTitle.frame)+10, 65, 30);
                    [modifyBtn addTarget:self action:@selector(Bt:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.contentView addSubview:deleteBtn];
                    [cell.contentView addSubview:modifyBtn];
                });
                Model = _dataOneArray[indexPath.section];
                cell.SpHEjiTitle      = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-210, 10, 200, 20)];
                cell.SpHEjiTitle.adjustsFontSizeToFitWidth = YES;
                cell.SpHEjiTitle.font = [UIFont systemFontOfSize:16];
                cell.SpHEjiTitle.text = [NSString stringWithFormat:@"共%@件商品 合计:¥%@元",Model.MyOrderGoodCount,Model.MyOrderSumPrice];
                [cell.contentView addSubview:cell.SpHEjiTitle];
            }
            return cell;
        }
        if (Model.ListArr.count > 1) {
            OrderDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirsDe"];
            if (!cell) {
                cell = [[OrderDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirsDe"];
                for (NSDictionary *Dic in Model.ListArr) {
                    XModel = [[OrderDeModel alloc]init];
                    [XModel setDic:Dic];
                    [_PingArray addObject:XModel];
                    
                }
                //            [_firstView reloadData];
                XModel = _PingArray[indexPath.row];
                [cell configWithModel:XModel];
            }
            return cell;
        }else{
            MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeHe"];
            if(cell == nil)
            {
                cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeHe"];
                Model = _dataOneArray[indexPath.section];
                [cell configWithModel:Model];
            }
            return cell;
        }
    }else if (tableView.tag == 21) {
        if (indexPath.row == 0) {
            MyOrderCellFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TWos"];
            if (!cell) {
                cell = [[MyOrderCellFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TWos"];
            }
            Model = _dataTwoArray[indexPath.section];
            cell.DaiFuTitle.text = @"服务进行中";
            [cell configWithModel:Model];
            [cell.contentView addSubview:cell.DaiFuTitle];
            return cell;
        }else if (indexPath.row == Model.ListArr.count+1){
            MyOrderCellFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Twops"];
            if (!cell) {
                cell = [[MyOrderCellFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Twops"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [modifyBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                    modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [modifyBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                    modifyBtn.layer.borderColor = kAppLineColor.CGColor;
                    modifyBtn.tag = indexPath.section;
                    modifyBtn.layer.borderWidth = 1;
                    modifyBtn.frame = CGRectMake(kScreenWidth - 90, CGRectGetMaxY(cell.SpHEjiTitle.frame)+10, 65, 30);
                    [modifyBtn addTarget:self action:@selector(QRShouhuo:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.contentView addSubview:modifyBtn];
                });
                Model = _dataTwoArray[indexPath.section];
                cell.SpHEjiTitle      = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-210, 10, 200, 20)];
                cell.SpHEjiTitle.adjustsFontSizeToFitWidth = YES;
                cell.SpHEjiTitle.font = [UIFont systemFontOfSize:16];
                cell.SpHEjiTitle.text = [NSString stringWithFormat:@"共%@件商品 合计:¥%@元",Model.MyOrderGoodCount,Model.MyOrderSumPrice];
                [cell.contentView addSubview:cell.SpHEjiTitle];
            }
            return cell;
        }
        if (Model.ListArr.count > 1) {
            OrderDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoDR"];
            if (!cell) {
                cell = [[OrderDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwoDR"];
                for (NSDictionary *Dic in Model.ListArr) {
                    XModel = [[OrderDeModel alloc]init];
                    [XModel setDic:Dic];
                    [_PingArray addObject:XModel];
                    
                }
                //                [_firstView reloadData];
                XModel = _PingArray[indexPath.row];
                [cell configWithModel:XModel];
            }
            return cell;
        }else{
            MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoGTH"];
            if(cell == nil)
            {
                cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwoGTH"];
                
                Model = _dataTwoArray[indexPath.section];
                [cell configWithModel:Model];
            }
            return cell;
        }
    }else if (tableView.tag == 22) {
        if (indexPath.row == 0) {
            MyOrderCellFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Threes"];
            if (!cell) {
                cell = [[MyOrderCellFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Threes"];
            }
            Model = _dataThreeArray[indexPath.section];
            cell.DaiFuTitle.text = @"交易完成";
            [cell configWithModel:Model];
            [cell.contentView addSubview:cell.DaiFuTitle];
            return cell;
        }else if (indexPath.row == Model.ListArr.count+1){
            MyOrderCellFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Three"];
            if (!cell) {
                cell = [[MyOrderCellFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Three"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    deleteBtn.layer.borderColor = kAppLineColor.CGColor;
                    deleteBtn.layer.borderWidth = 1;
                    deleteBtn.tag = indexPath.section;
                    [deleteBtn setTitle:@"申请退货" forState:UIControlStateNormal];
                    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [deleteBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                    [deleteBtn addTarget:self action:@selector(AppReturnBtn:) forControlEvents:UIControlEventTouchUpInside];
                    deleteBtn.frame = CGRectMake(kScreenWidth - 160, CGRectGetMaxY(cell.SpHEjiTitle.frame)+10, 65, 30);
                    UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [modifyBtn setTitle:@"评价" forState:UIControlStateNormal];
                    modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [modifyBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                    modifyBtn.layer.borderColor = kAppLineColor.CGColor;
                    modifyBtn.tag = indexPath.section;
                    modifyBtn.layer.borderWidth = 1;
                    modifyBtn.frame = CGRectMake(kScreenWidth - 90, CGRectGetMaxY(cell.SpHEjiTitle.frame)+10, 65, 30);
                    [modifyBtn addTarget:self action:@selector(PingJia:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.contentView addSubview:deleteBtn];
                    [cell.contentView addSubview:modifyBtn];
                });
                Model = _dataThreeArray[indexPath.section];
                cell.SpHEjiTitle      = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-210, 10, 200, 20)];
                cell.SpHEjiTitle.adjustsFontSizeToFitWidth = YES;
                cell.SpHEjiTitle.font = [UIFont systemFontOfSize:16];
                cell.SpHEjiTitle.text = [NSString stringWithFormat:@"共%@件商品 合计:¥%@元",Model.MyOrderGoodCount,Model.MyOrderSumPrice];
                [cell.contentView addSubview:cell.SpHEjiTitle];
            }
            return cell;
        }
        if (Model.ListArr.count > 1) {
            OrderDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirsDR"];
            if (!cell) {
                cell = [[OrderDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirsDR"];
                for (NSDictionary *Dic in Model.ListArr) {
                    XModel = [[OrderDeModel alloc]init];
                    [XModel setDic:Dic];
                    [_PingArray addObject:XModel];
                    
                }
                //                [_firstView reloadData];
                XModel = _PingArray[indexPath.row];
                [cell configWithModel:XModel];
            }
            return cell;
        }else{
            MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GTH"];
            if(cell == nil)
            {
                cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GTH"];
                
                Model = _dataThreeArray[indexPath.section];
                [cell configWithModel:Model];
            }
            return cell;
        }
    }else if (tableView.tag == 23){
        if (indexPath.row == 0) {
            MyOrderCellFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourTh"];
            if (!cell) {
                cell = [[MyOrderCellFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FourTh"];
                
            }
            Model = _dataFourArray[indexPath.section];
            cell.DaiFuTitle.text = @"退货中";
            [cell.contentView addSubview:cell.DaiFuTitle];
            [cell configWithModel:Model];
            return cell;
        }else if (indexPath.row == Model.ListArr.count+1){
            MyOrderCellFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourG"];
            if (!cell) {
                cell = [[MyOrderCellFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FourG"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    deleteBtn.layer.borderColor = kAppLineColor.CGColor;
                    deleteBtn.layer.borderWidth = 1;
                    deleteBtn.tag = indexPath.section;
                    [deleteBtn setTitle:@"查看退货" forState:UIControlStateNormal];
                    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [deleteBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                    [deleteBtn addTarget:self action:@selector(TuiHtn:) forControlEvents:UIControlEventTouchUpInside];
                    deleteBtn.frame = CGRectMake(kScreenWidth - 100, 10, 65, 30);
                    [cell.contentView addSubview:deleteBtn];
                });
                Model = _dataFourArray[indexPath.section];
                NSLog(@"这四年%ld %@",(unsigned long)_dataFourArray.count,Model.MyOrderSumPrice);
                //                        NSLog(@"你这T%@",Model.MyOrderSumPrice);
                cell.SpHEjiTitle      = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
                cell.SpHEjiTitle.adjustsFontSizeToFitWidth = YES;
                cell.SpHEjiTitle.font = [UIFont systemFontOfSize:16];
                cell.SpHEjiTitle.text = [NSString stringWithFormat:@"合计:%@元",Model.MyOrderSumPrice];
                [cell.contentView addSubview:cell.SpHEjiTitle];
            }
            return cell;
        }
        if (Model.ListArr.count > 1) {
            OrderDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirsDT"];
            if (!cell) {
                cell = [[OrderDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirsDT"];
                for (NSDictionary *Dic in Model.ListArr) {
                    XModel = [[OrderDeModel alloc]init];
                    [XModel setDic:Dic];
                    [_PingArray addObject:XModel];
                }
                //                [_firstView reloadData];
                XModel = _PingArray[indexPath.row];
                [cell configWithModel:XModel];
            }
            return cell;
        }else{
            MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fivews"];
            if(cell == nil)
            {
                cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Fivews"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                Model = _dataFourArray[indexPath.section];
                [cell configWithModel:Model];
            });
            return cell;
        }
    }else if (tableView.tag == 24){
        if (indexPath.row == 0) {
            MyOrderCellFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Five"];
            if (!cell) {
                cell = [[MyOrderCellFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Five"];
                
            }
            Model = _dataFiveArray[indexPath.section];
            [cell configWithModel:Model];
            return cell;
        }else if (indexPath.row == Model.ListArr.count+1){
            MyOrderCellFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiveTh"];
            if (!cell) {
                cell = [[MyOrderCellFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FiveTh"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    deleteBtn.layer.borderColor = kAppLineColor.CGColor;
                    deleteBtn.layer.borderWidth = 1;
                    deleteBtn.tag = indexPath.section;
                    [deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [deleteBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
                    [deleteBtn addTarget:self action:@selector(BYtn:) forControlEvents:UIControlEventTouchUpInside];
                    deleteBtn.frame = CGRectMake(kScreenWidth - 100, 10, 65, 30);
                    [cell.contentView addSubview:deleteBtn];
                });
                Model = _dataFiveArray[indexPath.section];
                cell.SpHEjiTitle      = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
                cell.SpHEjiTitle.adjustsFontSizeToFitWidth = YES;
                cell.SpHEjiTitle.font = [UIFont systemFontOfSize:16];
                cell.SpHEjiTitle.text = [NSString stringWithFormat:@"合计:%@元",Model.MyOrderSumPrice];
            }
            [cell.contentView addSubview:cell.SpHEjiTitle];
            return cell;
        }
        if (Model.ListArr.count > 1) {
            OrderDeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirsDT"];
            if (!cell) {
                cell = [[OrderDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirsDT"];
                for (NSDictionary *Dic in Model.ListArr) {
                    XModel = [[OrderDeModel alloc]init];
                    [XModel setDic:Dic];
                    [_PingArray addObject:XModel];
                }
                //                [_firstView reloadData];
                XModel = _PingArray[indexPath.row];
                [cell configWithModel:XModel];
            }
            return cell;
        }else{
            MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiveTw"];
            if(cell == nil)
            {
                cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FiveTw"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                Model = _dataFiveArray[indexPath.section];
                [cell configWithModel:Model];
            });
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Gj"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GJ"];
    }
    return cell;
}

-(void)QRShouhuo:(UIButton *)QRBtn
{
    __weak typeof(self) weakSelf = self;
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"我已收到货,同意付款!"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            Model = _dataTwoArray[QRBtn.tag];
            ThirdOrderDetailsVC *Details = [[ThirdOrderDetailsVC alloc]init];
            Details.OrderId = Model.MyOrderId;
            Details.OrderFkGoodBaseId = Model.MyOrderFkGoodBaseId;
            Details.OrderSumPrice = Model.MyOrderSumPrice;
            Details.OrderSinglePrice = Model.MyOrderGoodSinglePrice;
            Details.OrderGoodBasePhotoUrl = Model.MyOrderStoreGoodBasePhotoUrl;
            Details.OrderStoreName = Model.MyOrderStoreName;
            Details.OrderGoodBaseName = Model.MyOrderStoreGoodBaseName;
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":Model.MyOrderId} url:UrL_QRShouHuo success:^(id responseObject) {
                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
            } failure:^(NSError *error) {
            }];
            [weakSelf.navigationController pushViewController:Details animated:YES];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)BtGdn:(UIButton *)Gd
{
    NSLog(@"删除历史订单");
}

-(void)TuiHtn:(UIButton *)TH
{
    //查看退货
    Model = _dataFourArray[TH.tag];
    ApplicationForReturnVC *Forreturn = [[ApplicationForReturnVC alloc]init];
    Forreturn.ChooseUI = @"OK";
    Forreturn.OrderId = Model.MyOrderId;
    [self.navigationController pushViewController:Forreturn animated:YES];
}

-(void)Btn:(UIButton *)Btn
{
    __weak typeof(self) weakSelf = self;
    Model = _dataOneArray[Btn.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定删除该订单？"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":Model.MyOrderId} url:UrL_OrderDelete success:^(id responseObject) {
//                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                [weakSelf.dataOneArray removeObject:weakSelf.dataOneArray[Btn.tag]];
                [weakSelf.firstView    reloadData];
            } failure:^(NSError *error) {
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)BYtn:(UIButton *)Btg
{
    __weak typeof(self) weakSelf = self;
    Model = _dataFiveArray[Btg.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定删除该订单？"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"orderId":Model.MyOrderId} url:UrL_OrderDelete success:^(id responseObject) {
//                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                [weakSelf.dataFiveArray removeObject:weakSelf.dataFiveArray[Btg.tag]];
                [weakSelf.fiveView    reloadData];
            } failure:^(NSError *error) {
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)AppReturnBtn:(UIButton *)BG
{
    //申请退货
    Model = _dataThreeArray[BG.tag];
    ApplicationForReturnVC *Forreturn = [[ApplicationForReturnVC alloc]init];
    Forreturn.OrderId = Model.MyOrderId;
    Forreturn.ChooseUI = @"NOOK";
    [self.navigationController pushViewController:Forreturn animated:YES];
}

-(void)Bt:(UIButton *)Bt
{
    //    NSLog(@"支付");
    Model = _dataOneArray[Bt.tag];
    PayMoneyOrderVC *Pay = [[PayMoneyOrderVC alloc]init];
    NSLog(@"你妹%@",Model.MyOrderSumPrice);
    Pay.SumPrice =  [Model.MyOrderSumPrice doubleValue];
    Pay.OrderId  =  Model.MyOrderId;
    Pay.PayMoneyChoose = @"SpBuy";
    [self.navigationController pushViewController:Pay animated:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"我的订单";
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

-(void)click:(UIButton *)Bt
{
    NSLog(@"g%@",self.PayTit);
    if ([self.PayTit isEqualToString:@"AlL"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
