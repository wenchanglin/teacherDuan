//
//  NSString+StringHelper.m
//  ShangKTeacher
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "NSString+StringHelper.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (HCBStringHelper)

- (NSString *)md5
{
    const char *src = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, (int)strlen(src), result);
    NSString *ret = [[NSString alloc] initWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    return [ret lowercaseString];
}
@end
