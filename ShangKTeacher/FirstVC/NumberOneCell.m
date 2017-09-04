//
//  NumberOneCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "NumberOneCell.h"

@implementation NumberOneCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _NumBerContent = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 20)];
    _NumBerContent.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_NumBerContent];
}

-(void)configWithModel:(NumberOneModel *)Model
{
    CGRect rect = [Model.NumBerContent boundingRectWithSize:CGSizeMake(kScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    _NumBerContent.frame = CGRectMake(10, 20, kScreenWidth - 20, rect.size.height);
    _NumBerContent.text = Model.NumBerContent;
}


@end
