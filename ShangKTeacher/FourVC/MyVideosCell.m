//
//  MyVideosCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyVideosCell.h"

@implementation MyVideosCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _MyVideosPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
//    _MyVideosPhoto.image = [UIImage imageNamed:@"图层-56@2x_70.png"];
    _MyVideosName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_MyVideosPhoto.frame)+10, 15, kScreenWidth-90, 20)];
    _MyVideosName.font = [UIFont systemFontOfSize:16];
    _MyVideosTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_MyVideosPhoto.frame)+10, CGRectGetMaxY(_MyVideosName.frame)+30, kScreenWidth-90, 20)];
    _MyVideosTime.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_MyVideosName];
    [self.contentView addSubview:_MyVideosTime];
    [self.contentView addSubview:_MyVideosPhoto];
}

-(void)configWithModel:(MyVideosModel *)Model
{
    _MyVideosName.text = Model.MyVideosName;
    if ([Model.MyVideosPhotoUrl isKindOfClass:[NSNull class]]) {
        _MyVideosPhoto.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_MyVideosPhoto setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.MyVideosPhotoUrl]] placeholderImage:nil];
    }
}

@end
