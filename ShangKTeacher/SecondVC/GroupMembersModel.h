//
//  GroupMembersModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMembersModel : NSObject
@property(nonatomic,copy) NSString *GroupMembersName;
@property(nonatomic,copy) NSString *GroupMembersId;
@property(nonatomic,copy) NSString *GroupMembersIntro;
@property(nonatomic,assign) NSInteger GroupMembersSex;
@property(nonatomic,copy) NSString *GroupMembersUserPhotoHead;
//@property(nonatomic,assign) NSInteger  IsFriend;
@property(nonatomic,copy) NSString  *GroupMembersFkId;

-(void)setDic:(NSDictionary *)dic;
@end
