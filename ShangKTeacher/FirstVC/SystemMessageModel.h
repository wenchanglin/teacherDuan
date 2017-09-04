//
//  SystemMessageModel.h
//  ShangKTeacher
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageModel : NSObject
@property(nonatomic,copy) NSString *SystemContent;
@property(nonatomic,copy) NSString *SystemTime;

-(void)setDic:(NSDictionary *)dic;
@end
