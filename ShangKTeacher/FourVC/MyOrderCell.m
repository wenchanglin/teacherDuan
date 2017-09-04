//
//  MyOrderCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyOrderCell.h"
@implementation MyOrderCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _BackView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 100)];
    _BackView.backgroundColor = KAppBackBgColor;//
    _MiddleImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 90)];
    _MiddleImage.image = [UIImage imageNamed:@"图层-82@2x.png"];
    _FaishonTitle      = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, kScreenWidth-110, 20)];
    _FaishonTitle.font = [UIFont boldSystemFontOfSize:15];
    _FaishonTitle.numberOfLines = 0;
    
    _ColorTitle         = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_FaishonTitle.frame)+10, kScreenWidth-110, 20)];
    
    _PriceTitle                = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_ColorTitle.frame)+15, 100, 20)];
    _PriceTitle.textColor      = kAppRedColor;
    _PriceTitle.font           = [UIFont boldSystemFontOfSize:17];
    _BuyNumTitle               = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-50, CGRectGetMaxY(_ColorTitle.frame)+10, 40, 20)];
    _BuyNumTitle.textAlignment = NSTextAlignmentCenter;
    _BuyNumTitle.font = [UIFont boldSystemFontOfSize:16];
    
    [_BackView addSubview:_BuyNumTitle];
    [_BackView addSubview:_PriceTitle];
    [_BackView addSubview:_ColorTitle];
    [_BackView addSubview:_FaishonTitle];
    [_BackView addSubview:_MiddleImage];
    [self.contentView addSubview:_BackView];
}

-(void)configWithModel:(MyOrderModel *)Model
{
    _PriceTitle.text   = [NSString stringWithFormat:@"¥%@",Model.MyOrderGoodSinglePrice];
    _BuyNumTitle.text  = [NSString stringWithFormat:@"x%@",Model.MyOrderGoodCount];
    _FaishonTitle.text = Model.MyOrderStoreGoodBaseName;
    _ColorTitle.text   = @"颜色分类:深灰";
    if ([_FaishonTitle  isKindOfClass:[NSNull class]]) {
        CGRect textFrame   = _FaishonTitle.frame;
        _FaishonTitle.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height = [_FaishonTitle.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_FaishonTitle.font,NSFontAttributeName ,nil] context:nil].size.height);
        _FaishonTitle.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height);
    }else{
        
    }
    
}
@end
