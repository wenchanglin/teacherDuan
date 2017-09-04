//
//  FbwManager.h
//  ShangKTeacher
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FbwManager : NSObject
@property (nonatomic,assign)NSInteger   isBuy;
@property (nonatomic,copy) NSString    *UUserId;
@property (nonatomic,copy) NSString    *AddressTit;
@property (nonatomic,strong)NSData     *LuYinData;
@property (nonatomic,assign)NSInteger   IsListPulling;
@property (nonatomic,assign)NSInteger   PullPage;
@property (nonatomic,copy) NSString    *TeacherId;//管理员
@property (nonatomic,copy) NSString    *UserAddAdminId;//自主创建
@property (nonatomic,copy) NSString    *UserAddAdminName;//自主创建
@property (nonatomic,copy) NSString    *TeacherNAme;
@property(nonatomic,copy)  NSString    *GroupCreateUserId;

+(instancetype)shareManager;
@end
