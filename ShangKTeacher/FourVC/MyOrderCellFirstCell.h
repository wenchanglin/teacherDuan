//
//  MyOrderCellFirstCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"
@interface MyOrderCellFirstCell : UITableViewCell
@property (nonatomic,strong)UIImageView *TopImage;
@property (nonatomic,strong)UILabel     *DaiFuTitle;
@property (nonatomic,strong)UILabel     *HanGuoTitle;

-(void)configWithModel:(MyOrderModel *)Model;
@end
