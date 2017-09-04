//
//  FinancialDetailsCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinancialDetailsModel.h"

@interface FinancialDetailsCell : UITableViewCell
@property (nonatomic,strong)UILabel *FinancialType;
@property (nonatomic,strong)UILabel *FinancialTime;
@property (nonatomic,strong)UILabel *FinancialMoney;

-(void)configWith:(FinancialDetailsModel *)Model;
@end
