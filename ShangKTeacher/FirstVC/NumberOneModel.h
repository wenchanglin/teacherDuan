//
//  NumberOneModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberOneModel : NSObject
@property(nonatomic,copy) NSString *NumBerContent;
@property(nonatomic,copy) NSString *NumBerPhotoLoaction;
@property(nonatomic,copy) NSString *NumBerVideoUrl;
@property (nonatomic,strong)NSMutableArray *NumBerPhotoList;
@property (nonatomic,strong)NSMutableArray *PicArr;

-(void)setWithDic:(NSDictionary *)dic;
-(void)setWithdic:(NSDictionary *)Dic;
-(void)setWithDict:(NSDictionary *)Dict;
-(void)setWithDit:(NSDictionary *)Dit;
@end
