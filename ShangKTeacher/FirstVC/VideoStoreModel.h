//
//  VideoStoreModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoStoreModel : NSObject
@property(nonatomic,copy) NSString *VideoStoreName;
@property(nonatomic,copy) NSString *VideoStoreIntro;
@property(nonatomic,copy) NSString *VideoStorePhoto;
@property(nonatomic,copy) NSString *VideoStoreId;
@property(nonatomic,copy) NSString *VideoStoreScore;
@property(nonatomic,copy) NSString *VideoStoreCourseCount;

-(void)setDic:(NSDictionary *)dic;
@end
