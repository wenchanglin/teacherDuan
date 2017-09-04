//
//  SearchVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SearchVC.h"
#import "SearchModel.h"
#import "SearchCell.h"
#import "EveryVideosVC.h"
@interface SearchVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *_Topview;
    UITableView  * _firstView;
    UITableView  * _secondView;
    UITableView  * _thirdView;
    NSMutableArray * _DataOneArray;
    NSMutableArray * _DataTwoArray;
    NSMutableArray * _DataThreeArray;
    UIScrollView * _mainScrollView;
    UIButton     * Btn;
    int    NUmSelect;
    UITextField  *_textField;
}
@property(nonatomic, strong)UIButton *btnSelected;
@property(nonatomic, strong)UIButton *ChangeSelected;
@end
@implementation SearchVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _DataOneArray   = [NSMutableArray array];
    _DataTwoArray   = [NSMutableArray array];
    _DataThreeArray = [NSMutableArray array];
    NUmSelect = 1;
    [self createSearchBar];
    [self initMainScrollView];
    self.view.backgroundColor = kAppWhiteColor;
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
    _firstView.backgroundColor = kAppWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _firstView.dataSource = self;
    _firstView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _firstView.showsVerticalScrollIndicator=NO;
    
    _secondView = [[UITableView alloc]initWithFrame:CGRectMake(width, 0,width,height) style:UITableViewStyleGrouped];
    _secondView.tag = 11;
    _secondView.backgroundColor = kAppWhiteColor;
    _secondView.delegate = self;
    _secondView.dataSource = self;
    _secondView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _secondView.showsVerticalScrollIndicator=NO;
    
    _thirdView = [[UITableView alloc]initWithFrame:CGRectMake(2*width, 0,width,height) style:UITableViewStyleGrouped];
    _thirdView.tag = 12;
    _thirdView.backgroundColor = kAppWhiteColor;
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

#pragma mark ------------shou Fei

-(void)createData
{
    int True;
    if (NUmSelect == 1) {
        True = 1;
    }else{
        True = 2;
    }
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_textField.text,@"status":[NSString stringWithFormat:@"%d",True]} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        [_DataOneArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *ARR = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in ARR) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataOneArray addObject:Model];
        }
        //        NSLog(@"几个%ld",(long)_DataOneArray.count);
        [_firstView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createHotData
{
    int True;
    if (NUmSelect == 1) {
        True = 1;
    }else{
        True = 2;
    }
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_textField.text,@"sort":@"sellCount",@"status":[NSString stringWithFormat:@"%d",True]} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        [_DataTwoArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *ARR = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in ARR) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataTwoArray addObject:Model];
        }
        //        NSLog(@"几Hot个%ld",(long)_DataTwoArray.count);
        [_secondView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createPriceData
{
    int True;
    if (NUmSelect == 1) {
        True = 1;
    }else{
        True = 2;
    }
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"name":_textField.text,@"sort":@"price",@"status":[NSString stringWithFormat:@"%d",True]} url:UrL_VideoCourseSellCount success:^(id responseObject) {
        [_DataThreeArray removeAllObjects];
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *ARR = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in ARR) {
            SearchModel *Model = [[SearchModel alloc]init];
            [Model setDic:dict];
            [_DataThreeArray addObject:Model];
        }
        //        NSLog(@"几Time个%ld",(long)_DataThreeArray.count);
        [_thirdView reloadData];
    } failure:^(NSError *error) {
    }];
}
#pragma mark ------------按钮

-(void)createThreeView
{
    _Topview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,40)];
    _Topview.backgroundColor = kAppWhiteColor;
    NSArray *arr = @[@"免费",@"按热门",@"按价格"];
    for (int i=0; i<3; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame     = CGRectMake(i+i*(kScreenWidth-2)/3, 0, (kScreenWidth-2)/3, 40);
        button.tag       = 199+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kAppBlueColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(Btnlose:) forControlEvents:UIControlEventTouchUpInside];
        if (button.tag == 199) {
            UIImageView *BtnImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)-30, 15, 15, 10)];
            BtnImage.image        = [UIImage imageNamed:@"图层-54-拷贝@2x_75.png"];
            BtnImage.userInteractionEnabled  = YES;
            if (button.tag == 199) {
                button.selected = YES;
                self.ChangeSelected = button;
            }
            UITapGestureRecognizer *ImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnImage:)];
            [BtnImage addGestureRecognizer:ImageTap];
            [button addSubview:BtnImage];
        }
        if (i < 2) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-2)/3 + i*(kScreenWidth-2)/3, 0, 1, 38)];
            label.backgroundColor = kAppLightGrayColor;
            
            [_Topview addSubview:label];
        }
        button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        if (button.tag == 199) {
            button.selected = YES;
            self.btnSelected = button;
        }
        [_Topview addSubview:button];
    }
    
    [self.view addSubview:_Topview];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EveryVideosVC *video =[[EveryVideosVC alloc]init];
    if (NUmSelect == 1) {
        if (tableView.tag == 10) {
            SearchModel *Model =_DataOneArray[indexPath.section];
            video.CouldHelp = @"Free";
            video.videoCourseId = Model.SearchId;
            video.videoCourseName = Model.SearchName;
            video.videoCoursePrice = Model.SearchPrice;
            video.videoCourseSellCount = Model.SearchSellCount;
        }else if (tableView.tag == 11){
            SearchModel *Model =_DataTwoArray[indexPath.section];
            video.CouldHelp = @"Free";
            video.videoCourseId = Model.SearchId;
            video.videoCourseName = Model.SearchName;
            video.videoCoursePrice = Model.SearchPrice;
            video.videoCourseSellCount = Model.SearchSellCount;
        }else{
            SearchModel *Model =_DataThreeArray[indexPath.section];
            video.CouldHelp = @"Charge";
            video.videoCourseId = Model.SearchId;
            video.videoCourseName = Model.SearchName;
            video.videoCoursePrice = Model.SearchPrice;
            video.videoCourseSellCount = Model.SearchSellCount;
        }
    }else{
        if (tableView.tag == 10) {
            SearchModel *Model =_DataOneArray[indexPath.section];
            video.CouldHelp = @"Charge";
            video.videoCourseId = Model.SearchId;
            video.videoCourseName = Model.SearchName;
            video.videoCoursePrice = Model.SearchPrice;
            video.videoCourseSellCount = Model.SearchSellCount;
        }else if (tableView.tag == 11){
            SearchModel *Model =_DataTwoArray[indexPath.section];
            video.CouldHelp = @"Charge";
            video.videoCourseId = Model.SearchId;
            video.videoCourseName = Model.SearchName;
            video.videoCoursePrice = Model.SearchPrice;
            video.videoCourseSellCount = Model.SearchSellCount;
        }else{
            SearchModel *Model =_DataThreeArray[indexPath.section];
            video.CouldHelp = @"Free";
            video.videoCourseId = Model.SearchId;
            video.videoCourseName = Model.SearchName;
            video.videoCoursePrice = Model.SearchPrice;
            video.videoCourseSellCount = Model.SearchSellCount;
        }
    }
    [self.navigationController pushViewController:video animated:YES];
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
    if (tableView.tag == 11){
        return 100;
    }
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10) {
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchOne"];
        if (!cell) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchOne"];
        }
        SearchModel *Model = _DataOneArray[indexPath.section];
        if (NUmSelect == 1) {
            cell.SearchPrice.text = @"免费";
        }else{
            cell.SearchPrice.text = [NSString stringWithFormat:@"¥%@",Model.SearchPrice];
        }
        [cell.contentView addSubview:cell.SearchPrice];
        [cell configWithModel:Model];
        return cell;
    }else if (tableView.tag == 11){
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchWne"];
        if (!cell) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchWne"];
        }
        SearchModel *Model = _DataTwoArray[indexPath.section];
        if (NUmSelect == 1) {
            cell.SearchPrice.text = @"免费";
        }else{
            cell.SearchPrice.text = [NSString stringWithFormat:@"¥%@",Model.SearchPrice];
        }
        [cell.contentView addSubview:cell.SearchPrice];
        [cell configWithModel:Model];
        return cell;
        
    }else if (tableView.tag == 12){
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchThree"];
        if (!cell) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchThree"];
        }
        SearchModel *Model = _DataThreeArray[indexPath.section];
        if (NUmSelect == 1) {
            cell.SearchPrice.text = @"免费";
        }else{
            cell.SearchPrice.text = [NSString stringWithFormat:@"¥%@",Model.SearchPrice];
        }
        [cell.contentView addSubview:cell.SearchPrice];
        [cell configWithModel:Model];
        return cell;
        
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CAx"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CAx"];
    }
    return cell;
}

-(void)BtnImage:(id)sender
{
    Btn =[UIButton buttonWithType:UIButtonTypeCustom];
    Btn.tag = 90;
    Btn.frame = CGRectMake(0, CGRectGetMaxY(_Topview.frame)+1,(kScreenWidth-2)/3, 40);
    UIButton *BT = [self.view viewWithTag:199];
    if ([BT.titleLabel.text isEqualToString:@"免费"]) {
        [Btn setTitle:@"收费" forState:UIControlStateNormal];
    }else{
        [Btn setTitle:@"免费" forState:UIControlStateNormal];
    }
    
    [Btn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(ChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    Btn.titleLabel.font = [UIFont systemFontOfSize:13];
    Btn.backgroundColor = kAppWhiteColor;
    [self.view addSubview:Btn];
}

-(void)ChangeBtn:(UIButton *)bt
{
    self.ChangeSelected.selected = NO;
    if (bt.tag == 90) {
        if ([bt.titleLabel.text isEqualToString:@"收费"]) {
            bt.selected = YES;
            NUmSelect = 2;
            [self createData];
            [_firstView reloadData];
            UIButton *BT = [self.view viewWithTag:199];
            [BT setTitle:@"收费" forState:UIControlStateNormal];
            [BT setTitleColor:kAppBlueColor forState:UIControlStateNormal];
            bt.hidden = YES;
        }else{
            bt.selected = YES;
            NUmSelect = 1;
            [self createData];
            [_firstView reloadData];
            UIButton *BT = [self.view viewWithTag:199];
            [BT setTitle:@"免费" forState:UIControlStateNormal];
            [BT setTitleColor:kAppBlueColor forState:UIControlStateNormal];
            bt.hidden = YES;
        }
    }
    self.ChangeSelected = bt;
}

-(void)Btnlose:(UIButton *)btnSJ
{
    self.btnSelected.selected = NO;
    if (btnSJ.tag == 199) {
        btnSJ.selected = YES;
        [self createData];
        _mainScrollView.contentOffset = CGPointMake(0,0);
    }else if(btnSJ.tag == 200)
    {
        btnSJ.selected = YES;
        UIButton *BT = [self.view viewWithTag:199];
        BT.titleLabel.textColor = kAppBlackColor;
        [self createHotData];
        self.ChangeSelected.selected = NO;
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth,0);
    }else{
        btnSJ.selected = YES;
        [self createPriceData];
        UIButton *BT = [self.view viewWithTag:199];
        BT.titleLabel.textColor = kAppBlackColor;
        self.ChangeSelected.selected = NO;
        _mainScrollView.contentOffset = CGPointMake(2*kScreenWidth,0);
    }
    self.btnSelected = btnSJ;
}

-(void)createSearchBar
{
    UIView *SearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    SearchView.backgroundColor = kAppBlueColor;
    UIButton *button1  = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame      = CGRectMake(10, 5, 30, 34);
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Klick:)forControlEvents:UIControlEventTouchUpInside];
    _textField    = [[UITextField alloc]initWithFrame:CGRectMake(40, 5, kScreenWidth - 80, 34)];
    _textField.backgroundColor = kAppWhiteColor;
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    _textField.layer.cornerRadius = 5;
    _textField.layer.borderWidth = 0.1;
    _textField.enabled         = true;
    _textField.placeholder     = @"搜索视频";
    _textField.layer.borderColor = kAppLineColor.CGColor;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_textField.frame)-20, 0, 34, CGRectGetMaxY(_textField.frame))];
    view.image                  = [UIImage imageNamed:@"图层-56@2x.png"];
    view.userInteractionEnabled = YES;
    view.contentMode            = UIViewContentModeCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SearchPic:)];
    _textField.rightView         = view;
    _textField.rightViewMode     = UITextFieldViewModeAlways;
    [view addGestureRecognizer:tap];
    
    [SearchView addSubview:_textField];
    [SearchView addSubview:button1];
    [self.view  addSubview:SearchView];
}

-(void)SearchPic:(UITapGestureRecognizer *)tap7
{
    NSLog(@"看看搜索什么--%@",_textField.text);
    if (_textField.text.length != 0) {
        //        if (_DataOneArray.count != 0) {
        [self createThreeView];
        [self createData];
        [_textField resignFirstResponder];
        //        }
        //        else{
        //        _Topview.hidden = YES;
        //        [SVProgressHUD showErrorWithStatus:@"抱歉为找到合适信息"];
        //        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入搜索条件"];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


-(void)Klick:(UIButton *)cBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
