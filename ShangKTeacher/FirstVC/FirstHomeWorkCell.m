//
//  FirstHomeWorkCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FirstHomeWorkCell.h"

@implementation FirstHomeWorkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SecondContent = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, kScreenWidth-20, 30)];
    _SecondContent.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_SecondContent];
}

-(void)configWithModel:(FirstHomeWorkModel *)Model
{
//    CGRect rect = [Model.SecondContent boundingRectWithSize:CGSizeMake(kScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
//    _SecondContent.frame = CGRectMake(10, 100, kScreenWidth - 20, rect.size.height);
    _SecondContent.text = Model.SecondContent;
}

@end
