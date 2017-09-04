//
//  EveryLessonPinaJiaCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryLessonPinaJiaModel.h"
@interface EveryLessonPinaJiaCell : UITableViewCell
@property (nonatomic,strong)UIImageView *PinaJPic;
@property (nonatomic,strong)UILabel *PingJContent;
@property (nonatomic,strong)UILabel *PingJNickName;
@property (nonatomic,strong)UILabel *PingJCreateTime;
@property (nonatomic,strong)UILabel *PingJScore;

-(void)configWithModel:(EveryLessonPinaJiaModel *)Model;
@end
