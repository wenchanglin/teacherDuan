//
//  EveryVideoModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryVideoModel : NSObject
@property(nonatomic,copy) NSString *EveryVideoIntro;
@property(nonatomic,copy) NSString *EveryVideoFitPeople;
@property(nonatomic,copy) NSString *EveryVideoOrgName;
@property(nonatomic,copy) NSString *EveryVideoOrgIntro;
@property(nonatomic,copy) NSString *EveryVideoTeacherName;
@property(nonatomic,copy) NSString *EveryVideoTeacherIntro;
@property(nonatomic,assign) NSInteger EveryVideoIsBuy;

-(void)setDic:(NSDictionary *)dic;
@end
