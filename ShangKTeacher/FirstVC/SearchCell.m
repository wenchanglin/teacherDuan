//
//  SearchCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SearchImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 80)];
    _SearchImage.image   = [UIImage imageNamed:@"图层-69@2x_15.png"];
    _SearchName       = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, kScreenWidth - 120, 15)];
    _SearchName.font  = [UIFont boldSystemFontOfSize:16];
    _SearchPrice      = [[UILabel alloc]initWithFrame:CGRectMake(105, 40, kScreenWidth - 120, 15)];
    _SearchPrice.font = [UIFont boldSystemFontOfSize:16];
    _SearchPrice.textColor = kAppRedColor;
    _SearchSellCount     = [[UILabel alloc]initWithFrame:CGRectMake(105, 70, 100, 15)];
    _SearchSellCount.font = [UIFont systemFontOfSize:15];
    _SearchAvgScore     = [[UILabel alloc]initWithFrame:CGRectMake(215, 70, 25, 15)];
    _SearchAvgScore.font = [UIFont systemFontOfSize:15];
    _SearchAvgScore.textAlignment = NSTextAlignmentCenter;
    _SearchAvgScore.textColor = kAppOrangeColor;
    _SearchFenshuLabel          = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_SearchAvgScore.frame)+1, 70, 15, 15)];
    _SearchFenshuLabel.text     = @"分";
    _SearchFenshuLabel.font     = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_SearchImage];
    [self.contentView addSubview:_SearchName];
    [self.contentView addSubview:_SearchSellCount];
    [self.contentView addSubview:_SearchAvgScore];
    [self.contentView addSubview:_SearchPrice];
    [self.contentView addSubview:_SearchFenshuLabel];
}

-(void)configWithModel:(SearchModel *)Model
{
    NSMutableAttributedString *AttStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@人已学习",Model.SearchSellCount]];
    [AttStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(0,1)];
    
//    NSMutableAttributedString *AttbuteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@分",Model.SearchAvgScore]];
//    [AttbuteStr addAttribute:NSForegroundColorAttributeName value:kAppOrangeColor range:NSMakeRange(0, 1)];
    _SearchSellCount.attributedText = AttStr;
    _SearchAvgScore.text = [NSString stringWithFormat:@"%@",Model.SearchAvgScore];
    _SearchName.text  = Model.SearchName;
}

@end
