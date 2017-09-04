//
//  ArrowView.m
//  ShangKTeacher
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "ArrowView.h"


//圆角度数
#define radius 0.0

#define Arror_Right 60

//填充色
#define backgroundColor [UIColor whiteColor]

//动画时间
#define DurationTime 0.5
@implementation ArrowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = 1;
    }
    return self;
}
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    
    maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, midx, maxy);
    CGContextAddLineToPoint(context,midx, maxy);
    CGContextAddLineToPoint(context,midx, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

- (void)getDrawPath_ArrowRight:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    
    CGFloat minx = CGRectGetMinX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect);
    
    
    CGContextMoveToPoint(context, maxx, Arror_Right);
    CGContextAddLineToPoint(context,maxx, Arror_Right);
    CGContextAddLineToPoint(context,maxx,Arror_Right);
    
    CGContextAddArcToPoint(context, maxx, miny, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, minx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, maxx, maxy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, maxx, Arror_Right, radius);
    CGContextClosePath(context);
    
}

-(void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    switch (self.style) {
            
        case 1:
            [self getDrawPath_ArrowRight:context];
            break;
            
        default:
            break;
    }
    CGContextFillPath(context);
}

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    //设置阴影颜色，透明度，偏移量
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}
- (void)hidArrowView:(BOOL)animated
{
    if (animated) {
        //开始动画
        [UIView beginAnimations:nil context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:DurationTime];
        //动画的内容
        [self setAlpha:0.0];
        //动画结束
        [UIView commitAnimations];
    }
    else
    {
        [self setAlpha:0.0];
    }
}
- (void)showArrowView:(BOOL)animated
{
    if (animated) {
        //开始动画
        [UIView beginAnimations:@"show" context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:DurationTime];
        //动画的内容
        [self setAlpha:1.0];
        //动画结束
        [UIView commitAnimations];
    }
    else
    {
        [self setAlpha:1.0];
    }
    
}
//- (void)dismissArrowView:(BOOL)animated
//{
//    if (animated) {
//            //开始动画
//        [UIView beginAnimations:nil context:nil];
//            //设定动画持续时间
//        [UIView setAnimationDuration:DurationTime];
//            //动画的内容
//        [self removeFromSuperview];
//            //动画结束
//        [UIView commitAnimations];
//    }
//    else
//    {
//        [self removeFromSuperview];
//    }
//}
- (void)addUIButtonWithTitle:(NSArray *)title WithText:(NSString *)Text
{
    for (NSInteger i=0; i<title.count; i++) {
        NSLog(@"--%@",title[i]);
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake((kScreenWidth-160-80)/2+i*60+i*80, kScreenHeight/2.9-55, 80, 40)];
        [button setBackgroundColor:kAppClearColor];
        [button setTitle:[title objectAtIndex:i] forState:UIControlStateNormal];
        [button setTag:i];
        button.layer.borderColor = kAppLineColor.CGColor;
        button.layer.borderWidth = 1;
        button.tag = 10+i;
        [button setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kAppWhiteColor forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-220)/2, kScreenHeight/2.9-155, 200, 30)];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.font = [UIFont boldSystemFontOfSize:16];
    TitleLabel.text = Text;
    [self addSubview:TitleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 20, 20, 20)];
    imageView.image = [UIImage imageNamed:@"提示-(1)@2x.png"];
    [self addSubview:imageView];
}

-(void)clickButton:(UIButton *)ArrowBtn
{
    self.selectBlock(ArrowBtn);
    [self hidArrowView:YES];
}

@end
