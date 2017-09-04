//
//  StudentHomeWorkCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "StudentHomeWorkCell.h"

@implementation StudentHomeWorkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _StudentImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _StudentName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_StudentImage.frame)+10, 15, kScreenWidth - 120, 30)];
    _StudentName.font = [UIFont systemFontOfSize:16];
    _StudentFaBuZuoye = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_StudentImage.frame)+10, CGRectGetMaxY(_StudentName.frame)+20, kScreenWidth-120, 20)];
    _StudentFaBuZuoye.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_StudentFaBuZuoye];
    [self.contentView addSubview:_StudentName];
    [self.contentView addSubview:_StudentImage];
}

-(void)setWithModel:(StudentHomeWorkModel *)Model
{
    _StudentName.text = Model.StudentName;
    _StudentFaBuZuoye.text = [NSString stringWithFormat:@"已发布作业:%ld",(long)Model.submitCount];
    if ([Model.StudentPhotoList isKindOfClass:[NSNull class]]) {
        _StudentImage.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
     [_StudentImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.StudentPhotoList]] placeholderImage:nil];
    }
}
@end
