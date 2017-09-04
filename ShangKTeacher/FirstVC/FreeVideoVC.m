//
//  FreeVideoVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FreeVideoVC.h"
#import "FreeBengCell.h"
#import "FreeBengModel.h"
#import "EveryVideosVC.h"
@interface FreeVideoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
    UITableView    *_TableView;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation FreeVideoVC

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
    [self createTableView];
    if ([self.NAvTit isEqualToString:@"免费课程"]) {
        [self createData];
    }else{
        [self createDAtaTwo];
    }
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak FreeVideoVC *weakSelf = self;
    _TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        if ([self.NAvTit isEqualToString:@"免费课程"]) {
            [weakSelf createData];
        }else{
            [weakSelf createDAtaTwo];
        }
        
    }];
}
//上拉加载
- (void)updown {
    __weak FreeVideoVC *weakSelf = self;
    _TableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        _page ++;
        _isPulling = NO;
        if (_page >= 50) {
            [_TableView.mj_footer endRefreshing];
            return ;
        } else {
            if ([self.NAvTit isEqualToString:@"免费课程"]) {
                [weakSelf createData];
            }else{
                [weakSelf createDAtaTwo];
            }
        }
    }];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_TableView];
}

-(void)createDAtaTwo
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"status":@2,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_VideoCourseSellCount success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        if (_isPulling) {
            [_dataArray removeAllObjects];
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *ARR = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in ARR) {
            FreeBengModel *Model = [[FreeBengModel alloc]init];
            [Model setDic:dict];
            [_dataArray addObject:Model];
        }
        NSLog(@"--=_%ld",(long)_dataArray.count);
        if (_isPulling) {
            [_TableView.mj_header endRefreshing];
        }else{
            [_TableView.mj_footer endRefreshing];
        }
        [_TableView reloadData];
        
    } failure:^(NSError *error) {
    }];
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"status":@1,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        NSLog(@"看看免费的%@",responseObject);
        if (_isPulling) {
            [_dataArray removeAllObjects];
        }
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *ARR = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in ARR) {
            FreeBengModel *Model = [[FreeBengModel alloc]init];
            [Model setDic:dict];
            [_dataArray addObject:Model];
        }
        if (_isPulling) {
            [_TableView.mj_header endRefreshing];
        }else{
            [_TableView.mj_footer endRefreshing];
        }
        [_TableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FreeBengModel *Model = _dataArray[indexPath.row];
    EveryVideosVC *video = [[EveryVideosVC alloc]init];
    if ([self.NAvTit isEqualToString:@"免费课程"]) {
        video.CouldHelp = @"Free";
    }else{
        video.CouldHelp = @"Charge";
    }
    video.videoCourseId = Model.FreeCourseId;
    video.videoCourseName = Model.FreeCourseName;
    video.videoCoursePrice = Model.FreeCourseprice;
    video.videoCourseSellCount = Model.FreeCourseSellCount;
    [self.navigationController pushViewController:video animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.NAvTit isEqualToString:@"免费课程"]) {
        FreeBengCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoKK"];
        
        if (!cell) {
            
            cell = [[FreeBengCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoKK"];
        }
        FreeBengModel *Model = _dataArray[indexPath.row];
        cell.FreeCoursePriceLabel.text = @"免费";
        [cell configWithModel:Model];
        return cell;
    }
    FreeBengCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Vide"];
    
    if (!cell) {
        
        cell = [[FreeBengCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Vide"];
    }
    FreeBengModel *Model = _dataArray[indexPath.row];
    cell.FreeCoursePriceLabel.text = [NSString stringWithFormat:@"¥%@",Model.FreeCourseprice];
    [cell configWithModel:Model];
    return cell;
}
-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = self.NAvTit;
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
