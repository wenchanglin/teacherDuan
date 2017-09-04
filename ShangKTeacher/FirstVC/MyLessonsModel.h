//
//  MyLessonsModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLessonsModel : NSObject
@property(nonatomic,copy) NSString *MyLessonName;
@property(nonatomic,copy) NSString *MyLessonAvgScore;
@property(nonatomic,copy) NSString *MyLessonCreateTime;
@property(nonatomic,copy) NSString *MyLessonBuyCount;
@property(nonatomic,copy) NSString *MyLessonSubmitCount;
@property(nonatomic,copy) NSString *MyLessonPhotoList;
@property(nonatomic,copy) NSString *MyLessonId;
@property(nonatomic,copy) NSString *MyLessonPrice;
@property(nonatomic,copy) NSString *MyLessonBriefIntro;
@property(nonatomic,copy) NSString *MyLessonFitPeople;
-(void)setDic:(NSDictionary *)dic;
-(void)setDict:(NSDictionary *)Dict;
@end
