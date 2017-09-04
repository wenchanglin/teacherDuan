//
//  NSObject+PerformSelector.h
//  ShangKTeacher
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformSelector)
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

@end
