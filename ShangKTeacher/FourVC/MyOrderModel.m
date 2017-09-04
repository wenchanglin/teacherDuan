//
//  MyOrderModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic objectForKey:@"storeName"])       {
        [self setMyOrderStoreName:[dic objectForKey:@"storeName"]];
    }
    if ([dic objectForKey:@"id"])       {
        [self setMyOrderId:[dic objectForKey:@"id"]];
    }
    if ([dic objectForKey:@"sumPrice"])       {
        [self setMyOrderSumPrice:[dic objectForKey:@"sumPrice"]];
    }
    if ([dic objectForKey:@"createTime"])       {
        [self setMyOrderCreateTime:[dic objectForKey:@"createTime"]];
    }
    if ([dic objectForKey:@"receiveAddress"])       {
        [self setMyOrderReceiveAddress:[dic objectForKey:@"receiveAddress"]];
    }
    if ([dic objectForKey:@"receiveName"])       {
        [self setMyOrderReceiveName:[dic objectForKey:@"receiveName"]];
    }
    if ([dic objectForKey:@"receivePhone"])       {
        [self setMyOrderReceivePhone:[dic objectForKey:@"receivePhone"]];
    }
    if ([dic objectForKey:@"list"])       {
        [self setListArr:[dic objectForKey:@"list"]];
        
    }
}

-(void)setDicGt:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"storeGoodBaseName"] isKindOfClass:[NSNull class]])       {
        
    }else{
        [self setMyOrderStoreGoodBaseName:[dic objectForKey:@"storeGoodBaseName"]];
        NSLog(@"炸裂%@",[dic objectForKey:@"storeGoodBaseName"]);
    }
    //    if ([dic objectForKey:@"storeGoodBasePhotoUrl"])       {
    //        [self setMyOrderStoreGoodBasePhotoUrl:[dic objectForKey:@"storeGoodBasePhotoUrl"]];
    //    }
    if ([dic objectForKey:@"goodSinglePrice"])       {
        [self setMyOrderGoodSinglePrice:[dic objectForKey:@"goodSinglePrice"]];
    }
    if ([dic objectForKey:@"fkGoodBaseId"])       {
        [self setMyOrderFkGoodBaseId:[dic objectForKey:@"fkGoodBaseId"]];
    }
    if ([dic objectForKey:@"goodCount"])       {
        [self setMyOrderGoodCount:[dic objectForKey:@"goodCount"]];
    }
}
@end
