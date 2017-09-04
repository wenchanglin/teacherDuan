//
//  NextHomeWorkModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NextHomeWorkModel : NSObject
@property(nonatomic,copy)   NSString *SecondCentent;
@property(nonatomic,copy)   NSString *SecondCreateTime;
@property(nonatomic,copy)   NSString *SecondPhotoList;
@property(nonatomic,copy)   NSString *SecondId;

-(void)setDic:(NSDictionary *)dic;
@end
