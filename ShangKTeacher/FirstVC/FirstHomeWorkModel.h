//
//  FirstHomeWorkModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstHomeWorkModel : NSObject
@property(nonatomic,copy) NSString *SecondContent;
@property(nonatomic,copy) NSString *SecondPhotoList;
@property(nonatomic,copy) NSString *SecondVideoUrl;
@property (nonatomic,strong)NSMutableArray *SECPhotoList;
@property (nonatomic,strong)NSMutableArray *PicArr;

-(void)setWithDic:(NSDictionary *)dic;
-(void)setWithdic:(NSDictionary *)Dic;
-(void)setWithDict:(NSDictionary *)Dict;
-(void)setWithDit:(NSDictionary *)Dit;
@end
