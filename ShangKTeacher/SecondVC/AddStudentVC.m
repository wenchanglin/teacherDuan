//
//  AddStudentVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "AddStudentVC.h"
#import "AddStudentModel.h"
#import "AddStudentCell.h"
@interface AddStudentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation AddStudentVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createNav];
    [self createData];
    [self createTableView];
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createData
{
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.GroupID}  url:UrL_AddStudentOther success:^(id responseObject) {
        NSLog(@"Look%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *dict in Arr) {
            AddStudentModel *Model = [[AddStudentModel alloc]init];
            [Model setDic:dict];
            [_dataArray addObject:Model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddChat"];
    if (!cell) {
        
        cell = [[AddStudentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddChat"];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIButton *AddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            AddBtn.layer.borderColor = kAppLineColor.CGColor;
            AddBtn.layer.borderWidth = 1;
            AddBtn.tag = indexPath.section;
            [AddBtn setTitle:@"添加" forState:UIControlStateNormal];
            AddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [AddBtn addTarget:self action:@selector(AddStuBtn:) forControlEvents:UIControlEventTouchUpInside];
            [AddBtn setTitleColor:kAppBlackColor forState:UIControlStateNormal];
            AddBtn.frame = CGRectMake(kScreenWidth - 90, 30, 80, 20);
            [cell.contentView addSubview:AddBtn];
        });
    }
    AddStudentModel *Model = _dataArray[indexPath.section];
    [cell configWithModel:Model];
    return cell;
}

-(void)AddStuBtn:(UIButton *)Adt
{
    AddStudentModel *Model = _dataArray[Adt.tag];
    __weak typeof(self) weakSelf = self;
    NSArray *arr = @[@{@"id":Model.AddStudentId}];
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.GroupID,@"userIdListStr":jsonStr} url:UrL_AddStudent success:^(id responseObject) {
        NSLog(@"%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
    }];
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 10, 100, 30)];
    label.text = @"未加入学员";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCklick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)BaCklick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
