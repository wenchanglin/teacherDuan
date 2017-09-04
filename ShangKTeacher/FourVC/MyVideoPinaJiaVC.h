//
//  MyVideoPinaJiaVC.h
//  ShangKTeacher
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"
@interface MyVideoPinaJiaVC : UIViewController<TPFloatRatingViewDelegate>
@property (nonatomic,strong)TPFloatRatingView *ratingView;
@property (nonatomic,strong)UILabel *ratingLabel;
@property(nonatomic,copy) NSString *VideoId;
@end
