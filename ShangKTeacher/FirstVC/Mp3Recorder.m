//
//  Mp3Recorder.m
//  ShangKTeacher
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "Mp3Recorder.h"
#import "lame.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIView.h>
#import "ArrowView.h"
#import "FbwManager.h"

@interface Mp3Recorder()<AVAudioRecorderDelegate>
@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSString *path;
@end

@implementation Mp3Recorder
{
    NSString *_content;//声音地址
    ArrowView*_arrowView;
}

#pragma mark - Init Methods

- (id)initWithDelegate:(id<Mp3RecorderDelegate>)delegate
{
    if (self = [super init]) {
        _delegate = delegate;
        _path = [self mp3Path];
    }
    return self;
}

- (void)setRecorder
{
    _recorder = nil;
    NSError *recorderSetupError = nil;
    NSURL *url = [NSURL fileURLWithPath:[self cafPath]];
    
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //音频质量,采样质量
    
    
    //音频质量,采样质量
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    _recorder = [[AVAudioRecorder alloc] initWithURL:url
                                            settings:settings
                                               error:&recorderSetupError];
    if (recorderSetupError) {
        //        NSLog(@"%@",recorderSetupError);
    }
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
    [_recorder prepareToRecord];
}

- (void)setSesstion
{
    _session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [_session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(_session == nil){
        
        NSLog(@"Error creating session: %@", [sessionError description]);
        
    }
    else{
        
        [_session setActive:YES error:nil];
    }
}

#pragma mark - Public Methods
- (void)setSavePath:(NSString *)path
{
    self.path = path;
}

- (void)startRecord
{
    [self setSesstion];
    [self setRecorder];
    [_recorder record];
}


- (void)stopRecord
{
    double cTime = _recorder.currentTime;
    [_recorder stop];
    
    if (cTime < 1) {
        [SVProgressHUD showErrorWithStatus:@"录音时间太短啦"];
    }

    if (cTime > 1 ) {
//        _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
//        __weak typeof(self) weakSelf = self;
//        [_arrowView setBackgroundColor:[UIColor clearColor]];
//        [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定上传该音频么？"];
//        [_arrowView setSelectBlock:^(UIButton *button){
//            if (button.tag == 10) {
//            }else if (button.tag == 11){
        [self audio_PCMtoMP3];
//            }
//        }];
//        [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
//        [_arrowView showArrowView:YES];
        
    }else {
        [_recorder deleteRecording];
        if ([_delegate respondsToSelector:@selector(failRecord)]) {
            [_delegate failRecord];
        }
    }
}


- (void)cancelRecord
{
    [_recorder stop];
    [_recorder deleteRecording];
}

- (void)deleteMp3Cache
{
    [self deleteFileWithPath:[self mp3Path]];
}

- (void)deleteCafCache
{
    [self deleteFileWithPath:[self cafPath]];
}

- (void)deleteFileWithPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager removeItemAtPath:path error:nil])
    {
        
    }
}

#pragma mark - Convert Utils
- (void)audio_PCMtoMP3
{
    FbwManager *Manager = [FbwManager shareManager];
    NSString *cafFilePath = [self cafPath];
    NSString *mp3FilePath = [self mp3Path];
    
    // remove the old mp3 file
    [self deleteMp3Cache];
    
    //   NSLog(@"MP3转换开始");
    if (_delegate && [_delegate respondsToSelector:@selector(beginConvert)]) {
        [_delegate beginConvert];
    }
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        //        NSLog(@"%@",[exception description]);
    }
    @finally {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    }
    
    [self deleteCafCache];
    //    NSLog(@"MP3转换结束");
    
    NSData *voiceda = [NSData dataWithContentsOfFile:[self mp3Path]];
    if (_delegate && [_delegate respondsToSelector:@selector(endConvertWithMp3Data:)]) {
        [_delegate endConvertWithMp3Data:voiceda];
    }
    Manager.LuYinData = voiceda;
//    NSLog(@"录音数据%@",Manager.LuYinData);
//    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"wanshidingdang";
//    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"p04SeyUgHnHnsDLk8qkhTrBsltQ=";
//    __block UpYun *uy = [[UpYun alloc] init];
//    uy.successBlocker = ^(NSURLResponse *response, id responseData) {
//        
//    };
//    uy.failBlocker = ^(NSError * error) {
//        NSString *message = [error.userInfo objectForKey:@"message"];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        //        NSLog(@"error %@", message);
//    };
//    uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
//        
//    };
//    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
//    long long int date = (long long int)time;
//    NSString *timeStr = [NSString stringWithFormat:@"%lld",date];
//    //voice + UUID + 日期字符
//    NSString *saveKey = [NSString stringWithFormat:@"/voice/chat/%@/%@.mp3",[BabUserManager sharedUserManager].uuid,timeStr];
//    _content = [NSString stringWithFormat:@"%@%@",KUPHost,saveKey];
//    //    NSLog(@"聊天室语音地址%@",_content);
//    if (_delegate && [_delegate respondsToSelector:@selector(endConvertWithData:)]) {
//        [_delegate endConvertWithData:_content];
//    }
//    [uy uploadFile:voiceda saveKey:saveKey];
    
    
    
}



#pragma mark - Path Utils
- (NSString *)cafPath
{
    NSString *cafPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.caf"];
    return cafPath;
}

- (NSString *)mp3Path
{
    NSString *mp3Path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"mp3.caf"];
    return mp3Path;
}


@end
