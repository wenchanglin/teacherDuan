//
//  OrderDeCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDeModel.h"
@interface OrderDeCell : UITableViewCell
@property (nonatomic,strong)UIImageView *OrderDetailsImage;
@property (nonatomic,strong)UILabel     *OrderDetailsFaishonTitle;
@property (nonatomic,strong)UILabel     *OrderDetailsColorTitle;
@property (nonatomic,strong)UILabel     *OrderDetailsPriceTitle;
@property (nonatomic,strong)UILabel     *OrderDetailsBuyNumTitle;

-(void)configWithModel:(OrderDeModel *)Model;
@end
