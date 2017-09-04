//
//  MyOrderCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

@interface MyOrderCell : UITableViewCell
@property (nonatomic,strong)UIImageView *MiddleImage;
@property (nonatomic,strong)UIView      *BackView;
@property (nonatomic,strong)UILabel     *FaishonTitle;
@property (nonatomic,strong)UILabel     *ColorTitle;
@property (nonatomic,strong)UILabel     *PriceTitle;
@property (nonatomic,strong)UILabel     *BuyNumTitle;

-(void)configWithModel:(MyOrderModel *)Model;
@end
