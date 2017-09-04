//
//  EveryVideosVC.h
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TCBlobDownload/TCBlobDownload.h>
@interface EveryVideosVC : UIViewController<TCBlobDownloaderDelegate>
@property(nonatomic,copy) NSString *videoCourseId;
@property(nonatomic,copy) NSString *videoCourseUrl;
@property(nonatomic,copy) NSString *videoCourseName;
@property(nonatomic,copy) NSString *videoCoursePrice;
@property(nonatomic,copy) NSString *videoCourseSellCount;
@property(nonatomic,copy) NSString *CouldHelp;
@property (nonatomic,strong) TCBlobDownloadManager *sharedDownloadManager;
@end
