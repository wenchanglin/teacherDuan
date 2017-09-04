//
//  PingJiaCell.m
//  ShangKTeacher
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "PingJiaCell.h"

@implementation PingJiaCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _PinaJPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    _PinaJPic.image = [UIImage imageNamed:@"图层-93@2x_57.png"];
    _PingJNickName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PinaJPic.frame)+10, 10, 100, 20)];
    _PingJNickName.font = [UIFont systemFontOfSize:16];
    _PingJScore  = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 15, 90, 20)];
    _PingJScore.font = [UIFont systemFontOfSize:16];
    _PingJContent = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PinaJPic.frame)+10, CGRectGetMaxY(_PinaJPic.frame)+5, kScreenWidth-50, 20)];
    _PingJContent.font = [UIFont systemFontOfSize:16];
    _PingJCreateTime = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, CGRectGetMaxY(_PingJScore.frame)+10, 160, 20)];
    _PingJCreateTime.font = [UIFont systemFontOfSize:16];
    
    [self.contentView addSubview:_PingJContent];
    [self.contentView addSubview:_PingJScore];
    [self.contentView addSubview:_PingJNickName];
    [self.contentView addSubview:_PinaJPic];
}

-(void)configWithModel:(PingJiaModel *)Model
{
    _PingJContent.text    = Model.PingJContent;
    _PingJContent.numberOfLines = 0;
    CGRect textFrame    = _PingJContent.frame;
    _PingJContent.frame  = CGRectMake(CGRectGetMaxX(_PinaJPic.frame)+10, CGRectGetMaxY(_PinaJPic.frame)+5, kScreenWidth-50, textFrame.size.height = [_PingJContent.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_PingJContent.font,NSFontAttributeName ,nil] context:nil].size.height);
    _PingJContent.frame  = CGRectMake(CGRectGetMaxX(_PinaJPic.frame)+10, CGRectGetMaxY(_PinaJPic.frame)+5, kScreenWidth-50, textFrame.size.height);
    _PingJCreateTime.text = [NSString stringWithFormat:@"%@",Model.PingJCreateTime];
    _PingJScore.text = [NSString stringWithFormat:@"评分:%@分",Model.PingJScore];
    _PingJNickName.text   = Model.PingJNickName;
    if ([Model.PingJUserPhotoHead isKindOfClass:[NSNull class]]) {
        _PinaJPic.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_PinaJPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.PingJUserPhotoHead]] placeholderImage:nil];
    }
}

@end
