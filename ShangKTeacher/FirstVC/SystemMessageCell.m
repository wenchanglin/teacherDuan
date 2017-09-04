//
//  SystemMessageCell.m
//  ShangKTeacher
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import "SystemMessageCell.h"

@implementation SystemMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _SystemImgView   = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _SystemImgView.image   = [UIImage imageNamed:@"系统消息@2x_46.png"];
    _SystemTitle       = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, kScreenWidth - 100, 20)];
    _SystemTitle.text  = @"系统消息";
    _SystemTitle.font  = [UIFont boldSystemFontOfSize:18];
    _SystemLage = [[UILabel alloc]initWithFrame:CGRectMake(50, 35, kScreenWidth - 60, 15)];
    _SystemLage.lineBreakMode = NSLineBreakByWordWrapping;
    _SystemLage.numberOfLines = 0;
    
    
    
    _SystemTime = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 170, 95, 160, 20)];
    
    _SystemTime.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_SystemLage];
    [self.contentView addSubview:_SystemTime];
    [self.contentView addSubview:_SystemTitle];
    [self.contentView addSubview:_SystemImgView];
}

-(void)configWithModel:(SystemMessageModel *)Model
{
    NSString * timeStampString = Model.SystemTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _SystemTime.text = [NSString stringWithFormat:@"%@",time];
    
    _SystemLage.text = Model.SystemContent;
    CGRect textFrame = _SystemLage.frame;
    _SystemLage.frame = CGRectMake(50, 35, kScreenWidth - 90, textFrame.size.height = [_SystemLage.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:_SystemLage.font,NSFontAttributeName ,nil] context:nil].size.height);
    _SystemLage.frame = CGRectMake(50, 35, [UIScreen mainScreen].bounds.size.width - 90, textFrame.size.height);
}

@end
