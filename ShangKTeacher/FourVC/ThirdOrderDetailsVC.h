//
//  ThirdOrderDetailsVC.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"
@interface ThirdOrderDetailsVC : UIViewController<TPFloatRatingViewDelegate>
@property(nonatomic,copy) NSString *OrderId;
@property(nonatomic,copy) NSString *OrderFkGoodBaseId;
@property(nonatomic,copy) NSString *OrderGoodBaseName;
@property(nonatomic,copy) NSString *OrderGoodBasePhotoUrl;
@property(nonatomic,copy) NSString *OrderSinglePrice;
@property(nonatomic,copy) NSString *OrderSumPrice;
@property(nonatomic,copy) NSString *OrderStoreName;
@property (nonatomic,copy)NSString *GoodCount;

@property (nonatomic,strong)TPFloatRatingView *ratingView;
@property (nonatomic,strong)UILabel *ratingLabel;
@end
