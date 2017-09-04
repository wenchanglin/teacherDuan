//
//  SearchModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property(nonatomic,copy) NSString    *SearchName;
@property(nonatomic,copy) NSString    *SearchPrice;
@property(nonatomic,copy) NSString    *SearchAvgScore;
@property(nonatomic,copy) NSString    *SearchSellCount;
@property(nonatomic,copy) NSString    *SearchPhotoUrl;
@property(nonatomic,copy) NSString    *SearchId;

-(void)setDic:(NSDictionary *)dic;
@end
