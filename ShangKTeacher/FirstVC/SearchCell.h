//
//  SearchCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface SearchCell : UITableViewCell
@property (nonatomic,strong)UIImageView *SearchImage;
@property (nonatomic,strong)UILabel     *SearchName;
@property (nonatomic,strong)UILabel     *SearchPrice;
@property (nonatomic,strong)UILabel     *SearchSellCount;
@property (nonatomic,strong)UILabel     *SearchFenshuLabel;
@property (nonatomic,strong)UILabel     *SearchAvgScore;

-(void)configWithModel:(SearchModel *)Model;@end
