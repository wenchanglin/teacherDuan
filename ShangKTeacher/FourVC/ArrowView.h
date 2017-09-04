//
//  ArrowView.h
//  ShangKTeacher
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrowView : UIControl
typedef void(^clickButton)(UIButton *button);

@property(nonatomic,assign)NSInteger style;
@property(nonatomic,strong)clickButton selectBlock;

- (id)initWithFrame:(CGRect)frame;
- (void)hidArrowView:(BOOL)animated;
- (void)showArrowView:(BOOL)animated;
//- (void)dismissArrowView:(BOOL)animated;

- (void)addUIButtonWithTitle:(NSArray *)title WithText:(NSString *)Text;
@end
