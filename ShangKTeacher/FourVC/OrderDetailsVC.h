//
//  OrderDetailsVC.h
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsVC : UIViewController
@property(nonatomic,copy) NSString *OrderId;
@property(nonatomic,copy) NSString *IsHidden;
@property(nonatomic,copy) NSString *OrderGoodBaseName;
@property(nonatomic,copy) NSString *OrderGoodBasePhotoUrl;
@property(nonatomic,copy) NSString *OrderFkGoodBaseId;
@property(nonatomic,copy) NSString *OrderSinglePrice;
@property(nonatomic,copy) NSString *OrderSumPrice;
@property(nonatomic,copy) NSString *OrderStoreName;
@property(nonatomic,copy) NSString *OrderReceiveName;
@property(nonatomic,copy) NSString *OrderReceiveAddress;
@property(nonatomic,copy) NSString *OrderReceivePhone;
@property(nonatomic,copy) NSString *OrderReceiveTime;
@property (nonatomic,assign)NSInteger GoodCount;
@end
