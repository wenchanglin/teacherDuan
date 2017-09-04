//
//  EveryVideosVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.

#import "EveryVideosVC.h"
#import "AppDelegate.h"
#import "EveryVideosCell.h"
#import "EveryVideoModel.h"
#import "VideoOrderDetails.h"
#import "PingJiaModel.h"
#import "PingJiaCell.h"
#import "FbwManager.h"
#import "SSVideoPlayer.h"
#import "SSVideoPlayContainer.h"
#import "SSVideoPlayController.h"
#import "VideoStoreModel.h"
#import "EveryVideoStoreVC.h"
#import "HSDownloadManager.h"

@interface EveryVideosVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_TableView;
    NSMutableArray  *_dataArray;
    UIButton        * BuyBtn;
    UIButton        * HuanCBtn;
    NSInteger         STR;
    NSMutableArray  *_PingJiaArray;
    EveryVideosCell * Xcell;
    NSString        *VideoSTr;
    NSMutableArray  *_SSVideoArr;
    VideoStoreModel *XModel;
    UIProgressView  *progressViewT;
    UILabel         *progressLabel1;
    UIView          *HeadView;
}
@end

@implementation EveryVideosVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    [self createData];
    [self createPingJiaData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    _PingJiaArray = [NSMutableArray array];
    _SSVideoArr  = [NSMutableArray array];
    progressViewT = [[UIProgressView alloc]init];
    self.view.backgroundColor = kAppWhiteColor;
    //    [self createTableView];
//    [self refreshDataWithState:DownloadStateSuspended];
}

-(void)createTableView
{
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+44) style:UITableViewStyleGrouped];
    _TableView.delegate = self;
    _TableView.tag = 99;
    _TableView.dataSource = self;
    _TableView.tableHeaderView = [self createHeadView];
    [self.view addSubview:_TableView];
}

-(void)createData
{
    __weak typeof(self) weakSelf = self;
    FbwManager *manager = [FbwManager shareManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"videoCourseId":self.videoCourseId,@"userId":manager.UUserId} url:UrL_EveryVideoDetail success:^(id responseObject) {
        NSLog(@"什么鬼东西%@",responseObject);
        [_dataArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSString *FkVideoStoreId = [RootDic objectForKey:@"fkVideoStoreId"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"videoStoreId":FkVideoStoreId} url:UrL_EveryVideoStore success:^(id responseObject) {
                //                NSLog(@"看看是什么花头%@",responseObject);
                NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                XModel = [[VideoStoreModel alloc]init];
                [XModel setDic:RootDic];
                [_TableView reloadData];
            } failure:^(NSError *error) {
            }];
        });
        EveryVideoModel *Model = [[EveryVideoModel alloc]init];
        [Model setDic:RootDic];
        [defaults setObject:[RootDic objectForKey:@"isBuy"] forKey:@"IsBuy"];
        //        manager.isBuy = [[RootDic objectForKey:@"isBuy"]integerValue];
        [defaults synchronize];
        [_dataArray addObject:Model];
        [_TableView reloadData];
        [weakSelf createTableView];
    } failure:^(NSError *error) {
    }];
}

-(void)createPingJiaData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"videoCourseId":self.videoCourseId} url:UrL_courseConments success:^(id responseObject) {
        [_PingJiaArray removeAllObjects];
        NSDictionary *RootDic =[responseObject objectForKey:@"data"];
        NSArray *arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
            PingJiaModel *Model =[[PingJiaModel alloc]init];
            [Model setDic:Dict];
            [_PingJiaArray addObject:Model];
        }
        [Xcell.SecondTableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(UIView *)createHeadView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"你瞧瞧%@",[defaults objectForKey:@"IsBuy"]);
    //    FbwManager *manager = [FbwManager shareManager];
    HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight/2.1)];
    HeadView.backgroundColor = kAppWhiteColor;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2 - 120)];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"图层-56@2x_70.png"];
    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/2 - 100, kScreenWidth, 25)];
    TitleLabel.text = self.videoCourseName;
    TitleLabel.font = [UIFont boldSystemFontOfSize:19];
    //    NSLog(@"看看str多少%ld",(long)manager.isBuy);
    UILabel *PriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/2 - 50, 80, 25)];
    
    if ([self.CouldHelp isEqualToString:@"Free"]||[[defaults objectForKey:@"IsBuy"]integerValue]==2) {
        PriceLabel.text = @"免费";
    }else{
        PriceLabel.text = [NSString stringWithFormat:@"¥%@",self.videoCoursePrice];
    }
    PriceLabel.textColor  = kAppRedColor;
    PriceLabel.font       = [UIFont boldSystemFontOfSize:19];
    UILabel *StudNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, kScreenHeight/2 - 50, kScreenWidth - 150, 25)];
    StudNumLabel.text = [NSString stringWithFormat:@"%@人已学习",self.videoCourseSellCount];
    StudNumLabel.font = [UIFont boldSystemFontOfSize:17];
    StudNumLabel.textColor = kAppLineColor;
    if ([self.CouldHelp isEqualToString:@"Free"] ||[[defaults objectForKey:@"IsBuy"]integerValue]==2) {
        BuyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        BuyBtn.layer.cornerRadius = 8;
        BuyBtn.frame = CGRectMake(kScreenWidth - 130, kScreenHeight/2 - 75, 80, 40);
        BuyBtn.backgroundColor = kAppBlueColor;
        BuyBtn.tag = 209;
        [BuyBtn setTitle:@"立即播放" forState:UIControlStateNormal];
        [BuyBtn addTarget:self action:@selector(BuyPlay:) forControlEvents:UIControlEventTouchUpInside];
        [BuyBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
        HuanCBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        HuanCBtn.frame = CGRectMake(CGRectGetMaxX(BuyBtn.frame)+10, kScreenHeight/2 - 70, 25, 25);
        [HuanCBtn setBackgroundImage:[UIImage imageNamed:@"ic_video_down.png"] forState:UIControlStateNormal];
        HuanCBtn.tag = 210;
        [HuanCBtn addTarget:self action:@selector(BuyPlay:) forControlEvents:UIControlEventTouchUpInside];
        progressViewT.frame=CGRectMake(CGRectGetMaxX(BuyBtn.frame)+8, kScreenHeight/2 - 75, 30, 3);
        progressViewT.trackTintColor=[UIColor blackColor];
        progressViewT.progress=0;
        progressViewT.progressTintColor=[UIColor redColor];
        [progressViewT setProgress:0 animated:YES];
        [HeadView addSubview:progressViewT];
        
    }else{
        BuyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        BuyBtn.frame = CGRectMake(kScreenWidth - 100, kScreenHeight/2 - 75, 80, 40);
        BuyBtn.backgroundColor = kAppBlueColor;
        BuyBtn.layer.cornerRadius =8;
        [BuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [BuyBtn addTarget:self action:@selector(BuyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [BuyBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    }
    UIButton *BackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    BackButton.frame = CGRectMake(20, 10, 30, 30);
    BackButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [BackButton setImage:[UIImage imageNamed:@"图层-45@2x.png"] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(Cklick:) forControlEvents:UIControlEventTouchUpInside];
    
    [HeadView  addSubview:StudNumLabel];
    [imageView addSubview:BackButton];
    [HeadView  addSubview:BuyBtn];
    [HeadView  addSubview:HuanCBtn];
    [HeadView  addSubview:TitleLabel];
    [HeadView  addSubview:PriceLabel];
    [HeadView  addSubview:imageView];
    return HeadView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 1;
    }
    if (tableView.tag == 99 && section == 0) {
        return 1;
    }
    if (!_dataArray.count) {
        
        return 0;
    }else{
        return _dataArray.count;
    }
}

- (void)refreshDataWithState:(DownloadState)state
{
    NSLog(@"%f",progressViewT.progress);
     NSLog(@"2Y%@",VideoSTr);
    progressLabel1.text = [NSString stringWithFormat:@"%.f%%", [[HSDownloadManager sharedInstance] progress:VideoSTr] * 100];
    NSLog(@"3Y%@",progressLabel1.text);
    progressViewT.progress = [[HSDownloadManager sharedInstance] progress:VideoSTr];
    [HuanCBtn setTitle:[self getTitleWithDownloadState:state] forState:UIControlStateNormal];
    NSLog(@"-----%f", [[HSDownloadManager sharedInstance] progress:VideoSTr]);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 2;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 2;
    }
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 80;
    }
    
    if (tableView.tag == 100) {
        return 100;
    }
    return kScreenHeight-200;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
        return _PingJiaArray.count;
    }
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (tableView.tag == 99) {
        if (indexPath.row == 0) {
//            if ([self.CouldHelp isEqualToString:@"Free"] ||[[defaults objectForKey:@"IsBuy"]integerValue]==2){
                 EveryVideoStoreVC *video = [[EveryVideoStoreVC alloc]init];
                 video.videoStoreId = XModel.VideoStoreId;
                 video.videoStoreCount = XModel.VideoStoreCourseCount;
                 video.videoStoreScore = XModel.VideoStoreScore;
                 video.videoStoreName  = XModel.VideoStoreName;
                 [self.navigationController pushViewController:video animated:YES];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"您还没购买此视频呢"];
//            }
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        PingJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Full"];
        if (!cell) {
            cell = [[PingJiaCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Full"];
        }
        PingJiaModel *Model = _PingJiaArray[indexPath.section];
        [cell configWithModel:Model];
        return cell;
    }else{
        if (indexPath.section == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Viedo"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Viedo"];
            }
            //        NSLog(@"%@ TTT %@",XModel.VideoStoreName,XModel.VideoStoreIntro);
            if (indexPath.section == 0) {
                cell.textLabel.text = XModel.VideoStoreName;
                cell.detailTextLabel.text = XModel.VideoStoreIntro;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.imageView.image = [UIImage imageNamed:@"图层-86@2x_0.png"];
            }
            return cell;
        }
        Xcell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
        if (!Xcell) {
            Xcell = [[EveryVideosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoCell"];
        }
        EveryVideoModel *Model = _dataArray[indexPath.row];
        Xcell.SecondTableView.delegate = self;
        Xcell.SecondTableView.tag = 100;
        Xcell.SecondTableView.dataSource = self;
        [Xcell configWithModel:Model];
        
        return Xcell;
    }
}

-(void)BuyBtn:(UIButton *)buyBtn
{
    //立即购买
    VideoOrderDetails *OrderDetails = [[VideoOrderDetails alloc]init];
    OrderDetails.OrderCourseName = self.videoCourseName;
    OrderDetails.OrderCoursePrice = self.videoCoursePrice;
    OrderDetails.OrderCourseId = self.videoCourseId;
    [self.navigationController pushViewController:OrderDetails animated:YES];
}

-(void)BuyPlay:(UIButton *)PlayBtn
{
    FbwManager *Manager = [FbwManager shareManager];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"videoCourseId":self.videoCourseId} url:UrL_VideoPlay success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        VideoSTr = [NSString stringWithFormat:@"%@%@",BASEURL,[RootDic objectForKey:@"videoUrl"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (PlayBtn.tag == 209) {
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"videoCourseId":self.videoCourseId} url:UrL_PlayVideoPlay success:^(id responseObject) {
                } failure:^(NSError *error) {
                }];
                NSArray *paths = @[VideoSTr];
                NSArray *names = @[@"You're Beautiful"];
                NSMutableArray *videoList = [NSMutableArray array];
                for (NSInteger i = 0; i<paths.count; i++) {
                    SSVideoModel *model = [[SSVideoModel alloc]initWithName:names[i] path:paths[i]];
                    [videoList addObject:model];
                }
                SSVideoPlayController *playController = [[SSVideoPlayController alloc]initWithVideoList:videoList];
                SSVideoPlayContainer *playContainer = [[SSVideoPlayContainer alloc]initWithRootViewController:playController];
                [self presentViewController:playContainer animated:NO completion:nil];
            }else{
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkUserId":Manager.UUserId,@"videoCourseId":self.videoCourseId} url:UrL_DownLoadMyVideoS success:^(id responseObject) {

                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES));
                        
                        [self download:VideoSTr progressLabel:progressLabel1 progressView:progressViewT button:HuanCBtn];
                        progressLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(progressViewT.frame)+2, kScreenHeight/2 - 75, 20, 10)];
                        progressLabel1.text = [NSString stringWithFormat:@"%.f%%", [[HSDownloadManager sharedInstance] progress:VideoSTr] * 100];
                        [HeadView addSubview:progressViewT];
                        progressViewT.progress = [[HSDownloadManager sharedInstance] progress:VideoSTr];
                        [HuanCBtn setTitle:[self getTitleWithDownloadState:DownloadStateSuspended] forState:UIControlStateNormal];
                        [self refreshDataWithState:DownloadStateStart];
                        
                        /**
                         [self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:VideoSTr]
                         customPath:[NSString pathWithComponents:@[NSTemporaryDirectory(), @"Documents/Video.mp4"]]
                         firstResponse:NULL
                         progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
                         //                                                                    if (remainingTime != -1) {
                         //                                                                        [self.remainingTime setText:[NSString stringWithFormat:@"%lds", (long)remainingTime]];
                         //                                                                    }
                         NSLog(@"唧唧%ld",remainingTime);
                         NSLog(@"陌陌%ld",(long)totalLength);
                         }
                         error:^(NSError *error) {
                         NSLog(@"%@", error);
                         }
                         complete:^(BOOL downloadFinished, NSString *pathToFile) {
                         
                         //                                                                    NSString *str = downloadFinished ? @"Completed" : @"Cancelled";
                         //                                                                    [self.remainingTime setText:str];
                         }]
                         */
                    });
                } failure:^(NSError *error) {
                }];
            }
        });
    } failure:^(NSError *error) {
    }];
}

#pragma mark 开启任务下载资源
- (void)download:(NSString *)url progressLabel:(UILabel *)progressLabel progressView:(UIProgressView *)progressView button:(UIButton *)button
{
    [[HSDownloadManager sharedInstance] download:url progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progressLabel.text = [NSString stringWithFormat:@"%.f%%", progress * 100];
            progressView.progress = progress;
        });
    } state:^(DownloadState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [button setTitle:[self getTitleWithDownloadState:state] forState:UIControlStateNormal];
        });
    }];
}

#pragma mark 按钮状态
- (NSString *)getTitleWithDownloadState:(DownloadState)state
{
    switch (state) {
        case DownloadStateStart:
            return @"暂停";
        case DownloadStateSuspended:
        case DownloadStateFailed:
            return @"开始";
        case DownloadStateCompleted:
            return @"完成";
        default:
            break;
    }
}

-(void)Cklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
