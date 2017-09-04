//
//  TeacherAnswerVC.m
//  ShangKTeacher
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "TeacherAnswerVC.h"
#import "UUProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "Mp3Recorder.h"
#import "FbwManager.h"

#define MAX_STARWORDS_LENGTH 200
@interface TeacherAnswerVC ()<UITextViewDelegate,Mp3RecorderDelegate>
{
    UITextView     * _firstTextView;
    UILabel        * _activityName;
    UILabel        * _FirstLabelNum;
    Mp3Recorder    * MP3;//录音
    NSInteger        playTime;
    NSTimer        * playTimer;
    UIButton       * ImageBtn;
    AVAudioPlayer  * _player;
    UIView         * _LuYinView;
    UIButton       * button2;
}
@end

@implementation TeacherAnswerVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    [self createNav];
    [self createUI];
    MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
    self.view.backgroundColor = KAppBackBgColor;
}

-(void)createUI
{
    if ([self.CiciTit isEqualToString:@"Hope"]) {
        _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)];
        _firstTextView.backgroundColor = kAppWhiteColor;
        _firstTextView.tag = 10;
        _firstTextView.delegate = self;
        _activityName = [[UILabel alloc]initWithFrame:CGRectMake(6, 64, 120, 30)];
        _activityName.text = @"请输入回复内容...";
        _activityName.font = [UIFont systemFontOfSize:15];
        _activityName.textColor = [UIColor lightGrayColor];
        _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 170, 100, 20)];
        _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
        _FirstLabelNum.font = [UIFont systemFontOfSize:16];
        _FirstLabelNum.text = @"0/200";
        
        [_firstTextView addSubview:_FirstLabelNum];
        [self.view addSubview:_firstTextView];
        [self.view addSubview:_activityName];
    }else{
        UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, kScreenHeight-200, 100, 20)];
        TitleLabel.text = @"按住说话";
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        TitleLabel.font = [UIFont boldSystemFontOfSize:17];
        ImageBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, CGRectGetMaxY(TitleLabel.frame)+10, 100, 100)];
        ImageBtn.layer.cornerRadius = 50;
        ImageBtn.layer.masksToBounds = YES;
        [ImageBtn setBackgroundImage:[UIImage imageNamed:@"语音-(1)@2x_14.png"] forState:UIControlStateNormal];
        [ImageBtn addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        [ImageBtn addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        [ImageBtn addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [ImageBtn addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [ImageBtn addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        UILabel *TalkTit = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-210)/2, CGRectGetMaxY(ImageBtn.frame)+10, 210, 12)];
        TalkTit.textAlignment = NSTextAlignmentCenter;
        TalkTit.textColor = kAppLightGrayColor;
        TalkTit.text = @"一次只能录制一个语音哦!";
        
        [self.view addSubview:TitleLabel];
        [self.view addSubview:ImageBtn];
        [self.view addSubview:TalkTit];
    }
}

-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil
                                                    message:@"上课呗需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    return bCanRecord;
}

#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button{
    
    //系统大于7.0 是否开启麦克风
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)] && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                _player = [[AVAudioPlayer alloc] init];
                [_LuYinView  removeFromSuperview];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    NSArray *files = [[ NSFileManager defaultManager ]  subpathsAtPath :cachPath];
                    NSLog ( @"files :%lu" ,(unsigned long)[files  count ]);
                    for (NSString * p in files)
                    {
                        NSError * error;
                        NSString * path = [cachPath stringByAppendingPathComponent:p];
                        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
                        {
                            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                        }
                    }
                });
                [MP3 startRecord];
                playTime = 0;
                playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
                [UUProgressHUD show];
            }
            else {
                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                    
                    [SVProgressHUD showErrorWithStatus:@"手机版本过低"];
                }else{
                    [self canRecord];
                }
            }
        }];
    }
}

- (void)endRecordVoice:(UIButton *)button{
    [UUProgressHUD remove];
    if (playTimer) {
        [MP3 stopRecord];
        if (playTime > 0) {
            [self createLuYinView];
        }
        [playTimer invalidate];
        playTimer = nil;
    }
    [playTimer setFireDate:[NSDate distantFuture]];
}

-(void)createLuYinView
{
//    ImageBtn.userInteractionEnabled = NO;
//    NSLog(@"时间长%ld",playTime+1);
    _LuYinView.hidden = NO;
    _LuYinView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 60)];
    _LuYinView.backgroundColor = kAppWhiteColor;
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(10, 10, kScreenWidth/2, 40);
    [Btn setBackgroundImage:[UIImage imageNamed:@"图层-51@2x_42.png"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(PlayLuYin:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *VoiceLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-30, 0, 30, 40)];
    VoiceLab.backgroundColor = kAppLineColor;
    VoiceLab.text = [NSString stringWithFormat:@"%lds",playTime+1];
    VoiceLab.font = [UIFont systemFontOfSize:17];
    VoiceLab.textAlignment = NSTextAlignmentCenter;
    UIButton *DeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DeleteBtn.frame = CGRectMake(CGRectGetMaxX(Btn.frame)+5, 20, 20, 20);
    [DeleteBtn setBackgroundImage:[UIImage imageNamed:@"删除@2x.png"] forState:UIControlStateNormal];
    [DeleteBtn addTarget:self action:@selector(DeteLuYin:) forControlEvents:UIControlEventTouchUpInside];
    [_LuYinView addSubview:DeleteBtn];
    [Btn addSubview:VoiceLab];
    [_LuYinView addSubview:Btn];
    [self.view addSubview:_LuYinView];
}

-(void)PlayLuYin:(UIButton *)Btn
{
    FbwManager *Manager = [FbwManager shareManager];
    //将数据保存到本地指定位置
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
    [Manager.LuYinData writeToFile:filePath atomically:YES];
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    if (_player == nil) {
        NSLog(@"error === %@",[error description]);
    }
    _player.numberOfLoops = 0;
    [_player prepareToPlay];
    [_player play];
}

-(void)DeteLuYin:(UIButton *)Det
{
    _player = [[AVAudioPlayer alloc] init];
    [_LuYinView  removeFromSuperview];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[ NSFileManager defaultManager ]  subpathsAtPath :cachPath];
        NSLog ( @"files :%lu" ,(unsigned long)[files  count ]);
        for (NSString * p in files)
        {
            NSError * error;
            NSString * path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    });
    [self reloadInputViews];
    _LuYinView.hidden = YES;
}

- (void)cancelRecordVoice:(UIButton *)button{
    if (playTimer) {
        [MP3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
        
    }
    [playTimer setFireDate:[NSDate distantFuture]];
    [UUProgressHUD dismissWithError:@"取消发送"];
}

- (void)RemindDragExit:(UIButton *)button{
    [UUProgressHUD changeSubTitle:@"松开手指,取消发送"];
    [UUProgressHUD changeBbImage:[UIImage imageNamed:@"语音-(1)@2x.png"]];
}
- (void)RemindDragEnter:(UIButton *)button{
    [UUProgressHUD changeSubTitle:@"手指上滑,取消发送"];
    [UUProgressHUD changeBbImage:[UIImage imageNamed:@"语音-(1)@2x.png"]];
}

- (void)countVoiceTime{
    playTime ++;
    if (playTime>=56) {
        [MP3 startRecord];
        playTime = 0;
        playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CCC) userInfo:nil repeats:YES];
        [UUProgressHUD show];
    }
}

-(void)CCC
{
    [playTimer invalidate];
    playTimer = nil;
    playTime = -100;
    [UUProgressHUD remove];
    [SVProgressHUD showErrorWithStatus:@"录音时间上限啦"];
    [playTimer invalidate];
    playTimer = nil;
    [UUProgressHUD remove];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        switch (textView.tag) {
            case 10:
            {
                _activityName.text =@"";
            }
                break;
            default:
                break;
        }
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        switch (textView.tag) {
            case 10:
            {
                _activityName.text =@"请输入文字...";
            }
                break;
            default:
                break;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSString  * nsTextContent = textView.text;
    NSInteger   existTextNum = [nsTextContent length];
    _FirstLabelNum.text = [NSString stringWithFormat:@"%ld/200",(long)0+existTextNum];
    if (existTextNum > 199) {
        _FirstLabelNum.text = @"200/200";
        [SVProgressHUD showErrorWithStatus:@"输入内容过长咯"];
    }
    //        NSLog(@"剩余：%ld",100-existTextNum);
    //        NSLog(@"剩余：%ld",0+existTextNum);
    NSString *toBeString               = textView.text;
    NSArray *current                   = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode  = [current firstObject];
    NSString *lang = [currentInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange     = [textView markedTextRange];
        UITextPosition *position       = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                NSRange rangeIndex     = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                if (rangeIndex.length  == 1){
                    textView.text      = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                }else{
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }else{
        }
    }else {
        if (toBeString.length > MAX_STARWORDS_LENGTH){
            NSRange rangeIndex     = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length  == 1){
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 120)/2, 10, 120, 30)];
    label.text = @"回复作业";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BKlick:) forControlEvents:UIControlEventTouchUpInside];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 60, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button2 setTitle:@"提交" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnMClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)BKlick:(UIButton *)BTn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)BtnMClick:(UIButton *)Tn
{
    if ([self.CiciTit isEqualToString:@"Hope"]) {
    FbwManager *Manager = [FbwManager shareManager];
    __weak typeof(self) weakSelf = self;
    if (_firstTextView.text.length != 0) {
        button2.userInteractionEnabled = NO;
        Tn.userInteractionEnabled = NO;
        [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkTeacherId":Manager.UUserId,@"fkHomeworkAnswerId":self.ActivityId,@"type":@1,@"content":_firstTextView.text} url:UrL_TeacherAnswer success:^(id responseObject) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
        }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入回复内容"];
         }
    }else{
        FbwManager *Manager = [FbwManager shareManager];
        NSLog(@"时间%ld",playTime+1);
        __weak typeof(self) weakSelf = self;
        if ( Manager.LuYinData.length != 0) {
            button2.userInteractionEnabled = NO;
            Tn.userInteractionEnabled = NO;
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"fkTeacherId":Manager.UUserId,@"fkHomeworkAnswerId":self.ActivityId,@"type":@2,@"content":@""} url:UrL_TeacherAnswer success:^(id responseObject) {
                NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                NSString *VoiceId = [RootDic objectForKey:@"id"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showWithStatus:@"上传中"];
                    NSDictionary *Dict = @{@"fileType":@"voice",
                                           @"filePurpose":@"imageCourseHomeworkReplyPhoto",
                                           @"fkPurposeId":VoiceId,
                                           @"playTime":[NSString stringWithFormat:@"%ld",playTime+1]};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    
                        [manager POST:UrL_UploadFile
                           parameters:Dict
            constructingBodyWithBlock:
                         ^(id<AFMultipartFormData>_Nonnull formData) {
                             [formData appendPartWithFileData:Manager.LuYinData
                                                         name:@"uploadFile"
                                                     fileName:@"imageCourseHomeworkReplyPhoto.mp3"
                                                     mimeType:@"video/mp4"];
                         }progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  NSLog(@"音频上传成果啦");
                                  [SVProgressHUD dismiss];
                                  [weakSelf.navigationController popViewControllerAnimated:YES];
                              }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  NSLog(@"音频上传出错啦");
                              }];
                });
            } failure:^(NSError *error) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请您录音再上传"];
        }
    }
}

@end
