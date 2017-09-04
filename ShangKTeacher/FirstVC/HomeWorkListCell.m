//
//  HomeWorkListCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "HomeWorkListCell.h"

@implementation HomeWorkListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _WorkListImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _WorkListImage.layer.cornerRadius = 40;
    _WorkListImage.layer.masksToBounds = YES;
    _WorkListCentent = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_WorkListImage.frame)+10, 15, kScreenWidth - 120, 30)];
    _WorkListCentent.font = [UIFont systemFontOfSize:16];
    _WorkListCreateTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_WorkListImage.frame)+10, CGRectGetMaxY(_WorkListCentent.frame)+15, kScreenWidth - 120, 20)];
    _WorkListCreateTime.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_WorkListCreateTime];
    [self.contentView addSubview:_WorkListCentent];
    [self.contentView addSubview:_WorkListImage];
}

-(void)setWithModel:(HomeWorkListModel *)Model
{
    NSString * timeStampString = Model.WorkListCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _WorkListCreateTime.text = [NSString stringWithFormat:@"%@",time];
   
    _WorkListCentent.text = Model.WorkListCentent;
    if ([Model.WorkListPhotoList isEqualToString:@""]) {
        _WorkListImage.image = [UIImage imageNamed:@"图层-59@2x.png"];
    }else{
        [_WorkListImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.WorkListPhotoList]] placeholderImage:nil];
    }
}
@end
