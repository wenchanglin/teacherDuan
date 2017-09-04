//
//  HomeWorkListModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeWorkListModel : NSObject
@property(nonatomic,copy)   NSString *WorkListCentent;
@property(nonatomic,copy)   NSString *WorkListCreateTime;
@property(nonatomic,copy)   NSString *WorkListPhotoList;
@property(nonatomic,copy)   NSString *WorkListId;
@property(nonatomic,copy)   NSString *WorkListNickName;
@property(nonatomic,copy)   NSString *WorkListUserPhotoHead;

-(void)setDic:(NSDictionary *)dic;
-(void)setWithDic:(NSDictionary *)Dict;
-(void)setWtithDict:(NSDictionary *)Dic;
@end
