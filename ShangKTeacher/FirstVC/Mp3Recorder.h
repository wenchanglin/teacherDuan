//
//  Mp3Recorder.h
//  ShangKTeacher
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Mp3RecorderDelegate <NSObject>
- (void)failRecord;
- (void)beginConvert;
- (void)endConvertWithData:(NSString *)voiceData;
- (void)endConvertWithMp3Data:(NSData *)voiceData;

@end

@interface Mp3Recorder : NSObject
@property (nonatomic, weak) id<Mp3RecorderDelegate> delegate;

- (id)initWithDelegate:(id<Mp3RecorderDelegate>)delegate;
- (void)startRecord;
- (void)stopRecord;
- (void)cancelRecord;

@end
