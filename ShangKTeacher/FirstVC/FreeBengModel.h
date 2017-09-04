//
//  FreeBengModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeBengModel : NSObject
@property(nonatomic,copy) NSString    *FreeCourseName;
@property(nonatomic,copy) NSString    *FreeCourseprice;
@property(nonatomic,assign) double     FreeCourseAvgScore;
@property(nonatomic,copy) NSString    *FreeCourseSellCount;
@property(nonatomic,copy) NSString    *FreeCoursePhotoUrl;
@property(nonatomic,copy) NSString    *FreeCourseId;

-(void)setDic:(NSDictionary *)dic;
@end
