//
//  PublishJobVC.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#define MAX_STARWORDS_LENGTH 200
#import "PublishJobVC.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <TZImagePickerController.h>
#import "TZTestCell.h"
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "LookPhotoViewController.h"
#import "TZVideoPlayerController.h"

@interface PublishJobVC ()<UITextViewDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UITextView     * _firstTextView;
    UILabel        * _activityName;
    UILabel        *  TitleLabel;
    NSMutableArray * _selectedPhotos;
    CGFloat          _itemWH;
    CGFloat          _margin;
    NSMutableArray * _selectedAssets;
    BOOL             _isSelectOriginalPhoto;
    UILabel        * _FirstLabelNum;
    UIButton       * _VideoBtn;
    UIButton       * button2;
}
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UITextField *maxCountTF; ///< 照片最大可选张数，设置为1即为单选模式
@property (strong, nonatomic) UITextField *columnNumberTF;
@property (nonatomic,strong)  UIImageView *photoimage;
@property (nonatomic,strong)  NSString    *path;
@end
@implementation PublishJobVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self createNav];
    [self createUI];
    self.view.backgroundColor = KAppBackBgColor;
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

-(void)createUI
{
    _firstTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)];
    _firstTextView.backgroundColor = kAppWhiteColor;
    _firstTextView.tag = 10;
    _firstTextView.delegate = self;
    _activityName = [[UILabel alloc]initWithFrame:CGRectMake(16, 64, 120, 30)];
    _activityName.text = @"请输入作业内容...";
    _activityName.font = [UIFont systemFontOfSize:15];
    _activityName.textColor = [UIColor lightGrayColor];
    
    if ([self.NavTitle isEqualToString:@"发布图文作业"]) {
        _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 170, 100, 20)];
        _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
        _FirstLabelNum.font = [UIFont systemFontOfSize:16];
        _FirstLabelNum.text = @"0/200";
        TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_firstTextView.frame)+15, kScreenWidth-30, 20)];
        TitleLabel.text = @"添加图片(3张)";
        TitleLabel.textColor = kAppLightGrayColor;
        [_firstTextView addSubview:_FirstLabelNum];
        [self.view addSubview:TitleLabel];
    }else if ([self.NavTitle isEqualToString:@"发布视频作业"]){
        _FirstLabelNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 170, 100, 20)];
        _FirstLabelNum.textAlignment = NSTextAlignmentCenter;
        _FirstLabelNum.font = [UIFont systemFontOfSize:16];
        _FirstLabelNum.text = @"0/200";
        TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_firstTextView.frame)+15, kScreenWidth-30, 20)];
        TitleLabel.textColor = kAppLightGrayColor;
        TitleLabel.text = @"添加视频(只能上传一个视频文件)";
        [_firstTextView addSubview:_FirstLabelNum];
        [self.view addSubview:TitleLabel];
    }
    if ([self.NavTitle isEqualToString:@"发布图文作业"]) {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(TitleLabel.frame)+20, self.view.tz_width, kScreenHeight - (CGRectGetMaxY(_firstTextView.frame)+15+40)) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = KAppBackBgColor;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    }else{
        _VideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _VideoBtn.frame = CGRectMake(5, CGRectGetMaxY(TitleLabel.frame)+10, kScreenWidth/4, kScreenWidth/4);
        [_VideoBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9-拷贝@2x_40.png"] forState:UIControlStateNormal];
        [_VideoBtn addTarget:self action:@selector(upvideo) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_firstTextView];
    [self.view addSubview:_activityName];
    [self.view addSubview:_VideoBtn];
    [self.view addSubview:_collectionView];
}

-(void)upvideo
{
    TZImagePickerController *TZvc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    [self presentViewController:TZvc animated:YES completion:nil];
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset
{
    [_selectedAssets addObject:asset];
    [_VideoBtn setImage:coverImage forState:UIControlStateNormal];
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
        _path = outputPath;
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"图层-2@2x.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake((kScreenWidth/4 - kScreenWidth/8)/2, (kScreenWidth/4 - kScreenWidth/8)/2, kScreenWidth/8, kScreenWidth/8);
    [btn addTarget:self action:@selector(watch) forControlEvents:UIControlEventTouchUpInside];
    [_VideoBtn addSubview:btn];
}

//预览视频
-(void)watch
{
    id asset = _selectedAssets[0];
    NSLog(@"我来看看%@",_selectedAssets[0]);
    TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
    TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
    vc.model = model;
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_selectedPhotos.count+1 <= 3)
    {
        return _selectedPhotos.count+1;
    }
    else
    {
        return 3;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    if(indexPath.item == _selectedPhotos.count)
    {
        cell.imageView.image = [UIImage imageNamed:@"矩形-9-拷贝@2x_40.png"];
        cell.deleteBtn.hidden = YES;
    }
    else
    {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        [cell.deleteBtn addTarget:self action:@selector(deletepic:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = 200 + indexPath.item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.item == _selectedPhotos.count)
    {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
            
        }];
        
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            _imagePickerVc = [[UIImagePickerController alloc] init];
            _imagePickerVc.delegate = self;
            _imagePickerVc.allowsEditing = YES;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                _imagePickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        }];
        
        UIAlertAction *picture = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            TZImagePickerController *TZvc = [[TZImagePickerController alloc]initWithMaxImagesCount:3 delegate:self];
            [self presentViewController:TZvc animated:YES completion:nil];
        }];
        [alertVc addAction:cancle];
        [alertVc addAction:picture];
        [alertVc addAction:camera];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
    else
    {
        UIImageView *image = [[UIImageView alloc]initWithImage:_selectedPhotos[indexPath.row]];
        LookPhotoViewController *look = [[LookPhotoViewController alloc]init];
        look.image = image;
        [self.navigationController pushViewController:look animated:YES];
    }
}

-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [_selectedPhotos addObjectsFromArray:photos];
//    NSLog(@"选择照片张数%lu",(unsigned long)_selectedPhotos.count);
    if(_selectedPhotos.count > 3)
    {
        for(int i =3 ; i < _selectedPhotos.count; i++)
        {
            [_selectedPhotos removeObjectAtIndex:i];
        }
    }
    if(_selectedPhotos.count == 4)
    {
        [_selectedPhotos removeLastObject];
    }
    [_collectionView reloadData];
}
-(void)deletepic:(UIButton*)btn
{
    NSInteger i = btn.tag - 200;
    [_selectedPhotos removeObjectAtIndex:i];
    [_collectionView reloadData];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"选择完成");
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        _photoimage = [[UIImageView alloc]init];
        _photoimage.image = info[UIImagePickerControllerEditedImage];
        if(_selectedPhotos.count<3)
        {
            [_selectedPhotos addObject:info[UIImagePickerControllerEditedImage]];
        }
        UIImageWriteToSavedPhotosAlbum(_photoimage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
}
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    [_collectionView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_firstTextView resignFirstResponder];
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
    label.text = self.NavTitle;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BKGlick:) forControlEvents:UIControlEventTouchUpInside];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth - 60, 20, 40, 15);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button2 setTitle:@"提交" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(BtnMGClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BKGlick:(UIButton *)BT
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    Manager.PullPage = 3;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)BtnMGClick:(UIButton *)BN
{
    NSLog(@"你是不是炸了");
    FbwManager *Manager = [FbwManager shareManager];
    UITextView *textView = [self.view viewWithTag:10];
    __weak typeof(self) weakSelf = self;
    if ([self.NavTitle isEqualToString:@"发布图文作业"]) {
        button2.userInteractionEnabled = NO;
        BN.userInteractionEnabled = NO;
        if (textView.text.length != 0) {
            if (_selectedPhotos.count != 0) {
                NSLog(@"!!!%ld",(long)_selectedPhotos.count);
                [SVProgressHUD showWithStatus:@"上传中"];
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.courseId,@"teacherId":Manager.UUserId,@"type":@1,@"content":textView.text} url:UrL_AddHomeWork success:^(id responseObject) {
                    NSLog(@"你看看文字作业%@",responseObject);
                    NSDictionary *RootDic =[responseObject objectForKey:@"data"];
                    NSString *STR = [RootDic objectForKey:@"id"];
                    if (_selectedPhotos.count == 1) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageCourseHomeworkIssuePhoto",
                                                   @"fkPurposeId":STR};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                              constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageCourseHomeworkIssuePhoto0.png"]
                                                         mimeType:@"image/png"];
                                 
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      [SVProgressHUD dismiss];
                                      Manager.IsListPulling = 3;
                                      Manager.PullPage = 3;
                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                    }else if (_selectedPhotos.count == 2){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageCourseHomeworkIssuePhoto",
                                                   @"fkPurposeId":STR};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                              constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageCourseHomeworkIssuePhoto0.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      //                                      [SVProgressHUD dismiss];
                                      //                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageCourseHomeworkIssuePhoto",
                                                   @"fkPurposeId":STR};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageCourseHomeworkIssuePhoto1.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      [SVProgressHUD dismiss];
                                      Manager.IsListPulling = 3;
                                      Manager.PullPage = 3;
                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                    }else if (_selectedPhotos.count == 3){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageCourseHomeworkIssuePhoto",
                                                   @"fkPurposeId":STR};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                              constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[0]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageCourseHomeworkIssuePhoto0.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      //                                      [SVProgressHUD dismiss];
                                      //                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageCourseHomeworkIssuePhoto",
                                                   @"fkPurposeId":STR};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[1]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageCourseHomeworkIssuePhoto1.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      //                                      [SVProgressHUD dismiss];
                                      //                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *Dict = @{@"fileType":@"image",
                                                   @"filePurpose":@"imageCourseHomeworkIssuePhoto",
                                                   @"fkPurposeId":STR};
                            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            [manager POST:UrL_UploadFile
                               parameters:Dict
                constructingBodyWithBlock:
                             ^(id<AFMultipartFormData>_Nonnull formData) {
                                 //                             for (int i = 0; i<_selectedPhotos.count; i++) {
                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[2]);
                                 [formData appendPartWithFileData:imageData
                                                             name:@"uploadFile"
                                                         fileName:[NSString stringWithFormat:@"imageCourseHomeworkIssuePhoto2.png"]
                                                         mimeType:@"image/png"];
                                 //                                 }
                             }progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSLog(@"图片上传成果啦");
                                      [SVProgressHUD dismiss];
                                      Manager.IsListPulling = 3;
                                      Manager.PullPage = 3;
                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                      
                                  }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      NSLog(@"图片上传出错啦");
                                  }];
                        });
                    }
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSDictionary *Dict = @{@"fileType":@"image",////imageCourseCarousel
//                                               @"filePurpose":@"imageCourseHomeworkIssuePhoto",
//                                               @"fkPurposeId":STR};
//                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                        [manager POST:UrL_UploadFile
//                           parameters:Dict
//                           constructingBodyWithBlock:
//                         ^(id<AFMultipartFormData>_Nonnull formData) {
//                             for (int i = 0; i<_selectedPhotos.count; i++) {
//                                 NSData *imageData = UIImagePNGRepresentation(_selectedPhotos[i]);
//                                 [formData appendPartWithFileData:imageData
//                                                             name:@"uploadFile"
//                                                         fileName:[NSString stringWithFormat:@"imageCourseHomeworkIssuePhoto%d.png",i]
//                                                         mimeType:@"image/png"];
//                                  }
//                                }progress:nil
//                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////                                  [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//                                  NSLog(@"图片上传成果啦");
//                                  [SVProgressHUD dismiss];
//                                  [weakSelf.navigationController popViewControllerAnimated:YES];
//                                  
//                              }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                  NSLog(@"图片上传出错啦");
//                         }];
//                    });
                } failure:^(NSError *error) {
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"至少添加一张图片"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"作业内容不能为空"];
        }
    }else{
        
        NSLog(@"你炸了没%@",_path);
        NSLog(@"%ld",(unsigned long)_path.length);
        if (_path.length > 0) {
            button2.userInteractionEnabled = NO;
        BN.userInteractionEnabled = NO;
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"courseId":self.courseId,@"teacherId":Manager.UUserId,@"type":@2,@"content":textView.text} url:UrL_AddHomeWork success:^(id responseObject) {
                NSDictionary *RootDic = [responseObject objectForKey:@"data"];
                NSString *VideoId = [RootDic objectForKey:@"id"];
//                NSLog(@"你悄悄%@",VideoId);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showWithStatus:@"上传中"];
                    NSDictionary *Dict = @{@"fileType":@"video",
                                           @"filePurpose":@"imageCourseHomeworkIssueVideo",
                                           @"fkPurposeId":VideoId};
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    if(_path){
                        [manager POST:UrL_UploadFile
                           parameters:Dict
            constructingBodyWithBlock:
                         ^(id<AFMultipartFormData>_Nonnull formData) {
                             NSData *videoData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_path]];
                             [formData appendPartWithFileData:videoData
                                                         name:@"uploadFile"
                                                     fileName:@"imageCourseHomeworkVideo.mov"
                                                     mimeType:@"video/mp4"];
                         }progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  NSLog(@"视频上传成果啦");
                                  [SVProgressHUD dismiss];
                                  Manager.IsListPulling = 3;
                                  Manager.PullPage = 3;
                                  [weakSelf.navigationController popViewControllerAnimated:YES];
                                  
                              }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  NSLog(@"视频上传出错啦");
                              }];
                    }
                });
            } failure:^(NSError *error) {
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"正在导出或者未选择视频,请稍等"];
        }
                           
    }
}

@end
