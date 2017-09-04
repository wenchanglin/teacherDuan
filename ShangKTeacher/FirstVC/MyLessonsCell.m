//
//  MyLessonsCell.m
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "MyLessonsCell.h"
@implementation MyLessonsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _HeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    _lessonTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_HeadImage.frame)+10, 20, 150, 20)];
    _lessonTitle.font = [UIFont boldSystemFontOfSize:17];
//    _lessonTitle.text = @"小提琴基础课程";
    _lessonNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_HeadImage.frame)+10, CGRectGetMaxY(_lessonTitle.frame)+10, 200, 20)];
    _lessonNum.font = [UIFont systemFontOfSize:16];
//    _lessonNum.text = @"班级人数:16人";
    _lessonDate = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_HeadImage.frame)+10, CGRectGetMaxY(_lessonNum.frame)+10, 300, 20)];
    _lessonDate.font = [UIFont systemFontOfSize:16];
//    _lessonDate.text = @"开课时间:2016-7-6 12:35:57";
    
    
    [self.contentView addSubview:_HeadImage];
    [self.contentView addSubview:_lessonNum];
    [self.contentView addSubview:_lessonDate];
    [self.contentView addSubview:_lessonTitle];
}

-(void)configWithModel:(MyLessonsModel *)Model
{
    NSString * timeStampString = Model.MyLessonCreateTime;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"YYYY-MM-dd  hh:mm:ss"];
    NSString *time = [objDateformat stringFromDate: date];
    _lessonDate.text = [NSString stringWithFormat:@"%@",time];
    
    _lessonTitle.text = Model.MyLessonName;
    _lessonNum.text = [NSString stringWithFormat:@"班级人数:%@人",Model.MyLessonBuyCount];
    if ([Model.MyLessonPhotoList isKindOfClass:[NSNull class]]) {
        _HeadImage.image = [UIImage imageNamed:@"哭脸.png"];
    }else{
        [_HeadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.MyLessonPhotoList]] placeholderImage:nil];
    }
}









@end
