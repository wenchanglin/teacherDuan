//
//  MyLessonsCell.h
//  ShangKTeacher
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLessonsModel.h"
@interface MyLessonsCell : UITableViewCell
@property (nonatomic,strong)UIImageView *HeadImage;
@property (nonatomic,strong)UILabel     *lessonTitle;
@property (nonatomic,strong)UILabel     *lessonNum;
@property (nonatomic,strong)UILabel     *lessonDate;

-(void)configWithModel:(MyLessonsModel *)Model;
@end
