//
//  FriendDanChatModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendDanChatModel : NSObject
@property(nonatomic,copy) NSString *FriendDanChatUserPhotoHead;
@property(nonatomic,copy) NSString *FriendDanChatNickName;
@property(nonatomic,copy) NSString *FriendDanChatId;
@property(nonatomic,copy) NSString *FriendDanChatCreateTime;

-(void)setDic:(NSDictionary *)dic;
@end
