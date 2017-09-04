//
//  OrderDeModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrderDeModel.h"

@implementation OrderDeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"storeGoodBaseName"] isKindOfClass:[NSNull class]])       {

    }else{
        [self setOrderDeStoreGoodBaseName:[dic objectForKey:@"storeGoodBaseName"]];
    }
    if ([dic objectForKey:@"goodCount"])       {
        [self setOrderDeGoodCount:[dic objectForKey:@"goodCount"]];
    }
    if ([dic objectForKey:@"goodSinglePrice"])       {
        [self setOrderDeGoodSinglePrice:[dic objectForKey:@"goodSinglePrice"]];
    }
    if ([dic objectForKey:@"goodAttrsValue"])       {
        [self setOrderDeGoodAttrsValue:[dic objectForKey:@"goodAttrsValue"]];
    }
    //    if ([dic objectForKey:@"photoCarouselList"])       {
    //        [self setOrderDePhotoCarouselList:[dic objectForKey:@"photoCarouselList"]];
    //    }
}
@end
