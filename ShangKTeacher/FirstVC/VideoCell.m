//
//  VideoCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _TextPic         = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 80)];
//    _TextPic.image   = [UIImage imageNamed:@""];
    _TextLabel       = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, kScreenWidth - 120, 15)];
    _TextLabel.font  = [UIFont boldSystemFontOfSize:16];
    
    _priceLabel      = [[UILabel alloc]initWithFrame:CGRectMake(105, 40, kScreenWidth - 120, 15)];
    _priceLabel.font = [UIFont boldSystemFontOfSize:16];
    
    _priceLabel.textColor = kAppRedColor;
    _FreePeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 70, 20, 15)];
    _FreePeopleLabel.font = [UIFont systemFontOfSize:15];
    _peopleLabel      = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FreePeopleLabel.frame)+1, 70, 100, 15)];
    _peopleLabel.font = [UIFont systemFontOfSize:15];
    _peopleLabel.text = @"人已学习";
    _FreeFenshuLabel     = [[UILabel alloc]initWithFrame:CGRectMake(215, 70, 35, 15)];
    _FreeFenshuLabel.font = [UIFont systemFontOfSize:15];
    _FreeFenshuLabel.textAlignment = NSTextAlignmentCenter;
    _FreeFenshuLabel.textColor = kAppOrangeColor;
    _fenshuLabel          = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_FreeFenshuLabel.frame)+1, 70, 15, 15)];
    _fenshuLabel.text     = @"分";
    _fenshuLabel.font     = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_TextPic];
    [self.contentView addSubview:_TextLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_FreeFenshuLabel];
    [self.contentView addSubview:_fenshuLabel];
    [self.contentView addSubview:_FreePeopleLabel];
    [self.contentView addSubview:_peopleLabel];
}

-(void)configWithModel:(VideoClassModel *)Model
{
    _FreePeopleLabel.text = [NSString stringWithFormat:@"%@",Model.VideoSellCount];
    _FreePeopleLabel.textColor = kAppOrangeColor;
    _FreeFenshuLabel.text = [NSString stringWithFormat:@"%.2f",Model.VideoAvgScore];
    _TextLabel.text  = Model.VideoName;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",Model.Videoprice];
    
    if ([Model.VideoPhotoUrl isKindOfClass:[NSNull class]]) {
        _TextPic.image   = [UIImage imageNamed:@"图层-69@2x_15.png"];
    }else{
        [_TextPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.VideoPhotoUrl]] placeholderImage:nil];
    }
}


@end
