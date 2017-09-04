//
//  MyVideos.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyVideos.h"
#import "AppDelegate.h"
#import "MyVideosCell.h"
#import "MyVideosModel.h"
#import "ArrowView.h"
#import "EveryVideosVC.h"
#import "HSDownloadManager.h"
#import "MyVideoPinaJiaVC.h"

@interface MyVideos ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_topView;
    UITableView  * _secondView;
    NSMutableArray *_DataTwoArray;
    UIScrollView * _mainScrollView;
    ArrowView    * _arrowView;
    NSInteger      _page;
    BOOL           _isPulling;
}
@property(nonatomic, strong)UIButton *btnSelected;
@end

@implementation MyVideos
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
    self.fd_interactivePopDisabled = YES;
    _DataOneArray = [NSMutableArray array];
    _DataTwoArray = [NSMutableArray array];
    _DataThreeArray = [NSMutableArray array];
    [self createNav];
    [self createTopView];
    [self initMainScrollView];
    [self createDataOne];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak MyVideos *weakSelf = self;
    UITableView *Table = [self.view viewWithTag:10];
    if (Table) {
        _firstView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createDataOne];
        }];
    }
    if (_secondView){
        _secondView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createDataTwo];
        }];
    }
    if(_thirdView){
        _thirdView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 0;
            _isPulling = YES;
            [weakSelf createDataThree];
        }];
    }
    
}
//上拉加载
- (void)updown {
    __weak MyVideos *weakSelf = self;
    if (_firstView) {
        _firstView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_firstView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createDataOne];
            }
        }];
    }
    if (_secondView){
        _secondView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_secondView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createDataTwo];
            }
        }];
    }
    if(_thirdView){
        _thirdView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            _page ++;
            _isPulling = NO;
            if (_page >= 50) {
                [_thirdView.mj_footer endRefreshing];
                return ;
            } else {
                [weakSelf createDataThree];
            }
        }];
    }
}

-(void)createDataOne
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"condition":@1,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_MyVideoS success:^(id responseObject) {
        NSLog(@"已观看的%@",responseObject);
        if (_isPulling) {
            [_DataOneArray removeAllObjects];
        }
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *RootArr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in RootArr) {
            NSDictionary *dic = [Dict objectForKey:@"videoCourse"];
            MyVideosModel *Model = [[MyVideosModel alloc]init];
            [Model setDic:dic];
            [_DataOneArray addObject:Model];
        }
        if (_isPulling) {
            [_firstView.mj_header endRefreshing];
        }else{
            [_firstView.mj_footer endRefreshing];
        }
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createDataTwo
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"condition":@2,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_MyVideoS success:^(id responseObject) {
        NSLog(@"看看看%@",responseObject);
        if (_isPulling) {
            [_DataTwoArray removeAllObjects];
        }
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *RootArr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in RootArr) {
            NSDictionary *dic = [Dict objectForKey:@"videoCourse"];
            MyVideosModel *Model = [[MyVideosModel alloc]init];
            [Model setDic:dic];
            [_DataTwoArray addObject:Model];
        }
        if (_isPulling) {
            [_secondView.mj_header endRefreshing];
        }else{
            [_secondView.mj_footer endRefreshing];
        }
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createDataThree
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"condition":@3,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_MyVideoS success:^(id responseObject) {
        NSLog(@"已下载%@",responseObject);
        if (_isPulling) {
            [_DataThreeArray removeAllObjects];
        }
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *RootArr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in RootArr) {
            NSDictionary *dic = [Dict objectForKey:@"videoCourse"];
            MyVideosModel *Model = [[MyVideosModel alloc]init];
            [Model setDic:dic];
            [_DataThreeArray addObject:Model];
        }
        if (_isPulling) {
            [_thirdView.mj_header endRefreshing];
        }else{
            [_thirdView.mj_footer endRefreshing];
        }
        [_thirdView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)initMainScrollView
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,104, kScreenWidth, kScreenHeight-104)];
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag = 10;
    _firstView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag = 11;
    _secondView.delegate = self;
    _secondView.dataSource = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    
    _thirdView = [[UITableView alloc]initWithFrame:CGRectMake(2*width, 0,width,height) style:UITableViewStyleGrouped];
    _thirdView.tag = 12;
    _thirdView.delegate = self;
    _thirdView.dataSource = self;
    _thirdView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _thirdView.showsVerticalScrollIndicator=NO;
    
    _mainScrollView.contentSize = CGSizeMake(width*3, 0);
    _mainScrollView.pagingEnabled = YES;
    
    [_mainScrollView addSubview:_firstView];
    [_mainScrollView addSubview:_secondView];
    [_mainScrollView addSubview:_thirdView];
    [self.view addSubview:_mainScrollView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 10) {
        return _DataOneArray.count;
    }else if (tableView.tag == 11){
        return _DataTwoArray.count;
    }
    return _DataThreeArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    if (tableView.tag == 11 ||tableView.tag == 10){
        return 150;
    }
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        MyVideosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoOne"];
        if (!cell) {
            cell = [[MyVideosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoOne"];
        }
        MyVideosModel *Model = _DataOneArray[indexPath.section];
        [cell configWithModel:Model];
        NSString * timeStampString = Model.MyVideosCreateime;
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
        NSString *time = [objDateformat stringFromDate: date];
        cell.MyVideosTime.text = [NSString stringWithFormat:@"观看时间:%@",time];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(kScreenWidth-40, 35, 30, 30);
            button.tag = indexPath.section;
            [button setBackgroundImage:[UIImage imageNamed:@"删除@2x.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(ReadyDelete:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *LineLabel      = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cell.MyVideosPhoto.frame)+10, kScreenWidth, 1)];
            LineLabel.alpha         = 0.5;
            LineLabel.backgroundColor = kAppLineColor;
            cell.PingJiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cell.PingJiaBtn.frame  = CGRectMake(kScreenWidth - 100, CGRectGetMaxY(cell.MyVideosPhoto.frame)+15, 90, 40);
            cell.PingJiaBtn.layer.borderColor = kAppLineColor.CGColor;
            cell.PingJiaBtn.layer.borderWidth = 1;
            [cell.PingJiaBtn setTitle:@"评价" forState:UIControlStateNormal];
            [cell.PingJiaBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            [cell.PingJiaBtn addTarget:self action:@selector(PingJiaA:) forControlEvents:UIControlEventTouchUpInside];
            cell.PingJiaBtn.tag = indexPath.section;
            [cell.contentView addSubview:cell.PingJiaBtn];
            [cell.contentView addSubview:button];
            [cell.contentView addSubview:LineLabel];
        });

        return cell;
    }else if (tableView.tag == 11){
        MyVideosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoTwo"];
        if (!cell) {
            cell = [[MyVideosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoTwo"];
        }
        MyVideosModel *Model    = _DataTwoArray[indexPath.section];
        [cell configWithModel:Model];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * timeStampString = Model.MyVideosCreateime;
            NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
            NSString *time = [objDateformat stringFromDate: date];
            cell.MyVideosTime.text = [NSString stringWithFormat:@"观看时间:%@",time];
            cell.MyVideosPrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.MyVideosPhoto.frame)+10, CGRectGetMaxY(cell.MyVideosName.frame)+7, kScreenWidth-90, 20)];
            cell.MyVideosPrice.text = [NSString stringWithFormat:@"¥%@",Model.MyVideosPrice];
            cell.MyVideosPrice.font = [UIFont boldSystemFontOfSize:15];
            cell.MyVideosPrice.textColor = kAppRedColor;
            UILabel *LineLabel      = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cell.MyVideosPhoto.frame)+10, kScreenWidth, 1)];
            LineLabel.alpha         = 0.5;
            LineLabel.backgroundColor = kAppLineColor;
            cell.MyVideosBTn = [UIButton buttonWithType:UIButtonTypeCustom];
            cell.MyVideosBTn.frame  = CGRectMake(kScreenWidth - 100, CGRectGetMaxY(cell.MyVideosPhoto.frame)+15, 90, 40);
            cell.MyVideosBTn.layer.borderColor = kAppLineColor.CGColor;
            cell.MyVideosBTn.layer.borderWidth = 1;
            UIImageView *imageView  =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
            imageView.image         = [UIImage imageNamed:@"下载7@2x_36.png"];
            UILabel *Label          = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+6, 10, 40, 20)];
            Label.text              = @"下载";
            Label.font              = [UIFont systemFontOfSize:17];
            cell.MyVideosBTn.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [cell.MyVideosBTn addSubview:Label];
            [cell.MyVideosBTn addSubview:imageView];
            cell.MyVideosBTn.tag = indexPath.section;
            [cell.MyVideosBTn addTarget:self action:@selector(Download:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:cell.MyVideosBTn];
            [cell.contentView addSubview:cell.MyVideosPrice];
            [cell.contentView addSubview:LineLabel];
        });
        return cell;
    }
    MyVideosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoThree"];
    if (!cell) {
        cell = [[MyVideosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoThree"];
    }
    MyVideosModel *Model = _DataThreeArray[indexPath.section];
    dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-40, 35, 30, 30);
    button.tag = indexPath.section;
    [button setBackgroundImage:[UIImage imageNamed:@"删除@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ReadyDele:) forControlEvents:UIControlEventTouchUpInside];
    [cell configWithModel:Model];
    [cell.contentView addSubview:button];
        NSString * timeStampString = Model.MyVideosCreateime;
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
        NSString *time = [objDateformat stringFromDate: date];
        cell.MyVideosTime.text = [NSString stringWithFormat:@"观看时间:%@",time];

    });
    return cell;
}

-(void)PingJiaA:(UIButton *)Bt
{
    NSLog(@"速速围观%ld",(long)Bt.tag);
    MyVideosModel *Model = _DataOneArray[Bt.tag];
    MyVideoPinaJiaVC *PinaJ = [[MyVideoPinaJiaVC alloc]init];
    PinaJ.VideoId = Model.MyVideosId;
    [self.navigationController pushViewController:PinaJ animated:YES];
}

-(void)ReadyDele:(UIButton *)Btn
{
    MyVideosModel *Model = _DataThreeArray[Btn.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    __weak typeof(self) weakSelf = self;
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定删除已下载课程吗？"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"videoUserId":Model.MyVideosFkVideoUserId} url:UrL_DeleteDownLloadVideo success:^(id responseObject) {
//                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    [weakSelf.DataThreeArray removeObject:weakSelf.DataThreeArray[Btn.tag]];
                    [weakSelf.thirdView reloadData];
                    [[HSDownloadManager sharedInstance] deleteFile:[NSString stringWithFormat:@"%@%@",BASEURL,Model.MyVideosVideoUrl]];
                });
            } failure:^(NSError *error) {
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)ReadyDelete:(UIButton *)BTN
{
    MyVideosModel *Model = _DataOneArray[BTN.tag];
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    __weak typeof(self) weakSelf = self;
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定删除已观看课程吗？"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"videoUserId":Model.MyVideosFkVideoUserId} url:UrL_DeleteAleradySeeVideo success:^(id responseObject) {
//                [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
                    [weakSelf.DataOneArray removeObject:weakSelf.DataOneArray[BTN.tag]];
                    [weakSelf.firstView reloadData];
                });
            } failure:^(NSError *error) {
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EveryVideosVC *video =[[EveryVideosVC alloc]init];
    if (tableView.tag == 10) {
        MyVideosModel *Model =_DataOneArray[indexPath.section];
        video.CouldHelp = @"Free";
        video.videoCourseId = Model.MyVideosId;
        video.videoCourseName = Model.MyVideosName;
        video.videoCoursePrice = Model.MyVideosPrice;
        video.videoCourseSellCount = Model.MyVideosSellCount;
    }else if (tableView.tag == 11){
        MyVideosModel *Model =_DataTwoArray[indexPath.section];
        video.CouldHelp = @"Free";
        video.videoCourseId = Model.MyVideosId;
        video.videoCourseName = Model.MyVideosName;
        video.videoCoursePrice = Model.MyVideosPrice;
        video.videoCourseSellCount = Model.MyVideosSellCount;
        
    }else{
        MyVideosModel *Model =_DataThreeArray[indexPath.section];
        video.CouldHelp = @"Free";
        video.videoCourseId = Model.MyVideosId;
        video.videoCourseName = Model.MyVideosName;
        video.videoCoursePrice = Model.MyVideosPrice;
        video.videoCourseSellCount = Model.MyVideosSellCount;
    }
    [self.navigationController pushViewController:video animated:YES];
}

-(void)Download:(UIButton *)tn
{
    FbwManager *Manager = [FbwManager shareManager];
    NSLog(@"%ld",(long)tn.tag);//下载
    MyVideosModel *Model = _DataTwoArray[tn.tag];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"videoCourseId":Model.MyVideosId} url:UrL_DownLoadMyVideoS success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSLog(@"成功%@",Model.MyVideosId);
    } failure:^(NSError *error) {
    }];
}

-(void)createTopView
{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,40)];
    _topView.backgroundColor = kAppWhiteColor;
    NSArray *arr = @[@"已观看的",@"已购买的",@"已下载的"];
    for (int i=0; i<3; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i+i*(kScreenWidth)/3, 0, (kScreenWidth)/3, 40);
        button.tag = 10+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kAppBlueColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(BtnVideo:)forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        if (button.tag == 10) {
            button.selected = YES;
            self.btnSelected = button;
        }
        [_topView addSubview:button];
    }
    [self.view addSubview:_topView];
}

//上下架
-(void)BtnVideo:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    
    if (btnSJ.tag == 10) {
        btnSJ.selected = YES;
        [_DataOneArray removeAllObjects];
        _page = 0;
        [self createDataOne];
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else if(btnSJ.tag == 11)
    {
        btnSJ.selected = YES;
        [_DataTwoArray removeAllObjects];
        _page = 0;
        [self createDataTwo];
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }else{
        btnSJ.selected = YES;
        [_DataThreeArray removeAllObjects];
        _page = 0;
        [self createDataThree];
        _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
    }
    self.btnSelected = btnSJ;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 140)/2, 10, 140, 30)];
    label.text = @"我的网络教学视频";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)Click:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
