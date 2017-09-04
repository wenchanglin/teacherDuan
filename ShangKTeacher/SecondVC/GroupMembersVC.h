//
//  GroupMembersVC.h
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupMembersVC : UIViewController
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView    *tableView;
@property(nonatomic,copy) NSString *NavTitle;
@property(nonatomic,copy) NSString *GroupId;
@end
