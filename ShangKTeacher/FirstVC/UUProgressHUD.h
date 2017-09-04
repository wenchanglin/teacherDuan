//
//  UUProgressHUD.h
//  ShangKTeacher
//
//  Created by apple on 16/12/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUProgressHUD : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic,strong)UIImageView *huatongBgView;

+ (void)show;

+(void)remove;

+ (void)dismissWithSuccess:(NSString *)str;

+ (void)dismissWithError:(NSString *)str;
+ (void)changeSubTitle:(NSString *)str;
+ (void)changeBbImage:(UIImage *)image;
@end
