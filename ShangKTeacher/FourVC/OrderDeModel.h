//
//  OrderDeModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDeModel : NSObject
@property(nonatomic,copy) NSString *OrderDeStoreGoodBaseName;
@property(nonatomic,copy) NSString *OrderDeGoodAttrsValue;
@property(nonatomic,copy) NSString *OrderDeGoodCount;
@property(nonatomic,copy) NSString *OrderDeGoodSinglePrice;
@property(nonatomic,copy) NSString *OrderDePhotoCarouselList;

-(void)setDic:(NSDictionary *)dic;
@end
