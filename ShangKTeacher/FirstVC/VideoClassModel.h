//
//  VideoClassModel.h
//  ShangKTeacher
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoClassModel : NSObject
@property(nonatomic,copy) NSString    *VideoName;
@property(nonatomic,copy) NSString    *Videoprice;
@property(nonatomic,assign) double    VideoAvgScore;
@property(nonatomic,copy) NSString    *VideoSellCount;
@property(nonatomic,copy) NSString    *VideoPhotoUrl;
@property(nonatomic,copy) NSString    *VideoId;
@property(nonatomic,copy) NSString    *VideoUrl;

-(void)setDic:(NSDictionary *)dic;
@end
