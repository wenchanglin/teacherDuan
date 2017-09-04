//
//  SecondHomeWorkModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondHomeWorkModel : NSObject
@property(nonatomic,copy) NSString *ThirdContent;
@property(nonatomic,copy) NSString *ThirdCreateTime;
@property(nonatomic,assign) NSInteger ThirdType;
@property(nonatomic,copy) NSString *ThirdUserPhotoHead;
@property(nonatomic,copy) NSString *ThirdUserVoiceUrl;
@property(nonatomic,copy) NSString *ThirdNickName;
@property(nonatomic,copy) NSString *ThirdNickPic;

-(void)setWithDic:(NSDictionary *)dic;
-(void)setWithContent:(NSDictionary *)dic;
-(void)setWithVoiceUrl:(NSDictionary *)dic;
-(void)setWithName:(NSDictionary *)Dict;
-(void)setWithJiaNAme:(NSDictionary *)dic;
@end
