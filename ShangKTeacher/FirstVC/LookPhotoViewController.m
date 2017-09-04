//
//  LookPhotoViewController.m
//  ShangKTeacher
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "LookPhotoViewController.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@interface LookPhotoViewController ()
{
    CGFloat ImageHeight;
}
@end
@implementation LookPhotoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor = [UIColor blackColor];
    if (self.HowLong == 5) {
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0,200, kScreenWidth, kScreenHeight-400)];
        [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,self.PicUrl]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //宽图
            CGSize size = image.size;
            CGFloat width = kScreenWidth;
            ImageHeight = width * size.height / size.width;
            if (ImageHeight > kScreenHeight) {
                ImageHeight = kScreenHeight;
                width = ImageHeight * size.width / size.height;
            }
            self.image.frame = CGRectMake(0, 64, width, ImageHeight);
            if (ImageHeight > kScreenHeight) {
                CGPoint center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
                self.image.center = center;
            }
        }];
        [self.view addSubview:self.image];
    }else{
       self.image.frame = CGRectMake(0,200, kScreenWidth, kScreenHeight-400);
       [self.view addSubview:self.image];
    }
}

-(void)BKGlick:(UIButton*)Tnb
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 120)/2, 20, 120, 30)];
    label.text = @"照片查看";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 20, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BKGlick:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}
@end
