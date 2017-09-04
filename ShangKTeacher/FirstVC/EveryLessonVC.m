//
//  EveryLessonVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryLessonVC.h"
#import "AppDelegate.h"
#import "EveryLessonCell.h"
#import "EveryLessonPinaJiaModel.h"
#import "EveryLessonPinaJiaCell.h"
#import "ImageScrollView.h"
@interface EveryLessonVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_TableView;
    NSMutableArray *_PingJiaArray;
    NSMutableArray *_PicArray;
    EveryLessonCell *Ycell;
    ImageScrollView *imgScrollView;
}
@end

@implementation EveryLessonVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    _PicArray = [NSMutableArray array];
    [self createData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _PingJiaArray = [NSMutableArray array];
    
    
    [self createTableView];
    [self createPingJiaData];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+54) style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.tag = 99;
    _TableView.dataSource = self;
    _TableView.tableHeaderView = [self createHeadView];
    [self.view addSubview:_TableView];
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.courseId} url:UrL_CourseDetail success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"mag"]];
        NSLog(@"%@",responseObject);
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"photoList"];
        if ([[RootDic objectForKey:@"photoList"] isKindOfClass:[NSNull class]]||[RootDic objectForKey:@"photoList"] == nil) {
        }else{
            for (NSDictionary *dic in Arr) {
                NSString *st = [NSString stringWithFormat:@"%@%@",BASEURL,[dic objectForKey:@"location"]];
                [_PicArray addObject:st];
            }
            [self createTableView];
//            [_TableView reloadData];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)createPingJiaData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.courseId} url:UrL_ObjectConment success:^(id responseObject) {
        [_PingJiaArray removeAllObjects];
//        NSLog(@"看看课程评论%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic =[responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            EveryLessonPinaJiaModel *Model =[[EveryLessonPinaJiaModel alloc]init];
            [Model setDic:Dict];
            [_PingJiaArray addObject:Model];
        }
        NSLog(@"%ld几个评价",(long)_PingJiaArray.count);
        [Ycell.SecondTableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(UIView *)createHeadView
{
    UIView *HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2+10)];
    HeadView.backgroundColor = kAppWhiteColor;
    NSLog(@"hh%@",_PicArray[0]);
    imgScrollView       = [[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2 - 120)];
    imgScrollView.pics  = _PicArray;
    [imgScrollView returnIndex:^(NSInteger index) {
    }];
    [imgScrollView reloadView];
    [HeadView addSubview:imgScrollView];
//    UIImageView *imageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2 - 120)];
//    imageView.userInteractionEnabled = YES;
//    imageView.image     = [UIImage imageNamed:@"图层-56@2x_70.png"];
    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/2 - 100, kScreenWidth, 25)];
    TitleLabel.text = self.EveryLessonName;
    TitleLabel.font = [UIFont boldSystemFontOfSize:19];
    NSMutableAttributedString *PingFenStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"评分: %@分",self.EveryLessonAvgScore]];
    [PingFenStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(4, 1)];
    UILabel *PriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/2 - 70, 100, 25)];
    PriceLabel.attributedText = PingFenStr;
    PriceLabel.font = [UIFont boldSystemFontOfSize:17];
    UIImageView *TouXianPic = [[UIImageView alloc]initWithFrame:CGRectMake(115, kScreenHeight/2 - 70+2, 20, 20)];
    TouXianPic.image = [UIImage imageNamed:@"我的@2x.png"];
    UILabel *StudNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(TouXianPic.frame)+5, kScreenHeight/2 - 70, kScreenWidth - 150, 25)];
    StudNumLabel.text = [NSString stringWithFormat:@"%@人已报名",self.EveryLessonBuyCount];
    StudNumLabel.font = [UIFont boldSystemFontOfSize:17];
    StudNumLabel.textColor = kAppBlackColor;
    UILabel *LineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(StudNumLabel.frame)+10, kScreenWidth, 0.5)];
    LineLabel.backgroundColor = kAppLineColor;
    UILabel *Price = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LineLabel.frame)+10, 150, 20)];
    Price.text = [NSString stringWithFormat:@"¥%@",self.EveryLessonPrice];
    Price.textColor = kAppRedColor;
    Price.font = [UIFont boldSystemFontOfSize:20];
    UIButton *BackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    BackButton.frame = CGRectMake(20, 10, 30, 30);
    BackButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [BackButton setImage:[UIImage imageNamed:@"图层-45@2x.png"] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(Cklick:) forControlEvents:UIControlEventTouchUpInside];

    
    [HeadView  addSubview:StudNumLabel];
    [imgScrollView addSubview:BackButton];
//    [imgScrollView addSubview:LineLabel];
    [HeadView  addSubview:TitleLabel];
    [HeadView  addSubview:TouXianPic];
    [HeadView  addSubview:Price];
    [HeadView  addSubview:PriceLabel];
//    [HeadView  addSubview:imageView];
    
    return HeadView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
         return _PingJiaArray.count;
    }
    return 1;
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
    if (tableView.tag == 100) {
        return 120;
    }
    return kScreenHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        EveryLessonPinaJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Full"];
        if (!cell) {
            cell = [[EveryLessonPinaJiaCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Full"];
        }
        EveryLessonPinaJiaModel *Model = _PingJiaArray[indexPath.section];
        [cell configWithModel:Model];
        return cell;
    }else{
    Ycell = [tableView dequeueReusableCellWithIdentifier:@"LessonCell"];
    if (!Ycell) {
        Ycell = [[EveryLessonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LessonCell"];
    }
    Ycell.FirstOneTitle.text = self.EveryLessonBriefIntro;
    Ycell.SecondOneTitle.text = self.EveryLessonFitPeople;
    Ycell.SecondTableView.delegate = self;
    Ycell.SecondTableView.tag = 100;
    Ycell.SecondTableView.dataSource = self;
    return Ycell;
    }
}

-(void)Cklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
