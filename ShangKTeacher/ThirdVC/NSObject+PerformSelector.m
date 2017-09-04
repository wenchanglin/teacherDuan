//
//  NSObject+PerformSelector.m
//  ShangKTeacher
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "NSObject+PerformSelector.h"

@implementation NSObject (PerformSelector)
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    
    NSMethodSignature *signature=[self.class instanceMethodSignatureForSelector:aSelector];
    
    //如果没有该方法
    if (!signature) {
        
        @throw [NSException exceptionWithName:@"没有该方法啊" reason:@"你确定有这个方法？" userInfo:nil];
        
        //[NSException raise:@"出落喽" format:@"方法找不到啊 %@",NSStringFromSelector(aSelector)];
    }
    
    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target=self;
    
    invocation.selector=aSelector;
    
    //处理参数传多了异常
    //for (int i=0; i<objects.count; i++) count得用我们方法名当中参数多个数，这样用户即使传多了，也不受影响
    
    //设置参数
    //获取方法多参数个数，注意其默认包含了self，_cmd  signature.numberOfArguments所以要－2
    
    //处理有一个活多个参数，但参数为空的问题
    NSInteger count= MIN(signature.numberOfArguments-2, objects.count);
    
    for (NSInteger i=0; i<count; i++) {
        
        id object=objects[i];
        
        [invocation setArgument:&object atIndex:2+i];
    }
    
    [invocation invoke];
    
    //获取返回值
    id returnValue=nil;
    
    if (signature.methodReturnLength) {
        
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
    
}

@end
