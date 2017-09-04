//
//  GroupMembersVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "GroupMembersVC.h"
#import "GroupMembersCell.h"
#import "GroupMembersSecondCell.h"
#import "FbwManager.h"
#import "GroupMembersModel.h"
#import "GroupMembersMCell.h"
#import "FriendUserInfoVC.h"
#import "GroupSystemingVC.h"
#import "AddStudentVC.h"
#import "ArrowView.h"
#import "SetAdministratorVC.h"
@interface GroupMembersVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString    * GroupIntro;
    NSString    * GroupNAme;
    NSString    * GroupTId;
    NSString    * OrgUserNAme;
    NSString    * chatGroupPhotoUrl;
    NSInteger     OrgSex;
    NSString    * OrgId;
    NSString    * AdminId;
    NSString    * userPhotoHead;
    NSMutableArray *GirlArray;
    NSMutableArray *BoyArray;
    NSMutableArray *OrgArray;
    ArrowView   *_arrowView;
    UIView      * PushView;
//    NSString    * GroupCreateUserId;
}
@end

@implementation GroupMembersVC
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [PushView removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    GirlArray = [NSMutableArray array];
    OrgArray = [NSMutableArray array];
    BoyArray = [NSMutableArray array];
    [self createData];
    [self createManger];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    
    self.view.backgroundColor = kAppWhiteColor;
}

-(void)createManger
{
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.GroupId} url:UrL_GroupsOfGroup success:^(id responseObject) {
        NSLog(@"huhu%@",responseObject);
        [_dataArray removeAllObjects];
        [GirlArray removeAllObjects];
        [BoyArray removeAllObjects];
        [OrgArray removeAllObjects];
        NSDictionary *RootDic = [responseObject objectForKey:@"data"];
        NSArray *Arr = [RootDic objectForKey:@"iData"];
        for (NSDictionary *Dict in Arr) {
            AdminId = [Dict objectForKey:@"id"];
            if ([[Dict objectForKey:@"roleInGroup"]isEqualToString:@"administrators"]) {
                if ([[Dict objectForKey:@"userInfoBase"]isKindOfClass:[NSNull class]]) {
                    
                }else{
                    OrgUserNAme   = Dict[@"userInfoBase"][@"nickName"];
                    OrgId         = Dict[@"userInfoBase"][@"id"];
                    OrgSex        = [Dict[@"userInfoBase"][@"sex"]integerValue];
                    userPhotoHead = Dict[@"userInfoBase"][@"userPhotoHead"];
                    if ([Dict[@"userInfoBase"][@"sex"] isKindOfClass:[NSNull class]]) {
                        OrgSex = 2;
                    }else{
                        OrgSex  = [Dict[@"userInfoBase"][@"sex"]integerValue];
                    }
                    if (OrgSex == 0) {
                        NSString *Str = @"Ge";
                        [GirlArray addObject:Str];
                    }else if (OrgSex == 1){
                        NSString *Str = @"Ge";
                        [BoyArray addObject:Str];
                    }else{
                        NSString *Str = @"Ge";
                        [OrgArray addObject:Str];
                    }
                }
                
            }else{
                NSLog(@"鸡皮胡%@",Dict);
                if ([[Dict objectForKey:@"userInfoBase"]isKindOfClass:[NSNull class]]) {
                    
                }else{
                    GroupMembersModel *Model = [[GroupMembersModel alloc]init];
                    [Model setDic:Dict];
                    if (Model.GroupMembersSex == 0) {
                        NSString *Str = @"Ge";
                        [GirlArray addObject:Str];
                    }else if (Model.GroupMembersSex == 1){
                        NSString *Str = @"Ge";
                        [BoyArray addObject:Str];
                    }else{
                        NSString *Str = @"Ge";
                        [OrgArray addObject:Str];
                    }
                    NSLog(@"女生数量%ld",GirlArray.count);
                    NSLog(@"男生数量%ld",BoyArray.count);
                    NSLog(@"机构数量%ld",OrgArray.count);
                    [_dataArray addObject:Model];
                }
                
            }
            NSLog(@"%ld",(unsigned long)_dataArray.count);
            [_tableView reloadData];
            [weakSelf createTableView];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)createData
{
    __weak typeof(self) weakSelf = self;
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":self.GroupId} url:UrL_GroupsInfo success:^(id responseObject) {
//        NSLog(@"-==-%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *RootDic =[responseObject objectForKey:@"data"];
        GroupNAme     = [RootDic objectForKey:@"name"];
        GroupIntro    = [RootDic objectForKey:@"intro"];
        GroupTId       = [RootDic objectForKey:@"id"];
        chatGroupPhotoUrl = [RootDic objectForKey:@"chatGroupPhotoUrl"];
        if ([[RootDic objectForKey:@"createUserId"] isEqualToString:Manager.UUserId]) {
            Manager.GroupCreateUserId = @"TeacherChuangJian";
            NSLog(@"这是教师自己创建的群啊！！！");
        }else{
            Manager.GroupCreateUserId = @"OrgChuangJian";
            NSLog(@"这是机构爸爸创建的群啊！！！");
        }
        [weakSelf createNav];
        [weakSelf createTableView];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
    }else if (indexPath.section == 1){
        return 150;
    }
     return _dataArray.count/3*130+230;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        GroupSystemingVC *System =[[GroupSystemingVC alloc]init];
        System.QunName = GroupNAme;
        System.QunIntro = GroupIntro;
        System.QunId = GroupTId;
        System.QunPhotoHead = chatGroupPhotoUrl;
        [self.navigationController pushViewController:System animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable1       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 120, 20)];
        lable1.text            = @"群基本信息";
        lable1.font            = [UIFont boldSystemFontOfSize:16];
        [imageView addSubview:lable1];
        return imageView;
    }
    else if(section == 1)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable2       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
        lable2.text            = @"管理员";
        lable2.font            = [UIFont boldSystemFontOfSize:16];
        [imageView addSubview:lable2];
        return imageView;
    }else if(section == 2)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        UILabel * lable3       = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 80, 20)];
        lable3.text            = @"群成员";
        lable3.font            = [UIFont boldSystemFontOfSize:16];
        [imageView addSubview:lable3];
        return imageView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GroupMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Group"];
        if (!cell) {
            cell = [[GroupMembersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Group"];
        }
        cell.FirstTitle.text    = GroupNAme;
        cell.SecondTitle.text   = GroupIntro;
        cell.SecondTitle.numberOfLines = 0;
        CGRect textFrame    = cell.SecondTitle.frame;
        cell.SecondTitle.frame  = CGRectMake(CGRectGetMaxX(cell.PicImageView.frame)+10, CGRectGetMaxY(cell.GirlNumTitle.frame)+10, kScreenWidth-125, textFrame.size.height = [cell.SecondTitle.text boundingRectWithSize:CGSizeMake(textFrame.size.width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:cell.SecondTitle.font,NSFontAttributeName ,nil] context:nil].size.height);
        cell.SecondTitle.frame  = CGRectMake(CGRectGetMaxX(cell.PicImageView.frame)+10, CGRectGetMaxY(cell.GirlNumTitle.frame)+10, kScreenWidth-125, textFrame.size.height);
        [cell.contentView addSubview:cell.FirstTitle];
        [cell.contentView addSubview:cell.SecondTitle];
        if ([chatGroupPhotoUrl isKindOfClass:[NSNull class]]) {
            cell.PicImageView.image = [UIImage imageNamed:@"icon-群组头像.png"];
        }else{
            [cell.PicImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,chatGroupPhotoUrl]] placeholderImage:nil];
        }
        [cell.contentView addSubview:cell.PicImageView];
        cell.BoyNumTitle.text    = [NSString stringWithFormat:@"%ld人",BoyArray.count];
        [cell.contentView addSubview:cell.BoyNumTitle];
        cell.GirlNumTitle.text   = [NSString stringWithFormat:@"%ld人",GirlArray.count];
        [cell.contentView addSubview:cell.GirlNumTitle];
        cell.JiaMNumTitle.text   = [NSString stringWithFormat:@"%ld人",OrgArray.count];
        [cell.contentView addSubview:cell.JiaMNumTitle];
        return cell;
    }
    else if (indexPath.section == 1){
        FbwManager *Manager = [FbwManager shareManager];
        GroupMembersSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec"];
        if (!cell) {
            cell = [[GroupMembersSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Sec"];
        }
        [cell.PicManager setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,userPhotoHead]] placeholderImage:nil];
        cell.PicManager.layer.cornerRadius = 45;
        cell.PicManager.layer.masksToBounds = YES;
        [cell.contentView addSubview:cell.PicManager];
        cell.NameLabel.text = OrgUserNAme;
        if (OrgSex == 0) {
            cell.BoyPic.image = [UIImage imageNamed:@"形状-2-拷贝@2x_49.png"];
        }else if(OrgSex == 1){
            cell.BoyPic.image = [UIImage imageNamed:@"形状-1-拷贝-2@2x_29.png"];
        }else{
            cell.BoyPic.image = [UIImage imageNamed:@"icon_sex_secret.png"];
        }
        if ([Manager.GroupCreateUserId isEqualToString:@"TeacherChuangJian"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIButton    *SetSegMent = [UIButton buttonWithType:UIButtonTypeCustom];
                SetSegMent  .frame     = CGRectMake((kScreenWidth-100)/2+30, (150-40)/2, 100, 40);
                SetSegMent  .backgroundColor = kAppBlueColor;
                [SetSegMent setTitle:@"更换管理员" forState:UIControlStateNormal];
                [SetSegMent addTarget:self action:@selector(SetAniManager:) forControlEvents:UIControlEventTouchUpInside];
                [SetSegMent setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
                [cell.contentView addSubview:SetSegMent];
            });
        }
        [cell.contentView addSubview:cell.NameLabel];
        [cell.contentView addSubview:cell.BoyPic];
        return cell;
    }
    GroupMembersMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCe"];
    if (!cell) {
        cell = [[GroupMembersMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdCe"];
    }
    CGFloat xSpace = (kScreenWidth - 3*(kScreenWidth/3.5))/4;
    UIButton *GroupAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    NSLog(@"我不看%ld",_dataArray.count);
    if (_dataArray.count == 0) {
        GroupAddBtn.frame = CGRectMake(xSpace, 70, 80, 80);
        GroupAddBtn.layer.cornerRadius  = 40;
        GroupAddBtn.layer.masksToBounds = YES;
        [GroupAddBtn setBackgroundImage:[UIImage imageNamed:@"矩形-1-拷贝-2@2x.png"] forState:UIControlStateNormal];
        [GroupAddBtn addTarget:self action:@selector(AddStudent:) forControlEvents:UIControlEventTouchUpInside];
        GroupAddBtn.backgroundColor = kAppRedColor;
        [cell.contentView addSubview:GroupAddBtn];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < _dataArray.count; i++) {
            GroupMembersModel *Model = _dataArray[i];
            cell.GroupMembersButton  = [UIButton buttonWithType:UIButtonTypeCustom];
            cell.GroupMembersButton.tag = i;
            cell.GroupMembersButton.frame      = CGRectMake(xSpace + (i % 3)*(xSpace + (kScreenWidth/3.5)), (i / 3)*(xSpace + 30) + 70 , 80, 80);
            if ((i - 2)%3 == 0) {
                NSLog(@"这tm就是进来了啊%d",i);
                GroupAddBtn.frame = CGRectMake(xSpace, (i / 2)*(xSpace + 30) + 70 * (i+1)/3+70, 80, 80);
            }
            if (i < 2) {
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5) + (4 % 3)*(xSpace + kScreenWidth/3.5), (i / 3)*(xSpace + 30) + 70, 80, 80);
                
            }else if (i > 2 && i < 5){
                GroupAddBtn.frame = CGRectMake(xSpace + ((i % 3)+1)*(xSpace +  kScreenWidth/3.5), (i / 3)*(xSpace + 30) + 70 * 2, 80, 80);
                
            }else if (i > 5 && i < 8){
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 5)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 3, 80, 80);
                
            }else if (i > 8 && i < 11){
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 8)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 4, 80, 80);
                
            }else if (i > 11 && i < 14){
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 11)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 5, 80, 80);
                
            }else if (i > 14 && i < 17){
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 14)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 6, 80, 80);
                
            }else if (i > 17 && i < 20){
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 17)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 7, 80, 80);
                
            }else if (i > 20 && i < 23){
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 20)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 8, 80, 80);
                
            }else if (i > 23 && i < 26){
                GroupAddBtn.frame = CGRectMake(xSpace + (i % 23)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 9, 80, 80);
                
            }
            cell.DeleteBtnPic = [UIButton buttonWithType:UIButtonTypeCustom];
            cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70, 20, 20);
            [cell.DeleteBtnPic setBackgroundImage:[UIImage imageNamed:@"删除Ha@2x.png"] forState:UIControlStateNormal];
            cell.DeleteBtnPic.tag = i;
            cell.DeleteBtnPic.layer.cornerRadius = 10;
            cell.DeleteBtnPic.layer.masksToBounds = YES;
            cell.GroupMembersName    = [[UILabel alloc]initWithFrame:CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 , (i / 3)*(xSpace + 30) + 70 * 2 + 10, 80, kScreenHeight/7.2-70)];
            cell.GroupMembersName.textAlignment = NSTextAlignmentCenter;
            cell.GroupMembersImageSex  = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 2 + 15, 20, 20)];
            if ([[NSString stringWithFormat:@"%ld",(long)Model.GroupMembersSex] isEqualToString:@"1"]) {
                cell.GroupMembersImageSex.image = [UIImage imageNamed:@"形状-1-拷贝-2@2x_29.png"];
            }else{
                cell.GroupMembersImageSex.image = [UIImage imageNamed:@"形状-2-拷贝@2x_49.png"];
            }
            cell.GroupMembersName.font        = [UIFont systemFontOfSize:16];
            cell.GroupMembersName.tag         = i;
            cell.GroupMembersName.text        = Model.GroupMembersName;
            cell.GroupMembersName.textAlignment = NSTextAlignmentCenter;
            if (i > 2 ) {
                cell.GroupMembersButton.frame     = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5), (i / 3)*(xSpace + 30) + 70 * 2, 80, 80);
                cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 2, 20, 20);
                cell.GroupMembersName.frame      = CGRectMake(xSpace + (i % 3)*(xSpace+kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 3 + 10, 80, kScreenHeight/7.2-70);
                cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 3 + 15, 20, 20);
                if (i > 5) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 3, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 3, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 4 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 4 + 15, 20, 20);
                }//矩形-1-拷贝-2@2x.png
                if (i > 8) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 4, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 4, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 5 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 5 + 15, 20, 20);
                }
                if (i > 11) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 5, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 5, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 6 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 6 + 15, 20, 20);
                }
                if (i > 14) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 6, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 6, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 7 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 7 + 15, 20, 20);
                }
                if (i > 17) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 7, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 7, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 8 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 8 + 15, 20, 20);
                }
                if (i > 20) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 8, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 8, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 9 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 9 + 15, 20, 20);
                }
                if (i > 23) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 9, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 9, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 10 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 10 + 15, 20, 20);
                }
                if (i > 26) {
                    cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 10, 80, 80);
                    cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 10, 20, 20);
                    cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 11 + 10, 80, kScreenHeight/7.2-70);
                    cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 11 + 15, 20, 20);
                }
            }
            if (Model.GroupMembersUserPhotoHead == nil || [Model.GroupMembersUserPhotoHead isKindOfClass:[NSNull class]]) {
                [cell.GroupMembersButton setBackgroundImage:[UIImage imageNamed:@"哭脸.png"] forState:UIControlStateNormal];
            }else{
                cell.GroupMembersButton.layer.cornerRadius = 40;
                cell.GroupMembersButton.layer.masksToBounds = YES;
                [cell.GroupMembersButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.GroupMembersUserPhotoHead]]];
            }
            [cell.GroupMembersButton addTarget:self action:@selector(UserINfoFriend:) forControlEvents:UIControlEventTouchUpInside];
            [cell.DeleteBtnPic addTarget:self action:@selector(UserInfoDelete:) forControlEvents:UIControlEventTouchUpInside];
            GroupAddBtn.layer.cornerRadius  = 40;
            GroupAddBtn.layer.masksToBounds = YES;
            [GroupAddBtn setBackgroundImage:[UIImage imageNamed:@"矩形-1-拷贝-2@2x.png"] forState:UIControlStateNormal];
            [GroupAddBtn addTarget:self action:@selector(AddStudent:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:cell.GroupMembersButton];
            [cell.contentView addSubview:cell.GroupMembersImageSex];
            [cell.contentView addSubview:cell.DeleteBtnPic];
            [cell.contentView addSubview:GroupAddBtn];
            [cell.contentView addSubview:cell.GroupMembersName];
        }
    });
//    GroupMembersMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCe"];
//    if (!cell) {
//        cell = [[GroupMembersMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdCe"];
//    }
//    CGFloat xSpace = (kScreenWidth - 3*(kScreenWidth/3.5))/4;
//    UIButton *GroupAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    if (_dataArray.count == 0) {
//        NSLog(@"你看%ld",(long)xSpace);
//        GroupAddBtn.frame = CGRectMake(xSpace, 70, 80, 80);
//        GroupAddBtn.layer.cornerRadius  = 40;
//        GroupAddBtn.layer.masksToBounds = YES;
//        [GroupAddBtn setBackgroundImage:[UIImage imageNamed:@"矩形-1-拷贝-2@2x.png"] forState:UIControlStateNormal];
//        [GroupAddBtn addTarget:self action:@selector(AddStudent:) forControlEvents:UIControlEventTouchUpInside];
//        GroupAddBtn.backgroundColor = kAppRedColor;
//        [cell.contentView addSubview:GroupAddBtn];
//    }
//    for (int i = 0; i < _dataArray.count; i++) {
//        GroupMembersModel *Model = _dataArray[i];
//        cell.GroupMembersButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//        cell.GroupMembersButton.tag = i;
//        cell.GroupMembersButton.frame      = CGRectMake(xSpace + (i % 3)*(xSpace + (kScreenWidth/3.5)), (i / 3)*(xSpace + 30) + 70 , 80, 80);
//        if (i < 2) {
//            GroupAddBtn.frame = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5) + (4 % 3)*(xSpace + kScreenWidth/3.5), (i / 3)*(xSpace + 30) + 70, 80, 80);
//            
//        }else if (i >= 2 && i < 5){
//            if (i == 2) {
//                GroupAddBtn.frame = CGRectMake(xSpace + (i % 2)*(xSpace +  kScreenWidth/3.5), (i / 2)*(xSpace + 30) + 70 * 2, 80, 80);
//            }else{
//                GroupAddBtn.frame = CGRectMake(xSpace + ((i % 3)+1)*(xSpace +  kScreenWidth/3.5), (i / 3)*(xSpace + 30) + 70 * 2, 80, 80);
//            }
//        }else if (i >= 5){
//            GroupAddBtn.frame = CGRectMake(xSpace + (i % 5)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 4, 80, 80);
//        }
//        cell.DeleteBtnPic = [UIButton buttonWithType:UIButtonTypeCustom];
//        cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70, 20, 20);
//        [cell.DeleteBtnPic setBackgroundImage:[UIImage imageNamed:@"删除Ha@2x.png"] forState:UIControlStateNormal];
//        cell.DeleteBtnPic.tag = i;
//        cell.DeleteBtnPic.layer.cornerRadius = 10;
//        cell.DeleteBtnPic.layer.masksToBounds = YES;
//        cell.GroupMembersName    = [[UILabel alloc]initWithFrame:CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 , (i / 3)*(xSpace + 30) + 70 * 2 + 10, 80, kScreenHeight/7.2-70)];
//        cell.GroupMembersName.textAlignment = NSTextAlignmentCenter;
//        cell.GroupMembersImageSex  = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 2 + 15, 20, 20)];
//        if ([[NSString stringWithFormat:@"%ld",(long)Model.GroupMembersSex] isEqualToString:@"1"]) {
//            cell.GroupMembersImageSex.image = [UIImage imageNamed:@"形状-1-拷贝-2@2x_29.png"];
//        }else{
//            cell.GroupMembersImageSex.image = [UIImage imageNamed:@"形状-2-拷贝@2x_49.png"];
//        }
//        cell.GroupMembersName.font        = [UIFont systemFontOfSize:16];
//        cell.GroupMembersName.tag         = i;
//        cell.GroupMembersName.text        = Model.GroupMembersName;
//        cell.GroupMembersName.textAlignment = NSTextAlignmentCenter;
//        if (i > 2 ) {
//            cell.GroupMembersButton.frame     = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5), (i / 3)*(xSpace + 30) + 70 * 2, 80, 80);
//            cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 2, 20, 20);
//            cell.GroupMembersName.frame      = CGRectMake(xSpace + (i % 3)*(xSpace+kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 3 + 10, 80, kScreenHeight/7.2-70);
//            cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 3 + 15, 20, 20);
//            if (i > 5) {
//                cell.GroupMembersButton.frame = CGRectMake(xSpace + (i % 3)*(xSpace +  kScreenWidth/3.5),(i / 3)*(xSpace + 30) + 70 * 3, 80, 80);
//                cell.DeleteBtnPic.frame = CGRectMake(CGRectGetMaxX(cell.GroupMembersButton.frame)-30, (i / 3)*(xSpace + 30) + 70 * 3, 20, 20);
//                cell.GroupMembersName.frame  = CGRectMake(xSpace + (i % 3)*(xSpace + kScreenWidth/3.5)-5 ,(i / 3)*(xSpace + 30) + 70 * 4 + 10, 80, kScreenHeight/7.2-70);
//                cell.GroupMembersImageSex.frame  = CGRectMake(CGRectGetMaxX(cell.GroupMembersName.frame)+5, (i / 3)*(xSpace + 30) + 70 * 4 + 15, 20, 20);
//            }//矩形-1-拷贝-2@2x.png
//        }
//        if ([Model.GroupMembersUserPhotoHead isKindOfClass:[NSNull class]]) {
//            [cell.GroupMembersButton setBackgroundImage:[UIImage imageNamed:@"哭脸.png"] forState:UIControlStateNormal];
//        }else{
//            cell.GroupMembersButton.layer.cornerRadius = 40;
//            cell.GroupMembersButton.layer.masksToBounds = YES;
//            [cell.GroupMembersButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,Model.GroupMembersUserPhotoHead]]];
//        }
//        [cell.GroupMembersButton addTarget:self action:@selector(UserINfoFriend:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.DeleteBtnPic addTarget:self action:@selector(UserInfoDelete:) forControlEvents:UIControlEventTouchUpInside];
//        GroupAddBtn.layer.cornerRadius  = 40;
//        GroupAddBtn.layer.masksToBounds = YES;
//        [GroupAddBtn setBackgroundImage:[UIImage imageNamed:@"矩形-1-拷贝-2@2x.png"] forState:UIControlStateNormal];
//        [GroupAddBtn addTarget:self action:@selector(AddStudent:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [cell.contentView addSubview:cell.GroupMembersButton];
//        [cell.contentView addSubview:cell.GroupMembersImageSex];
//        [cell.contentView addSubview:cell.DeleteBtnPic];
//        [cell.contentView addSubview:GroupAddBtn];
//        [cell.contentView addSubview:cell.GroupMembersName];
//    }
    return cell;
}

-(void)SetAniManager:(UIButton *)btn
{
    SetAdministratorVC *administra = [[SetAdministratorVC alloc]init];
    administra.WhereCome = @"ChangeManager";
    administra.GroupID = _GroupId;
    [self.navigationController pushViewController:administra animated:YES];
}

-(void)AddStudent:(UIButton *)AddSt
{
//    NSArray *arr = @[@{@"id":@"a97d1c79-c29c-4d01-bf85-065788e1c56c"}];
//    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":GroupTId,@"userIdListStr":jsonStr} url:UrL_AddStudent success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
//        NSLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//        
//    }];
    NSArray *arr = @[@"添加未加入学员",@"添加好友"];
    PushView = [[UIView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/4)/2, kScreenWidth-20, kScreenHeight/4)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
    imageView.image = [UIImage imageNamed:@"提示-(1)@2x.png"];
    UILabel *LAbel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 15, kScreenWidth/7, 20)];
    LAbel.text = @"请选择";
    LAbel.font = [UIFont boldSystemFontOfSize:16];
    [PushView addSubview:imageView];
    [PushView addSubview:LAbel];
    PushView.backgroundColor = kAppWhiteColor;
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((kScreenWidth - (kScreenWidth - 60)/2)/2, 40+i*60, (kScreenWidth - 60)/2, 40);
        button.tag = 10+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.layer.borderColor = kAppBlackColor.CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        [button setTitleColor:kAppBlackColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(ChooseTn:) forControlEvents:UIControlEventTouchUpInside];
        [PushView addSubview:button];
    }
    UIButton *CloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CloseBtn.backgroundColor = kAppWhiteColor;
    CloseBtn.frame = CGRectMake(kScreenWidth-50, 15, 20, 20);
    [CloseBtn setBackgroundImage:[UIImage imageNamed:@"删除Ha@2x.png"] forState:UIControlStateNormal];
    [CloseBtn addTarget:self action:@selector(CloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [PushView addSubview:CloseBtn];
    
    [[[UIApplication sharedApplication].windows lastObject]addSubview:PushView];
    //未添加学员
//        AddStudentVC *Stu = [[AddStudentVC alloc]init];
//        Stu.GroupID = GroupTId;
//        [self.navigationController pushViewController:Stu animated:YES];
}

-(void)ChooseTn:(UIButton *)Bt
{
    if (Bt.tag == 10) {
        NSLog(@"添加未加入学员");
        //未添加学员
        AddStudentVC *Stu = [[AddStudentVC alloc]init];
        Stu.GroupID = GroupTId;
        [self.navigationController pushViewController:Stu animated:YES];
    }else{
        NSLog(@"添加好友");
        SetAdministratorVC *AddFriend = [[SetAdministratorVC alloc]init];
        AddFriend.WhereCome = @"AddQunPeople";
        AddFriend.GroupID = GroupTId;
        [self.navigationController pushViewController:AddFriend animated:YES];
    }
}

-(void)CloseBtn:(UIButton *)CloseBtn
{
    NSLog(@"关闭");
    [PushView removeFromSuperview];
}

-(void)UserINfoFriend:(UIButton *)Btn
{
    GroupMembersModel *Model = _dataArray[Btn.tag];
    FriendUserInfoVC *info = [[FriendUserInfoVC alloc]init];
    info.UserInfoId = Model.GroupMembersFkId;
    [self.navigationController pushViewController:info animated:YES];
}

-(void)UserInfoDelete:(UIButton *)DeleBtn
{
    __weak typeof(self) weakSelf = self;
    GroupMembersModel *Model = _dataArray[DeleBtn.tag];
    NSArray *arr = @[@{@"id":Model.GroupMembersId}];
    NSData *data=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"memberIdListStr":jsonStr} url:UrL_RemoveGroupPeople success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        [weakSelf.dataArray removeObject:weakSelf.dataArray[DeleBtn.tag]];
        [weakSelf.tableView reloadData];
        [weakSelf createTableView];
    } failure:^(NSError *error) {
    }];
}
//
//-(void)SetAniManager:(UIButton *)btn
//{
////    SetAdministratorVC *administra = [[SetAdministratorVC alloc]init];
////    [self.navigationController pushViewController:administra animated:YES];
//}

-(void)createNav
{
    FbwManager *Manager = [FbwManager shareManager];
    UIView *NavBarview  = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 80)/2, 10, 80, 30)];
    label.text          = @"群成员";
    label.textAlignment = NSTextAlignmentCenter;
    label.font          = [UIFont boldSystemFontOfSize:16];
    label.textColor     = [UIColor whiteColor];
    UIButton *button1   = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame       = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BtnFanClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    UIButton *button2       = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame           = CGRectMake(kScreenWidth - 70, 10, 40, 30);
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    NSLog(@"干干干%@",Manager.GroupCreateUserId);
    if ([Manager.GroupCreateUserId isEqualToString:@"TeacherChuangJian"]) {
        [button2 setTitle:@"解散" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(JieSanClick:) forControlEvents:UIControlEventTouchUpInside];
//        Manager.GroupCreateUserId = @"";
    }else{
        [button2 setTitle:@"退出" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(OverClick:) forControlEvents:UIControlEventTouchUpInside];
//        Manager.GroupCreateUserId = @"";
    }
    
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view  addSubview:NavBarview];
}

-(void)BtnFanClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)JieSanClick:(UIButton *)Ove
{
    __weak typeof(self) weakSelf = self;
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定解散该群？"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            FbwManager *Manager = [FbwManager shareManager];
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"groupId":GroupTId,@"userId":Manager.UUserId} url:UrL_DelateChatGroup success:^(id responseObject) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
            }];
        }
    }];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
}

-(void)OverClick:(UIButton *)btn
{
    __weak typeof(self) weakSelf = self;
    _arrowView=[[ArrowView alloc]initWithFrame:CGRectMake(10, (kScreenHeight-kScreenHeight/2.9)/2, kScreenWidth-20, kScreenHeight/2.9)];
    [_arrowView setBackgroundColor:[UIColor clearColor]];
    [_arrowView addUIButtonWithTitle:[NSArray arrayWithObjects:@"取消",@"确定", nil] WithText:@"确定退出该群？"];
    [_arrowView setSelectBlock:^(UIButton *button){
        if (button.tag == 10) {
        }else if (button.tag == 11){
            NSLog(@"我来看看%@",AdminId);
            NSArray *arr = @[@{@"id":AdminId}];
            NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"memberIdListStr":jsonStr} url:UrL_RemoveGroupPeople success:^(id responseObject) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } failure:^(NSError *error) {
            }];
        }
    }];
//    [weakSelf createTableView];
//    [weakSelf.tableView reloadData];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_arrowView];
    [_arrowView showArrowView:YES];
//    __weak typeof(self) weakSelf = self;
    
}
@end
