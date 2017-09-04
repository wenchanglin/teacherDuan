//
//  OrderThirdDetailCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrderThirdDetailCell.h"
@implementation OrderThirdDetailCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _ThirdBiaoTLabel       = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    _ThirdBiaoTLabel.text  = @"买家留言";
    _ThirdBiaoTLabel.textAlignment = NSTextAlignmentCenter;
    _ThirdBiaoTLabel.font  = [UIFont boldSystemFontOfSize:15];
    _ThirdLiuYBtn          = [UIButton buttonWithType:UIButtonTypeCustom];
    _ThirdLiuYBtn.frame = CGRectMake(10, CGRectGetMaxY(_ThirdBiaoTLabel.frame)+10, kScreenWidth-20, 80);
    _ThirdLiuYBtn.layer.borderWidth = 1;
    _ThirdLiuYBtn.layer.borderColor = kAppLineColor.CGColor;
    _ThirdLiuYLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetMaxX(_ThirdLiuYBtn.frame)-30, 20)];
    _ThirdLiuYLabel.numberOfLines = 0;
    _ThirdLiuYLabel.text = @"贵重物品请包装仔细点,贵重物品请包装仔细点,贵重物品请包装仔细点,贵重物品请包装仔细点,贵重物品请包装仔细点";
    CGRect textFrame   = _ThirdLiuYLabel.frame;
    _ThirdLiuYLabel.frame = CGRectMake(10, 10, CGRectGetMaxX(_ThirdLiuYBtn.frame)-30, textFrame.size.height = [_ThirdLiuYLabel.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_ThirdLiuYLabel.font,NSFontAttributeName ,nil] context:nil].size.height);
    _ThirdLiuYLabel.frame = CGRectMake(10, 10, CGRectGetMaxX(_ThirdLiuYBtn.frame)-30, textFrame.size.height);
    
    [_ThirdLiuYBtn    addSubview:_ThirdLiuYLabel];
    [self.contentView addSubview:_ThirdBiaoTLabel];
    [self.contentView addSubview:_ThirdLiuYBtn];
    
}

@end
