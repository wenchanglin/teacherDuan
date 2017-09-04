//
//  EveryVideoStoreVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryVideoStoreVC.h"
#import "SearchModel.h"
#import "SearchCell.h"
#import "EveryVideosVC.h"
@interface EveryVideoStoreVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_topView;
    UITableView  * _firstView;
    UITableView  * _secondView;
    UITableView  * _thirdView;
    NSMutableArray *_DataOneArray;
    NSMutableArray *_DataTwoArray;
    NSMutableArray *_DataThreeArray;
    UIScrollView * _mainScrollView;
    //    int    NUmSelect;
}
@property(nonatomic, strong)UIButton *btnSelected;
@property(nonatomic, strong)UIButton *ImageSelected;
@property(nonatomic, strong)UIButton *EveryImageSelected;
@property(nonatomic, strong)UIButton *EverySecImageSelected;
@property(nonatomic, strong)UIButton *EveryThirdImageSelected;
@end
@implementation EveryVideoStoreVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _DataOneArray = [NSMutableArray array];
    _DataTwoArray = [NSMutableArray array];
    _DataThreeArray = [NSMutableArray array];
    [self createUI];
    [self initMainScrollView];
    [self createNav];
    [self createData];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"sort":@"sellCount",@"videoStoreId":self.videoStoreId,@"sortType":@"DESC"} url:UrL_VideoCourseSellCount success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        //        NSLog(@"快看%@",responseObject);
        [_DataOneArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataOneArray addObject:Model];
        }
        //        NSLog(@"哈%ld",_DataOneArray.count);
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTwoData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"sort":@"price",@"videoStoreId":self.videoStoreId,@"sortType":@"DESC"} url:UrL_VideoCourseSellCount success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        //        NSLog(@"快看%@",responseObject);
        [_DataTwoArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataTwoArray addObject:Model];
        }
        //        NSLog(@"哈%ld",_DataTwoArray.count);
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createThreeData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"sort":@"score",@"videoStoreId":self.videoStoreId,@"sortType":@"DESC"} url:UrL_VideoCourseSellCount success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        //        NSLog(@"快看%@",responseObject);
        [_DataThreeArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataThreeArray addObject:Model];
        }
        //        NSLog(@"哈%ld",_DataThreeArray.count);
        [_thirdView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)initMainScrollView
{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,kScreenHeight/3+10, kScreenWidth, kScreenHeight-kScreenHeight/3-10)];
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat height = _mainScrollView.frame.size.height;
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate = self;
    
    _firstView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStyleGrouped];
    _firstView.tag = 10;
    _firstView.delegate = self;
    _firstView.backgroundColor = kAppWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag = 11;
    _secondView.delegate = self;
    _secondView.backgroundColor = kAppWhiteColor;
    _secondView.dataSource = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    
    _thirdView = [[UITableView alloc]initWithFrame:CGRectMake(2*width, 0,width,height) style:UITableViewStyleGrouped];
    _thirdView.tag = 12;
    _thirdView.delegate = self;
    _thirdView.backgroundColor = kAppWhiteColor;
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
    if (tableView.tag == 10){
        return 100;
    }else if (tableView.tag == 11){
        return 100;
    }
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EveryVideosVC *video =[[EveryVideosVC alloc]init];
    if (tableView.tag == 10) {
        SearchModel *Model =_DataOneArray[indexPath.section];
        //            video.CouldHelp = @"Free";
        video.videoCourseId = Model.SearchId;
        video.videoCourseName = Model.SearchName;
        video.videoCoursePrice = Model.SearchPrice;
        video.videoCourseSellCount = Model.SearchSellCount;
    }else if (tableView.tag == 11){
        SearchModel *Model =_DataTwoArray[indexPath.section];
        //            video.CouldHelp = @"Free";
        video.videoCourseId = Model.SearchId;
        video.videoCourseName = Model.SearchName;
        video.videoCoursePrice = Model.SearchPrice;
        video.videoCourseSellCount = Model.SearchSellCount;
    }else{
        SearchModel *Model =_DataThreeArray[indexPath.section];
        //            video.CouldHelp = @"Charge";
        video.videoCourseId = Model.SearchId;
        video.videoCourseName = Model.SearchName;
        video.videoCoursePrice = Model.SearchPrice;
        video.videoCourseSellCount = Model.SearchSellCount;
    }
    [self.navigationController pushViewController:video animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchYOne"];
        if (!cell) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchYOne"];
        }
        SearchModel *Model = _DataOneArray[indexPath.section];
        //        if (NUmSelect == 1) {
        //            cell.SearchPrice.text = @"免费";
        //        }else{
        cell.SearchPrice.text = [NSString stringWithFormat:@"¥%@",Model.SearchPrice];
        //        }
        [cell.contentView addSubview:cell.SearchPrice];
        [cell configWithModel:Model];
        return cell;
    }else if (tableView.tag == 11){
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchYWne"];
        if (!cell) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchYWne"];
        }
        SearchModel *Model = _DataTwoArray[indexPath.section];
        //        if (NUmSelect == 1) {
        //            cell.SearchPrice.text = @"免费";
        //        }else{
        cell.SearchPrice.text = [NSString stringWithFormat:@"¥%@",Model.SearchPrice];
        //        }
        [cell.contentView addSubview:cell.SearchPrice];
        [cell configWithModel:Model];
        return cell;
        
    }else if (tableView.tag == 12){
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchYThree"];
        if (!cell) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchYThree"];
        }
        SearchModel *Model = _DataThreeArray[indexPath.section];
        //        if (NUmSelect == 1) {
        //            cell.SearchPrice.text = @"免费";
        //        }else{
        cell.SearchPrice.text = [NSString stringWithFormat:@"¥%@",Model.SearchPrice];
        //        }
        [cell.contentView addSubview:cell.SearchPrice];
        [cell configWithModel:Model];
        return cell;
        
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GT"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GT"];
    }
    return cell;
}

-(void)BtnVideo:(UIButton *)btnSJ
{
    UIButton *button = [self.view viewWithTag:btnSJ.tag+10];
    //    NSLog(@"%ld",button.tag);
    self.btnSelected.selected = NO;
    self.ImageSelected.selected = NO;
    if (btnSJ.tag == 10) {
        [self createData];
        btnSJ.selected = YES;
        button.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else if(btnSJ.tag == 11)
    {
        [self createTwoData];
        btnSJ.selected = YES;
        button.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }else if(btnSJ.tag == 12){
        [self createThreeData];
        btnSJ.selected = YES;
        button.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
    }
    else if(btnSJ.tag == 20){
        NSLog(@"扑通");
        btnSJ.selected = YES;
        button.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(0,0);
        for (int i=0; i<2; i++) {
            btnSJ.tag = 50+i;
            [btnSJ setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x.png"] forState:UIControlStateNormal];
            [btnSJ setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x_33.png"] forState:UIControlStateSelected];
            [btnSJ addTarget:self action:@selector(Btn:)forControlEvents:UIControlEventTouchUpInside];
            if (btnSJ.tag == 50) {
                btnSJ.selected = YES;
                self.EveryImageSelected = btnSJ;
            }else if (btnSJ.tag == 51){
                _mainScrollView.contentOffset = CGPointMake(0,0);
                btnSJ.selected = YES;
                [self createEvOneData];
            }
            [button addSubview:btnSJ];
            [_topView addSubview:button];
        }
    }else if(btnSJ.tag == 21){
        NSLog(@"扑通扑通");
        btnSJ.selected = YES;
        button.selected = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x_33.png"] forState:UIControlStateSelected];
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
        for (int i=0; i<2; i++) {
            btnSJ.tag = 60+i;
            [btnSJ setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x.png"] forState:UIControlStateNormal];
            [btnSJ setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x_33.png"] forState:UIControlStateSelected];
            [btnSJ addTarget:self action:@selector(BtYn:)forControlEvents:UIControlEventTouchUpInside];
            if (btnSJ.tag == 60) {
                btnSJ.selected = YES;
                self.EverySecImageSelected = btnSJ;
            }else if (btnSJ.tag == 61){
                _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
                btnSJ.selected = YES;
                [self createEvTwoData];
            }
            [button addSubview:btnSJ];
            [_topView addSubview:button];
        }
    }else if(btnSJ.tag == 22){
        NSLog(@"扑通扑通扑通");
        btnSJ.selected = YES;
        button.selected = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x_33.png"] forState:UIControlStateSelected];
        _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
        for (int i=0; i<2; i++) {
            btnSJ.tag = 70+i;
            [btnSJ setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x.png"] forState:UIControlStateNormal];
            [btnSJ setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x_33.png"] forState:UIControlStateSelected];
            [btnSJ addTarget:self action:@selector(BtJYn:)forControlEvents:UIControlEventTouchUpInside];
            if (btnSJ.tag == 70) {
                btnSJ.selected = YES;
                self.EveryThirdImageSelected = btnSJ;
            }else if (btnSJ.tag == 71){
                _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
                btnSJ.selected = YES;
                [self createEvThreeData];
            }
            [button addSubview:btnSJ];
            [_topView addSubview:button];
        }
    }
    self.btnSelected = btnSJ;
    self.ImageSelected = button;
}

-(void)Btn:(UIButton *)TBv
{
    self.EveryImageSelected.selected = NO;
    if (TBv.tag == 50) {
        
        TBv.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(0,0);
        NSLog(@"我也是");
    }else if(TBv.tag == 51){
        TBv.selected = YES;
        NSLog(@"😑搭");
        [self createEvOneData];
    }
    self.EveryImageSelected = TBv;
}

-(void)BtYn:(UIButton *)TBv
{
    self.EverySecImageSelected.selected = NO;
    if (TBv.tag == 60) {
        
        TBv.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
        NSLog(@"我也是");
    }else if(TBv.tag == 61){
        TBv.selected = YES;
        NSLog(@"😑搭");
        [self createEvTwoData];
    }
    self.EverySecImageSelected = TBv;
}

-(void)BtJYn:(UIButton *)TBv
{
    self.EveryThirdImageSelected.selected = NO;
    if (TBv.tag == 70) {
        
        TBv.selected = YES;
        _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
        NSLog(@"我也是");
    }else if(TBv.tag == 71){
        TBv.selected = YES;
        NSLog(@"😑搭");
        [self createEvThreeData];
    }
    self.EveryThirdImageSelected = TBv;
}

-(void)createEvThreeData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"sort":@"score",@"videoStoreId":self.videoStoreId,@"sortType":@"ASC"} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        [_DataThreeArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataThreeArray addObject:Model];
        }
        [_thirdView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createEvTwoData{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"sort":@"price",@"videoStoreId":self.videoStoreId,@"sortType":@"ASC"} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        [_DataTwoArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataTwoArray addObject:Model];
        }
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createEvOneData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"sort":@"sellCount",@"videoStoreId":self.videoStoreId,@"sortType":@"ASC"} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        [_DataOneArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataOneArray addObject:Model];
        }
        NSLog(@"哈%ld",(unsigned long)_DataOneArray.count);
        [_firstView reloadData];
        [self initMainScrollView];
    } failure:^(NSError *error) {
    }];
}


-(void)createUI
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight/3)];
    HeadView.backgroundColor = kAppOrangeColor;
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.userInteractionEnabled = NO;
    Btn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight/3-50);
    [Btn setBackgroundImage:[UIImage imageNamed:@"图层-122@2x.png"] forState:UIControlStateNormal];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, kScreenHeight/3-120, 60, 60)];
    imageView.image = [UIImage imageNamed:@"图层-80@2x.png"];
    UILabel *StoreName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, kScreenHeight/3-120, 200, 20)];
    StoreName.textColor = kAppWhiteColor;
    StoreName.text = self.videoStoreName;
    StoreName.font = [UIFont boldSystemFontOfSize:17];
    
    UILabel *StoreScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMaxY(StoreName.frame)+17, 40, 20)];
    StoreScoreLabel.font = [UIFont boldSystemFontOfSize:17];
    StoreScoreLabel.text = [NSString stringWithFormat:@"评分:"];
    StoreScoreLabel.textColor = kAppWhiteColor;
    UILabel *ScoreTit = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(StoreScoreLabel.frame)+1, CGRectGetMaxY(StoreName.frame)+17, 60, 20)];
    ScoreTit.font = [UIFont boldSystemFontOfSize:17];
    ScoreTit.adjustsFontSizeToFitWidth = YES;
    ScoreTit.text = [NSString stringWithFormat:@"%@",self.videoStoreScore];
    ScoreTit.textColor = kAppOrangeColor;
    UILabel *CountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ScoreTit.frame)+1, CGRectGetMaxY(StoreName.frame)+17,100, 20)];
    CountLabel.font = [UIFont boldSystemFontOfSize:17];
    CountLabel.text = [NSString stringWithFormat:@"分 视频数量:"];
    CountLabel.textColor = kAppWhiteColor;
    UILabel *CountTit = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(CountLabel.frame)+1, CGRectGetMaxY(StoreName.frame)+17, 30, 20)];
    CountTit.font = [UIFont boldSystemFontOfSize:17];
    CountTit.adjustsFontSizeToFitWidth = YES;
    CountTit.text = [NSString stringWithFormat:@"%@",self.videoStoreCount];
    CountTit.textColor = kAppOrangeColor;
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(Btn.frame), kScreenWidth,50)];
    _topView.backgroundColor = kAppWhiteColor;
    NSArray *arr = @[@"销量",@"价格",@"评分"];
    for (int i=0; i<3; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i+i*(kScreenWidth)/3, 0, (kScreenWidth)/3, 40);
        button.tag = 10+i;
        UIButton *imageBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth)/3-40, 10, 10, 20)];
        imageBtn.tag = 20+i;
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x_47.png"] forState:UIControlStateNormal];
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"图层-55-拷贝-2@2x.png"] forState:UIControlStateSelected];
        [imageBtn addTarget:self action:@selector(BtnVideo:)forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kAppBlueColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(BtnVideo:)forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        if (button.tag == 10) {
            button.selected = YES;
            self.btnSelected = button;
        }
        if (imageBtn.tag == 20) {
            imageBtn.selected = YES;
            self.ImageSelected = imageBtn;
        }
        [button addSubview:imageBtn];
        [_topView addSubview:button];
    }
    
    [Btn addSubview:CountTit];
    [Btn addSubview:StoreScoreLabel];
    [Btn addSubview:ScoreTit];
    [Btn addSubview:CountLabel];
    [Btn addSubview:StoreName];
    [Btn addSubview:imageView];
    [HeadView addSubview:Btn];
    [HeadView addSubview:_topView];
    [self.view addSubview:HeadView];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppClearColor;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-45@2x.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [self.view addSubview:NavBarview];
    
}

-(void)BackClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
