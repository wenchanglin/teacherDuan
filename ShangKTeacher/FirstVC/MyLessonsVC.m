//
//  MyLessonsVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyLessonsVC.h"
#import "AppDelegate.h"
#import "MyLessonsCell.h"
#import "EveryLessonVC.h"
#import "MyLessonsModel.h"

@interface MyLessonsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_DataArray;
    NSInteger       _page;
    BOOL            _isPulling;
}
@end

@implementation MyLessonsVC

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
    _DataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTableView];
    [self form];
    [self updown];
    self.view.backgroundColor = kAppWhiteColor;
}

//下拉刷新
- (void)form {
    __weak MyLessonsVC *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isPulling = YES;
        [weakSelf createData];
    }];
}
//上拉加载
- (void)updown {
    __weak MyLessonsVC *weakSelf = self;
    _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        _page ++;
        _isPulling = NO;
        if (_page >= 50) {
            [_tableView.mj_footer endRefreshing];
            return ;
        } else {
            [weakSelf createData];
        }
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)createData
{//a97d1c79-c29c-4d01-bf85-065788e1c56c
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId,@"page":[NSString stringWithFormat:@"%ld",(long)_page]} url:UrL_MyObject success:^(id responseObject) {
        NSLog(@"我的课程%@",responseObject);
        if (_isPulling) {
            [_DataArray removeAllObjects];
        }
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *ARR = [RootDic objectForKey:@"iData"];
        for (NSDictionary *rootDic in ARR) {
            MyLessonsModel *Model = [[MyLessonsModel alloc]init];
            NSDictionary *Dic = [rootDic objectForKey:@"course"];
            [Model setDic:Dic];
            if ([[Dic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]) {
                
            }else{
                NSArray *ArrCt = [Dic objectForKey:@"photoList"];
                for (NSDictionary *DictT in ArrCt) {
                    [Model setDict:DictT];
                }
            }
            [_DataArray addObject:Model];
        }
        if (_isPulling) {
            [_tableView.mj_header endRefreshing];
        }else{
            [_tableView.mj_footer endRefreshing];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _DataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyLessonsModel *Model = _DataArray[indexPath.section];
    EveryLessonVC *lesson = [[EveryLessonVC alloc]init];
    lesson.EveryLessonName = Model.MyLessonName;
    lesson.EveryLessonPrice =  Model.MyLessonPrice;
    lesson.EveryLessonAvgScore = Model.MyLessonAvgScore;
    lesson.EveryLessonBuyCount  =  Model.MyLessonBuyCount;
    lesson.EveryLessonFitPeople  =   Model.MyLessonFitPeople;
    lesson.EveryLessonBriefIntro   =   Model.MyLessonBriefIntro;
    lesson.courseId = Model.MyLessonId;
    
    [self.navigationController pushViewController:lesson animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLessonsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
    if (!cell) {
        cell = [[MyLessonsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Chat"];
    }
    MyLessonsModel *Model = _DataArray[indexPath.section];
    [cell configWithModel:Model];
    return cell;
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"我的课程";
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
