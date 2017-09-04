//
//  MyVideosCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyVideosModel.h"
@interface MyVideosCell : UITableViewCell
@property (nonatomic,strong)UILabel *MyVideosName;
@property (nonatomic,strong)UILabel *MyVideosTime;
@property (nonatomic,strong)UILabel *MyVideosPrice;
@property (nonatomic,strong)UIButton *MyVideosBTn;
@property (nonatomic,strong)UIButton *PingJiaBtn;
@property (nonatomic,strong)UIImageView *MyVideosPhoto;

-(void)configWithModel:(MyVideosModel *)Model;
@end
