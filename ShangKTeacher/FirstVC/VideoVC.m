//
//  VideohomeworkViewController.m
//  Parents1
//
//  Created by Mac on 16/9/29.
//  Copyright © 2016年 luli. All rights reserved.
//

#import "VideoVC.h"
#import <TZImagePickerController.h>
#import "TZVideoPlayerController.h"
#import "TZImageManager.h"


@interface VideoVC ()<UITextViewDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UITextView *text;
@property (nonatomic,strong) UILabel *melabel;
@property (nonatomic,strong) NSMutableArray *selectImage;
@property (nonatomic,strong) NSMutableArray *selectassts;
@property (nonatomic,strong) UIButton *Video;
@property (nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,strong) NSString *answerid;
@property (nonatomic,strong) NSString *path;
//@property (nonatomic,strong) MBProgressHUD *hub;


@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kAppWhiteColor;
    _selectImage = [[NSMutableArray alloc]init];
    _selectassts = [NSMutableArray array];
    [self setnavigation];
    [self creatUI];
}
-(void)setnavigation
{
    self.navigationItem.title = @"提交作业";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"图层-73@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(Return)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = item;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(updown)];
    item1.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item1;
}
-(void)Return
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatUI
{
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)];
    myview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myview];
    UILabel *label = [[UILabel alloc]init];
    label.text  = @"录制视频";
    label.frame = CGRectMake(30, 25, 200, 20);
    label.textColor = [UIColor lightGrayColor];
    [myview addSubview:label];
    _Video = [UIButton buttonWithType:UIButtonTypeCustom];
    [_Video setImage:[UIImage imageNamed:@"视频-(5)@2x.png"] forState:UIControlStateNormal];
    _Video.frame = CGRectMake(kScreenWidth/2-70, 50, 140, 140);
    [_Video addTarget:self action:@selector(upvideo) forControlEvents:UIControlEventTouchUpInside];
    [myview addSubview:_Video];
    UIView *secondview = [[UIView alloc]initWithFrame:CGRectMake(0, 274, kScreenWidth, 100)];
    secondview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondview];
    UILabel *mylabel = [[UILabel alloc]init];
    mylabel.text = @"说明";
    mylabel.frame = CGRectMake(14, 10, 200, 20);
    [secondview addSubview:mylabel];
    _text = [[UITextView alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth-20, 60)];
    _text.delegate = self;
    _melabel = [[UILabel alloc]init];
    _melabel.font = [UIFont systemFontOfSize:15];
    _melabel.frame = CGRectMake(7, 5, 200, 20);
    _melabel.text = @"请输入备注说明";
    _melabel.textColor = [UIColor lightGrayColor];
    [_text addSubview:_melabel];
    [secondview addSubview:_text];
}
-(void)updown
{
//    _hub = [[MBProgressHUD alloc]initWithView:self.view];
//    [self.view addSubview:_hub];
//    _hub.mode = MBProgressHUDModeIndeterminate;
//    [_hub showAnimated:YES];
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
//    NSDictionary *params = @{@"homeworkId":@"re",@"studentId":userid,@"type":@"2",@"content":_text.text};
//    [Tools posturl:Job_submit_picture_text params:params sucess:^(id responseObject) {
//        NSLog(@"kkkkkkkk%@",responseObject);
//        if([responseObject[@"errcode"]intValue] == 0)
//        {
//            _answerid = responseObject[@"data"][@"id"];
//            NSLog(@"关于主键的ID%@",_answerid);
//            NSLog(@"上传成功");
            [self updownvideo];
            //        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self updownpic];
            //        });
//        }
//    } failure:^(NSError *error) {
//    }];
//    
}
//视频上传至服务器
-(void)updownvideo
{
//    NSString *url = [Testserver stringByAppendingString:Uplod_file_URL];
//    NSDictionary *Dict = @{@"fileType":@"video",@"filePurpose":@"imageCourseHomeworkAnswerVideo",@ "fkPurposeId":_answerid};
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    if(_path)
//    {
//        //    NSString *mypath = [NSHomeDirectory() stringByAppendingString:_path];
//        NSURL *myurl = [NSURL fileURLWithPath:_path];
//        NSData *videoData = [NSData dataWithContentsOfURL:myurl];
//        [manager POST:url parameters:Dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            [formData appendPartWithFileData:videoData name:@"uploadFile"fileName:@"video1.mov"mimeType:@"video/mp4"];
//        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [_hub removeFromSuperViewOnHide];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //            CoursehomeworkViewController *vc = [[CoursehomeworkViewController alloc]init];
//                int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
//                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
//                //            [self.navigationController popViewControllerAnimated:YES];
//            });
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"视频上传说失败");
//        }];
//    }
    
}
//从相册中获取视频
-(void)upvideo
{
    TZImagePickerController *TZvc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    [self presentViewController:TZvc animated:YES completion:nil];
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    if(_text.text.length != 0)
    {
        _melabel.hidden = YES;
    }
    else
    {
        _melabel.hidden = NO;
    }
}
//当选择完照片
//-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
//{
//    [_selectImage addObjectsFromArray:photos];
//    [_selectassts addObjectsFromArray:assets];
//
//    [_Video setImage:_selectassts[0] forState:UIControlStateNormal];
//}
//在相册选择完视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset
{
    
    [_selectassts addObject:asset];
    [_Video setImage:coverImage forState:UIControlStateNormal];
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
        _path = outputPath;
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        //     Export completed, send video here, send by outputPath or NSData
        //     导出完成，在这里写上传代码，通过路径或者通过NSData上传
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"播放@2x.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(50, 50, 40, 40);
    [btn addTarget:self action:@selector(watch) forControlEvents:UIControlEventTouchUpInside];
    [_Video addSubview:btn];
}
//预览视频
-(void)watch
{
    id asset = _selectassts[0];
    NSLog(@"我来看看%@",asset);
    TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
    TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
    vc.model = model;
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
