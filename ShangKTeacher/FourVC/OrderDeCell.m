//
//  OrderDeCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "OrderDeCell.h"
@implementation OrderDeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _OrderDetailsImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _OrderDetailsImage.image = [UIImage imageNamed:@"图层-82@2x.png"];
    _OrderDetailsFaishonTitle      = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, kScreenWidth-110, 20)];
    _OrderDetailsFaishonTitle.font = [UIFont boldSystemFontOfSize:15];
    _OrderDetailsFaishonTitle.numberOfLines = 0;
    
    _OrderDetailsColorTitle         = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_OrderDetailsFaishonTitle.frame)+10, kScreenWidth-110, 20)];
    
    _OrderDetailsColorTitle.backgroundColor = kAppWhiteColor;
    
    _OrderDetailsPriceTitle                = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(_OrderDetailsColorTitle.frame)+10, 150, 20)];
    
    _OrderDetailsPriceTitle.textColor = kAppRedColor;
    _OrderDetailsPriceTitle.font           = [UIFont boldSystemFontOfSize:17];
    _OrderDetailsBuyNumTitle               = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-50, CGRectGetMaxY(_OrderDetailsColorTitle.frame)+10, 40, 20)];
    
    _OrderDetailsBuyNumTitle.textAlignment = NSTextAlignmentCenter;
    _OrderDetailsBuyNumTitle.backgroundColor = kAppWhiteColor;
    _OrderDetailsBuyNumTitle.font = [UIFont boldSystemFontOfSize:16];
    
    [self.contentView addSubview:_OrderDetailsBuyNumTitle];
    [self.contentView addSubview:_OrderDetailsPriceTitle];
    [self.contentView addSubview:_OrderDetailsColorTitle];
    [self.contentView addSubview:_OrderDetailsFaishonTitle];
    [self.contentView addSubview:_OrderDetailsImage];
    
}

-(void)configWithModel:(OrderDeModel *)Model
{
    _OrderDetailsFaishonTitle.text = Model.OrderDeStoreGoodBaseName;
    CGRect textFrame   = _OrderDetailsFaishonTitle.frame;
    if ([_OrderDetailsFaishonTitle isKindOfClass:[NSNull class]]) {
        
    }else{
    _OrderDetailsFaishonTitle.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height = [_OrderDetailsFaishonTitle.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_OrderDetailsFaishonTitle.font,NSFontAttributeName ,nil] context:nil].size.height);
    _OrderDetailsFaishonTitle.frame = CGRectMake(100, 10, kScreenWidth - 110, textFrame.size.height);
    }
    _OrderDetailsBuyNumTitle.text  = [NSString stringWithFormat:@"x%@",Model.OrderDeGoodCount];
    _OrderDetailsPriceTitle.text = [NSString stringWithFormat:@"¥:%@",Model.OrderDeGoodSinglePrice];
    _OrderDetailsColorTitle.text    =  Model.OrderDeGoodAttrsValue;
    NSLog(@"假的%@",_OrderDetailsBuyNumTitle.text);
}



@end
