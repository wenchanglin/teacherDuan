//
//  AddStudentModel.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddStudentModel.h"

@implementation AddStudentModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setDic:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSNull class]]) {
        
    }else{
    if ([dic objectForKey:@"userPhotoHead"]) {
        [self setAddStudentPic:[dic objectForKey:@"userPhotoHead"]];
    }
    if ([dic objectForKey:@"nickName"]) {
        [self setAddStudentName:[dic objectForKey:@"nickName"]];
    }
    if ([dic objectForKey:@"id"]) {
        [self setAddStudentId:[dic objectForKey:@"id"]];
    }
    }
}
@end
