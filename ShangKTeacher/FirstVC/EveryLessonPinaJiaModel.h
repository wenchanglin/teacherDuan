//
//  EveryLessonPinaJiaModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryLessonPinaJiaModel : NSObject
@property(nonatomic,copy) NSString *LessonJContent;
@property(nonatomic,copy) NSString *LessonJScore;
@property(nonatomic,copy) NSString *LessonJUserPhotoHead;
@property(nonatomic,copy) NSString *LessonJNickName;
@property(nonatomic,copy) NSString *LessonJCreateTime;

-(void)setDic:(NSDictionary *)dic;
@end
