//
//  ChatEmojiView.h
//  joinup_iphone
//
//  Created by shen_gh on 15/7/29.
//  copyRight (c) 2015年 com.joinup(Beijing). All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChatEmojiViewIconType){
    ChatEmojiViewIconTypeCommon = 0,//经典表情
    ChatEmojiViewIconTypeOther //******************自定义表情:后期版本拓展**********
};

@class EmojiObj;

@protocol ChatEmojiViewDelegate <NSObject>

@required
- (void)chatEmojiViewSelectEmojiIcon:(NSString*)objIcon;//选择了某个表情
- (void)chatEmojiViewTouchUpinsideDeleteButton;//点击了删除表情

@optional
- (void)chatEmojiViewTouchUpinsideSendButton;//点击了发送表情

@end

#define ChatEmojiView_Hight    200.0f //表情View的高度
#define ChatEmojiView_Bottom_H 10.0f
#define ChatEmojiView_Bottom_W 52.0f

@interface ChatEmojiView : UIView

@property (nonatomic,assign) id<ChatEmojiViewDelegate>delegate;
@end
