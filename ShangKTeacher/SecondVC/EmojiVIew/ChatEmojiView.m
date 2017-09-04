//
//  ChatEmojiView.m
//  joinup_iphone
//
//  Created by shen_gh on 15/7/29.
//  copyRight (c) 2015年 com.joinup(Beijing). All rights reserved.
//

#import "ChatEmojiView.h"
#import "EmojiButton.h"
#import "EmojiObj.h"
#import "EmojiScrollView.h"
#import "CommentEmoji.h"
#import "IconButton.h"
#import "SMPageControl.h"//第三方pageControl

@interface ChatEmojiView()
<UIScrollViewDelegate>
{
    EmojiScrollView * scroll;
    IconButton * selectIcon;
}

@property (nonatomic,strong) SMPageControl * pageControl;
@property (nonatomic,copy) NSArray * iconS;
@end

@implementation ChatEmojiView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    CGRect _frame_ = CGRectMake(0, 0, kScreenWidth, ChatEmojiView_Hight);
    _frame_.origin = frame.origin;
    if (self = [super initWithFrame:_frame_]) {
        [self initUI];
        [self common:_iconS[0]];
        self.backgroundColor = kAppMainBgColor;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    if ((frame.size.height == ChatEmojiView_Hight) && (frame.size.width ==kScreenWidth)) {
        [super setFrame:frame];
    }
}

#pragma mark - 初始化界面
- (void)initUI{
    
    CGRect frame = self.bounds;
    frame.size.height -= ChatEmojiView_Bottom_H;
    [self addScroll:frame]; /*scroll*/
    
    frame.origin.y = CGRectGetHeight(frame) - 1.7*EmojiView_Border;
    frame.size.height = EmojiView_Border;
    [self addPageControl:frame]; /*pagecontrol*/
    
//    frame.origin.y = CGRectGetHeight(self.bounds) - ChatEmojiView_Bottom_H;
//    frame.size.height = ChatEmojiView_Bottom_H;
//    [self addBottom:frame];/*bottom*/
}

- (void)addScroll:(CGRect)frame{
    scroll = [[EmojiScrollView alloc]initWithFrame:frame];
    scroll.delegate = self;
    [self addSubview:scroll];
}

- (void)addPageControl:(CGRect)frame{
    self.pageControl = [[SMPageControl alloc]initWithFrame:frame];
    [self.pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
    [self.pageControl setPageIndicatorImage:[UIImage imageNamed:@"compose_keyboard_dot_normal"]];
    self.pageControl.userInteractionEnabled = YES;
    
    [self addSubview:self.pageControl];
}

- (void)addBottom:(CGRect)frame{
    UIView * bottom = [[UIView alloc]initWithFrame:frame];
    //common
    IconButton * common = [[IconButton alloc]initWithFrame:CGRectMake(0, 0, ChatEmojiView_Bottom_W, ChatEmojiView_Bottom_H)];
    [common setImage:[UIImage imageNamed:@"ic_emoji_blue"] forState:UIControlStateNormal];
    [common addTarget:self action:@selector(common:) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:common];
    //panda
//    IconButton * panda = [[IconButton alloc]initWithFrame:CGRectMake(ChatEmojiView_Bottom_W, 0, ChatEmojiView_Bottom_W, ChatEmojiView_Bottom_H)];
//    [panda setImage:[UIImage imageNamed:@"emo_1_smile"] forState:UIControlStateNormal];
//    [panda addTarget:self action:@selector(panda:) forControlEvents:UIControlEventTouchUpInside];
//    [bottom addSubview:panda];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bottom.bounds.size.width, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [bottom addSubview:line];
    
    self.iconS = @[common];
    [self addSubview:bottom];
    
    //send
    UIButton * sendB = [[UIButton alloc]init];
    [sendB setTitle:@"发送" forState:UIControlStateNormal];
    [sendB addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    frame = common.frame;
    frame.origin = CGPointMake(self.bounds.size.width - frame.size.width, 0);
    sendB.frame = frame;
    [sendB setBackgroundImage:[UIImage imageFormColor:kAppMainOrangeColor frame:sendB.bounds] forState:UIControlStateNormal];
    [bottom addSubview:sendB];
}

- (void)addEmojisWithType:(ChatEmojiViewIconType)type{
    switch (type) {
        case ChatEmojiViewIconTypeCommon:
            [self common:_iconS[type]];
            break;
        case ChatEmojiViewIconTypeOther:
           // [self panda:_iconS[type]];
            break;
        default:
            break;
    }
}

- (void)common:(IconButton*)sender{
    [self sender:sender];
    [self addEmjioWith:[CommentEmoji class]];
}

//-(void)panda:(IconButton*)sender{
//    [self sender:sender];
//    [self addEmjioWith:[PandaEmoji class]];
//}

- (void)sender:(IconButton*)sender{
    if (sender) {
        if(selectIcon) selectIcon.backgroundColor = [UIColor clearColor];
        selectIcon = sender;
        selectIcon.backgroundColor = kAppLineColor;
    }
}

- (void)addEmjioWith:(Class)class{
    [self scrollInit];
    NSInteger count_lins = [class countInOneLine];
    NSInteger page_support = [class pageCountIsSupport];
    CGFloat space = (kScreenWidth-EmojiView_Border*2.0f-count_lins*EmojiIMG_Width_Hight)/(count_lins-1);
    scroll.contentSize = CGSizeMake(page_support*kScreenWidth, 0);
    self.pageControl.numberOfPages = page_support;
    for (int i = 0; i < page_support; i++) {
        NSArray * array = [class emojiObjsWithPage:i];
        for (int j = 0; j < array.count - 1; j++) {
            NSInteger lins_w = j/count_lins;
            NSInteger list_w = j%count_lins;
            CGRect frame = CGRectMake(EmojiView_Border+list_w*(space+EmojiIMG_Width_Hight)+(i*kScreenWidth), EmojiView_Border+lins_w*(EmojiIMG_Space_UP+EmojiIMG_Width_Hight), EmojiIMG_Width_Hight, EmojiIMG_Width_Hight);
            EmojiButton * button = [[EmojiButton alloc]initWithFrame:frame];
           // button.emojiIcon = array[j];
            CommentEmoji * obj = array[j];

            [button setTitle:obj.emojiString forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(selectorThisIcon:) forControlEvents:UIControlEventTouchUpInside];
            [scroll addSubview:button];
            
            
//            UILongPressGestureRecognizer * loTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(loTaoAction:)];
//            [button addGestureRecognizer:loTap];
        }
        
        EmojiButton * del_B = [[EmojiButton alloc]initWithFrame:CGRectMake(EmojiView_Border+(count_lins-1)*(space+EmojiIMG_Width_Hight)+(i*kScreenWidth), EmojiView_Border+(EmojiIMG_Lines-1)*(EmojiIMG_Space_UP+EmojiIMG_Width_Hight), EmojiIMG_Width_Hight, EmojiIMG_Width_Hight)];
        del_B.emojiIcon = [array lastObject];
        
        [del_B addTarget:self action:@selector(deleteIcons) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:del_B];
    }
}

#pragma mark - other logic action
/*切换表情列表*/
- (void)scrollInit{
    for (UIView * v in scroll.subviews) {
        if ([v isKindOfClass:[EmojiButton class]]) {
            [v removeFromSuperview];
        }
    }
    [scroll setContentOffset:CGPointZero];
}
/*长按表情->动画*/
- (void)loTaoAction:(UILongPressGestureRecognizer*)loTap{
    
//    EmojiButton * objEB = (EmojiButton*)loTap.view;
//    switch (loTap.state) {
//        case UIGestureRecognizerStateBegan:
//            [self showEmotionName:objEB.emojiIcon.emojiName];
//            break;
//        case UIGestureRecognizerStateEnded:
//            [self selectorThisIcon:objEB];
//            break;
//        default:
//            break;
//    }
}

- (void)showEmotionName:(NSString *)name {
#define W 80.0f
#define H 40.0f
    CGFloat x = (self.superview.frame.size.width-80.0f)/2.0f;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, self.superview.frame.origin.y, W, H)];
    
    lab.text = name;
    lab.alpha = 0.1f;
    lab.layer.masksToBounds = YES;
    lab.layer.cornerRadius  = 10.0f;
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [UIColor grayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15.0f];
    
    [self.superview.superview addSubview:lab];
    [UIView animateWithDuration:0.4f animations:^{
        lab.frame = CGRectMake(x, -H, W, H);
        lab.alpha = 1.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.3f delay:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{
                lab.alpha = 0.0f;
            } completion:^(BOOL finished) {
                if (finished) [lab removeFromSuperview];
            }];
        }
    }];
}

#pragma mark - self delegate action
-(void)selectorThisIcon:(EmojiButton*)sender{
    
  //  NSLog(@"按钮%@",sender.titleLabel.text);
    if ([self.delegate respondsToSelector:@selector(chatEmojiViewSelectEmojiIcon:)]) {
        [self.delegate chatEmojiViewSelectEmojiIcon:sender.titleLabel.text];
    }
}

-(void)deleteIcons{
    if ([self.delegate respondsToSelector:@selector(chatEmojiViewTouchUpinsideDeleteButton)]) {
        [self.delegate chatEmojiViewTouchUpinsideDeleteButton];
    }
}

-(void)sendButtonAction{
    if ([self.delegate respondsToSelector:@selector(chatEmojiViewTouchUpinsideSendButton)]) {
        [self.delegate chatEmojiViewTouchUpinsideSendButton];
    }
}

#pragma mark - Scroll View Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage =(scrollView.contentOffset.x/scrollView.bounds.size.width)+0.5;
}



@end
