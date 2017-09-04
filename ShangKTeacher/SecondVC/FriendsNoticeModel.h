//
//  FriendsNoticeModel.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsNoticeModel : NSObject
@property(nonatomic,copy) NSString *FriendsMessageContent;
@property(nonatomic,copy) NSString *FriendsMessageId;
@property(nonatomic,assign) NSInteger FriendsMessageStatus;
@property(nonatomic,copy) NSString *FriendsMessageCreateTime;

-(void)setDic:(NSDictionary *)dic;
@end
