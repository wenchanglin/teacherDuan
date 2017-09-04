//
//  SystemMessageCell.h
//  ShangKTeacher
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessageModel.h"
@interface SystemMessageCell : UITableViewCell
@property(nonatomic,strong)UIImageView * SystemImgView;
@property(nonatomic,strong)UILabel * SystemTitle;
@property(nonatomic,strong)UILabel * SystemLage;
@property(nonatomic,strong)UILabel * SystemTime;

-(void)configWithModel:(SystemMessageModel *)Model;
@end
