//
//  AddStudentCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddStudentCell.h"

@implementation AddStudentCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _AddimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    
    _AddNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_AddimageView.frame)+10, 30, 100, 20)];
    _AddNameLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_AddNameLabel];
    [self.contentView addSubview:_AddimageView];
}

-(void)configWithModel:(AddStudentModel *)Model
{
    if ([Model.AddStudentPic isKindOfClass:[NSNull class]]) {
        _AddimageView.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_AddimageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.AddStudentPic]] placeholderImage:nil];
    }
    
    _AddNameLabel.text  = Model.AddStudentName;
}
@end
