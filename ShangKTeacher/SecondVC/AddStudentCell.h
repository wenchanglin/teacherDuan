//
//  AddStudentCell.h
//  ShangKTeacher
//
//  Created by apple on 16/11/23.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddStudentModel.h"
@interface AddStudentCell : UITableViewCell
@property (nonatomic,strong)UIImageView *AddimageView;
@property (nonatomic,strong)UILabel *AddNameLabel;

-(void)configWithModel:(AddStudentModel *)Model;
@end
