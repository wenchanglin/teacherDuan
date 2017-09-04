//
//  MyOrderModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject
@property(nonatomic,copy) NSString *MyOrderStoreName;
@property(nonatomic,copy) NSString *MyOrderStoreGoodBaseName;
@property(nonatomic,copy) NSString *MyOrderStoreGoodBasePhotoUrl;
@property(nonatomic,copy) NSString *MyOrderGoodSinglePrice;
@property(nonatomic,copy) NSString *MyOrderSumPrice;
@property(nonatomic,copy) NSString *MyOrderId;
@property(nonatomic,copy) NSString *MyOrderFkGoodBaseId;
@property(nonatomic,copy) NSString *MyOrderReceiveName;
@property(nonatomic,copy) NSString *MyOrderReceivePhone;
@property(nonatomic,copy) NSString *MyOrderReceiveAddress;
@property(nonatomic,copy) NSString *MyOrderCreateTime;
@property (nonatomic,copy)NSString *MyOrderGoodCount;
@property (nonatomic,strong)NSArray *ListArr;

-(void)setDic:(NSDictionary *)dic;
-(void)setDicGt:(NSDictionary *)dic;

@end
