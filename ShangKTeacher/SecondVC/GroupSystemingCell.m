//
//  GroupSystemingCell.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "GroupSystemingCell.h"

@implementation GroupSystemingCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _QunFirstLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 20)];
    _QunFirstLabel.font = [UIFont boldSystemFontOfSize:16];
    
    [self.contentView addSubview:_QunFirstLabel];
}

@end
