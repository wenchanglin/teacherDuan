//
//  basicTextField.m
//  ShangKTeacher
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "basicTextField.h"

@implementation basicTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}

@end
