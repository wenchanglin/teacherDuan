//
//  MyOrderVC.h
//  ShangKTeacher
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderVC : UIViewController
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,copy) NSString        *PayTit;
@property (nonatomic,strong)NSMutableArray *dataOneArray;
@property (nonatomic,strong)UITableView    *firstView;
@property (nonatomic,strong)NSMutableArray *dataFiveArray;
@property (nonatomic,strong)UITableView    *fiveView;
@end
