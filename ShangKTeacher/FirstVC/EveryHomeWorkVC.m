//
//  EveryHomeWorkVC.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "EveryHomeWorkVC.h"
#import "AppDelegate.h"
#import "FirstHomeWorkCell.h"
#import "SecondHomeWorkCell.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewVC.h"
#import "NumberOneModel.h"
#import "NumberOneCell.h"
#import "FirstHomeWorkModel.h"
#import "FirstHomeWorkCell.h"
#import "SecondHomeWorkModel.h"
#import "TeacherAnswerVC.h"
#import "LookPhotoViewController.h"
#import "SSVideoPlayer.h"
#import "SSVideoPlayContainer.h"
#import "SSVideoPlayController.h"
@interface EveryHomeWorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView      * PushView;
    NSString    *_AnswerId;
    NSInteger    IsType;
    NSInteger    IsHomeWork;
    NSInteger    IsLuYin;
    AVAudioPlayer  * _player;
    NSMutableArray *_dataOneArray;
    NSMutableArray *_dataTwoArray;
    NSMutableArray *_dataThereArray;
    NSMutableArray *_PicOneArray;
    NSMutableArray *_PicTwoArray;
    NSString       *_CreateTime;
    NSString       *_UserPhotoHead;
}
@end

@implementation EveryHomeWorkVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    _dataThereArray = [NSMutableArray array];
    [self createDataHomeworkAnswer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [PushView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    _dataOneArray = [NSMutableArray array];
    _dataTwoArray = [NSMutableArray array];
    _PicOneArray  = [NSMutableArray array];
    _PicTwoArray  = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createDataHomeWork];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createDataHomeworkAnswer
{
    NSLog(@"呵呵哒%@",self.ActivityID);
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkHomeworkAnswerId":self.AnswerId} url:UrL_StudentHomeworkAnswer success:^(id responseObject) {
        NSLog(@"kankan%@",responseObject);
        [_dataThereArray removeAllObjects];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NSArray *arr = [rootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in arr) {
        IsLuYin = [[Dict objectForKey:@"type"]integerValue];
//            NSLog(@"现出原形%ld",IsLuYin);
            SecondHomeWorkModel *Model = [[SecondHomeWorkModel alloc]init];
            if ([[Dict objectForKey:@"user"]isKindOfClass:[NSNull class]]) {
                [Model setWithJiaNAme:Dict];
            }else{
                [Model setWithName:Dict];
            }
            if (IsLuYin == 2) {
                NSDictionary *RootDct = [Dict objectForKey:@"voiceUrl"];
                [Model setWithVoiceUrl:RootDct];
            }else{
                [Model setWithContent:Dict];
            }
            [Model setWithDic:Dict];
            [_dataThereArray addObject:Model];
        }
            [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createDataHomeWork
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"answerId":self.AnswerId} url:UrL_StudentHomeWorkXiangQ success:^(id responseObject) {
//        NSLog(@"学生作业%@",responseObject);
        [_dataTwoArray removeAllObjects];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        _AnswerId = [rootDic objectForKey:@"id"];
        FirstHomeWorkModel *Model = [[FirstHomeWorkModel alloc]init];
        [Model setWithDic:rootDic];
        _CreateTime = [rootDic objectForKey:@"createTime"];
        if ([[rootDic objectForKey:@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
            _UserPhotoHead = @"图层-52@2x.png";
        }else{
            _UserPhotoHead = [rootDic objectForKey:@"userPhotoHead"];
        }
        IsHomeWork = [[rootDic objectForKey:@"type"]integerValue];
        if (IsHomeWork == 2) {
            [Model setWithDit:rootDic];
        }else{
        NSArray *Arr = [rootDic objectForKey:@"photoList"];
        for (NSDictionary *DIC in Arr) {
            [Model setWithdic:rootDic];
            [Model setWithDict:DIC];
            [_PicTwoArray addObject:[DIC objectForKey:@"location"]];
            }
          }
        [_dataTwoArray addObject:Model];
        [_tableView reloadData];
        } failure:^(NSError *error) {
    }];
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"homeworkId":self.ActivityID} url:UrL_HomeWorkXiangQ success:^(id responseObject) {
//        NSLog(@"说的跟着你的一样%@",responseObject);
        [_dataOneArray removeAllObjects];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
        NumberOneModel *Model = [[NumberOneModel alloc]init];
        [Model setWithDic:rootDic];
        IsType = [[rootDic objectForKey:@"type"]integerValue];
        if (IsType == 2) {
            [Model setWithDit:rootDic];
        }else{
        NSArray *Arr = [rootDic objectForKey:@"photoList"];
        for (NSDictionary *DIC in Arr) {
            [Model setWithdic:rootDic];
            [Model setWithDict:DIC];
            [_PicOneArray addObject:[DIC objectForKey:@"location"]];
            }
        }
        [_dataOneArray addObject:Model];
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64-30) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *bottonView         = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
    UITapGestureRecognizer *Tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TApBTn:)];
    bottonView.backgroundColor = kAppBlueColor;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-60)/2, 7, 60, 30)];
    title.text                 = @"回复";
    title.font                 = [UIFont boldSystemFontOfSize:20];
    title.textColor            = kAppWhiteColor;
    title.textAlignment        = NSTextAlignmentCenter;
    
    [bottonView addGestureRecognizer:Tap];
    [bottonView addSubview:title];
    [self.view addSubview:bottonView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _dataOneArray.count;
    }
   else if (section == 2) {
        return _dataThereArray.count;
    }
    return _dataTwoArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;
    }else if ( indexPath.section == 1){
        return 300;
    }
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (section == 0) {
        UIView *TitleView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, kScreenWidth, 30)];
        TitleView.backgroundColor = kAppWhiteColor;
        UILabel *LineLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 3, 20)];
        LineLabel.backgroundColor = kAppBlueColor;
        UILabel *TitLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth-120, 20)];
        TitLabel.text = @"作业详情";
        TitLabel.textColor = kAppBlackColor;
        [TitleView addSubview:LineLabel];
        [TitleView addSubview:TitLabel];
        view = TitleView;
        return view;
    }else if (section == 1){
        UIView *TitleView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, kScreenWidth, 30)];
        TitleView.backgroundColor = kAppWhiteColor;
        UILabel *LineLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 3, 20)];
        LineLabel.backgroundColor = kAppBlueColor;
        UILabel *TitLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth-120, 20)];
        TitLabel.text = @"学生作业";
        TitLabel.textColor = kAppBlackColor;
        [TitleView addSubview:LineLabel];
        [TitleView addSubview:TitLabel];
        view = TitleView;
        return view;
    }
    UIView *TitleView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, kScreenWidth, 30)];
    TitleView.backgroundColor = kAppWhiteColor;
    UILabel *LineLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 3, 20)];
    LineLabel.backgroundColor = kAppBlueColor;
    UILabel *TitLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, kScreenWidth-120, 20)];
    TitLabel.text = @"作业回复";
    TitLabel.textColor = kAppBlackColor;
    [TitleView addSubview:LineLabel];
    [TitleView addSubview:TitLabel];
    view = TitleView;
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NumberOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Numone"];
        if (!cell) {
            cell = [[NumberOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Numone"];
        }
        NumberOneModel *Model = _dataOneArray[indexPath.section];
        if (IsType == 2) {
            UIButton *ImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            ImageBtn.frame = CGRectMake(10, CGRectGetMaxY(cell.NumBerContent.frame)+10, (kScreenWidth-50)/3, 100);
            [ImageBtn setBackgroundImage:[UIImage imageNamed:@"图层-56@2x_75.png"] forState:UIControlStateNormal];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"图层-2@2x.png"] forState:UIControlStateNormal];
            btn.frame = CGRectMake((kScreenWidth/4 - kScreenWidth/8)/2, (kScreenWidth/4 - kScreenWidth/8)/2, kScreenWidth/8, kScreenWidth/8);
            btn.tag = indexPath.row;
            [btn addTarget:self action:@selector(FirstPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
            [ImageBtn addSubview:btn];
            [cell.contentView addSubview:ImageBtn];
        }else{
        for (int i = 0; i < _PicOneArray.count; i++) {
            UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectMake(10+i*(kScreenWidth-50)/3+10*i, CGRectGetMaxY(cell.NumBerContent.frame)+10, (kScreenWidth-50)/3, 100)];
            [imageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicOneArray[i]]] placeholderImage:nil];
            [imageView addTarget:self action:@selector(ImagePicX:) forControlEvents:UIControlEventTouchUpInside];
            imageView.tag = i;
            [cell.contentView addSubview:imageView];
            }
        }
        [cell configWithModel:Model];
        return cell;
    }
   else  if (indexPath.section == 1) {
        FirstHomeWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Grt"];
        if (!cell) {
            cell = [[FirstHomeWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Grt"];
        }
            cell.PicWomen       = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            cell.PicWomen.layer.cornerRadius = 25;
            cell.PicWomen.layer.masksToBounds = YES;
          if ([_UserPhotoHead isEqualToString:@"图层-52@2x.png"]) {
            cell.PicWomen.image = [UIImage imageNamed:@"图层-52@2x.png"];
           }else{
            [cell.PicWomen setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_UserPhotoHead]] placeholderImage:nil];
           }
            cell.SecNameLabel   = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, kScreenWidth-130, 20)];
            cell.SecNameLabel.font = [UIFont boldSystemFontOfSize:15];
            cell.SecNameLabel.text = self.StudentNickName;
            cell.SecDateLabel      = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, kScreenWidth-130, 20)];
            cell.SecDateLabel.font = [UIFont systemFontOfSize:15];
            NSString * timeStampString = _CreateTime;
            NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
           [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
            NSString *time = [objDateformat stringFromDate: date];
            cell.SecDateLabel.text = [NSString stringWithFormat:@"%@",time];
            FirstHomeWorkModel *Model = _dataTwoArray[indexPath.row];
       if (IsHomeWork == 2) {
           UIButton *ImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
           ImageBtn.frame = CGRectMake(10, CGRectGetMaxY(cell.SecondContent.frame)+10, (kScreenWidth-50)/3, 100);
           [ImageBtn setBackgroundImage:[UIImage imageNamed:@"图层-56@2x_75.png"] forState:UIControlStateNormal];
           UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
           btn.tag = indexPath.row;
           [btn setImage:[UIImage imageNamed:@"图层-2@2x.png"] forState:UIControlStateNormal];
           btn.frame = CGRectMake((kScreenWidth/4 - kScreenWidth/8)/2, (kScreenWidth/4 - kScreenWidth/8)/2, kScreenWidth/8, kScreenWidth/8);
           [btn addTarget:self action:@selector(SecondPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
           [ImageBtn addSubview:btn];
           [cell.contentView addSubview:ImageBtn];
       }else{
       for (int i = 0; i < _PicTwoArray.count; i++) {
           UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectMake(10+i*(kScreenWidth-50)/3+10*i, CGRectGetMaxY(cell.SecondContent.frame)+10, (kScreenWidth-50)/3, 100)];
           [imageView setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_PicTwoArray[i]]] placeholderImage:nil];
           [imageView addTarget:self action:@selector(ImagePicY:) forControlEvents:UIControlEventTouchUpInside];
           imageView.tag = i;
           [cell.contentView addSubview:imageView];
              }
       }
            [cell configWithModel:Model];
            [cell.contentView addSubview:cell.PicWomen];
            [cell.contentView addSubview:cell.SecNameLabel];
            [cell.contentView addSubview:cell.SecDateLabel];
       
        return cell;
   } else{
    SecondHomeWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
       if (_dataThereArray.count != 0) {
           SecondHomeWorkModel *Model = _dataThereArray[indexPath.row];
           if (!cell) {
               cell = [[SecondHomeWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Chat"];
               
               if (Model.ThirdType == 2) {
                   NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,Model.ThirdUserVoiceUrl];
                   NSURL *url = [[NSURL alloc]initWithString:urlStr];
                   NSData * audioData = [NSData dataWithContentsOfURL:url];
                   //将数据保存到本地指定位置
                   NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                   NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
                   [audioData writeToFile:filePath atomically:YES];
                   NSError *error = nil;
                   NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                   _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
                   UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
                   Btn.frame = CGRectMake(60, CGRectGetMaxY(cell.NickNameLabel.frame)+15, kScreenWidth/2,40);
                   Btn.tag = indexPath.row;
                   [Btn setBackgroundImage:[UIImage imageNamed:@"图层-51@2x_42.png"] forState:UIControlStateNormal];
                   UILabel *VoiceLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-30, 0, 30, 40)];
                   VoiceLab.backgroundColor = kAppLineColor;
                   VoiceLab.text = [NSString stringWithFormat:@"%ds",(int)_player.duration+1];
                   VoiceLab.font = [UIFont systemFontOfSize:17];
                   VoiceLab.textAlignment = NSTextAlignmentCenter;
                   [Btn addTarget:self action:@selector(PlayMp3:) forControlEvents:UIControlEventTouchUpInside];
                   [Btn addSubview:VoiceLab];
                   [cell.contentView addSubview:Btn];
               }else{
                   cell.TitleLabel.text = Model.ThirdContent;
                   cell.TitleLabel.numberOfLines = 0;
                   CGRect textFrame    = cell.TitleLabel.frame;
                   cell.TitleLabel.frame  = CGRectMake(CGRectGetMaxX(cell.TuPianPic.frame)+10, CGRectGetMaxY(cell.NickNameLabel.frame)+15, kScreenWidth-60, textFrame.size.height = [cell.TitleLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:cell.TitleLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
                   cell.TitleLabel.frame  = CGRectMake(CGRectGetMaxX(cell.TuPianPic.frame)+10, CGRectGetMaxY(cell.NickNameLabel.frame)+15, kScreenWidth-60, textFrame.size.height);
                   
                   [cell.contentView addSubview:cell.TitleLabel];
               }
           }
           [cell configWithModel:Model];
       }else{
       
       }
       
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
   }
}

-(void)FirstPlayVideo:(UIButton *)FirstBt
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    NumberOneModel *Model = _dataOneArray[FirstBt.tag];
    NSString *VideoStr = [NSString stringWithFormat:@"%@%@",BASEURL,Model.NumBerVideoUrl];
    NSArray *paths = @[VideoStr];
    NSArray *names = @[@"You're Beautiful"];
    NSMutableArray *videoList = [NSMutableArray array];
    for (NSInteger i = 0; i<paths.count; i++) {
        SSVideoModel *model = [[SSVideoModel alloc]initWithName:names[i] path:paths[i]];
        [videoList addObject:model];
    }
    SSVideoPlayController *playController = [[SSVideoPlayController alloc]initWithVideoList:videoList];
    SSVideoPlayContainer *playContainer = [[SSVideoPlayContainer alloc]initWithRootViewController:playController];
    [self presentViewController:playContainer animated:NO completion:nil];
}

-(void)SecondPlayVideo:(UIButton *)Secong
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    FirstHomeWorkModel *Model = _dataTwoArray[Secong.tag];
    NSString *VideoStr = [NSString stringWithFormat:@"%@%@",BASEURL,Model.SecondVideoUrl];
//    NSLog(@"视频源%@",VideoStr);
    NSArray *paths = @[VideoStr];
    NSArray *names = @[@"You're Beautiful"];
    NSMutableArray *videoList = [NSMutableArray array];
    for (NSInteger i = 0; i<paths.count; i++) {
        SSVideoModel *model = [[SSVideoModel alloc]initWithName:names[i] path:paths[i]];
        [videoList addObject:model];
    }
    SSVideoPlayController *playController = [[SSVideoPlayController alloc]initWithVideoList:videoList];
    SSVideoPlayContainer *playContainer = [[SSVideoPlayContainer alloc]initWithRootViewController:playController];
    [self presentViewController:playContainer animated:NO completion:nil];
}

-(void)ImagePicX:(UIButton *)Tn
{
    LookPhotoViewController *look = [[LookPhotoViewController alloc]init];
    look.PicUrl = _PicOneArray[Tn.tag];
    look.HowLong = 5;
    [self.navigationController pushViewController:look animated:YES];
}

-(void)ImagePicY:(UIButton *)T
{
    LookPhotoViewController *look = [[LookPhotoViewController alloc]init];
    look.PicUrl = _PicTwoArray[T.tag];
    look.HowLong = 5;
    [self.navigationController pushViewController:look animated:YES];
}

-(void)PlayMp3:(UIButton *)Brn
{
    
    SecondHomeWorkModel *Model = _dataThereArray[Brn.tag];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,Model.ThirdUserVoiceUrl];
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    //将数据保存到本地指定位置
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
    [audioData writeToFile:filePath atomically:YES];
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    if (_player == nil) {
        NSLog(@"error === %@",[error description]);
    }
//    DLog(@"这是啥子%d",(int) _player.duration);
    _player.numberOfLoops = 0;
    [_player prepareToPlay];
    [_player play];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 70)/2, 10, 70, 30)];
    label.text = @"作业详情";
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
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}
//回复弹窗
-(void)TApBTn:(UITapGestureRecognizer *)TAp
{
    NSArray *arr = @[@"填写@2x.png",@"语音@2x.png"];
    NSArray *Tit = @[@"文字",@"语音"];
    NSLog(@"点击回复");
    PushView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-322, kScreenWidth, 322)];
    PushView.backgroundColor = kAppWhiteColor;
    UILabel *TitleLAbel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120)/2, 20, 120, 30)];
    TitleLAbel.textAlignment = NSTextAlignmentCenter;
    TitleLAbel.text = @"选择作业类型";
    TitleLAbel.font = [UIFont boldSystemFontOfSize:16];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(60+i*((kScreenWidth-120-100)/2)+i*100, 80, (kScreenWidth-120-100)/2, (kScreenWidth-120-100)/2);
        button.tag = 10+i;
        [button addTarget:self action:@selector(ChooseBTn:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        UILabel *TitArLabel = [[UILabel alloc]initWithFrame:CGRectMake(60+i*((kScreenWidth-120-100)/2)+i*100+((kScreenWidth-120-100)/2-50)/2, CGRectGetMaxY(button.frame)+10, 50, 20)];
        TitArLabel.font = [UIFont boldSystemFontOfSize:17];
        TitArLabel.text = Tit[i];
        TitArLabel.textAlignment = NSTextAlignmentCenter;
        [PushView addSubview:button];
        [PushView addSubview:TitArLabel];
    }
    UIButton *CloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.backgroundColor = kAppOrangeColor;
    CloseBtn.frame = CGRectMake(0, 322-50, kScreenWidth, 50);
    [CloseBtn setImage:[UIImage imageNamed:@"关闭@2x_7.png"] forState:UIControlStateNormal];
    [CloseBtn addTarget:self action:@selector(CloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [PushView addSubview:TitleLAbel];
    [PushView addSubview:CloseBtn];

    [[[UIApplication sharedApplication].windows lastObject]addSubview:PushView];
}

-(void)ChooseBTn:(UIButton *)ChooBtn
{
    NSLog(@"的佛挡杀佛%@",_AnswerId);
    if (ChooBtn.tag == 10) {
        TeacherAnswerVC *answer = [[TeacherAnswerVC alloc]init];
        answer.CiciTit = @"Hope";
        answer.ActivityId = self.AnswerId; //self.ActivityID;
        [self.navigationController pushViewController:answer animated:YES];
    }else{
        TeacherAnswerVC *answer = [[TeacherAnswerVC alloc]init];
        answer.CiciTit = @"Finay";
        answer.ActivityId = self.AnswerId;
        [self.navigationController pushViewController:answer animated:YES];
    }
}

-(void)CloseBtn:(UIButton *)CloseBtn
{
    NSLog(@"关闭");
    [PushView removeFromSuperview];
}

@end
