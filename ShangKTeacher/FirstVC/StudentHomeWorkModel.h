//
//  StudentHomeWorkModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentHomeWorkModel : NSObject
@property(nonatomic,copy) NSString *StudentPhotoList;
@property(nonatomic,copy) NSString *StudentName;
@property(nonatomic,copy) NSString *StudentId;
@property (nonatomic,assign) NSInteger submitCount;

-(void)setDic:(NSDictionary *)dic;
-(void)setDict:(NSDictionary *)Dict;
@end
