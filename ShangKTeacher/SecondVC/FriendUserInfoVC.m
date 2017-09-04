//
//  FriendUserInfoVC.m
//  ShangKTeacher
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import "FriendUserInfoVC.h"
#import "FriendUserInfoFirstCell.h"
#import "FriendUserInfoSecondCell.h"
#import "FriendYanZhengVC.h"
@interface FriendUserInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSString *_NickName;
    NSInteger _IsFriend;
    NSString *_Intro;
    NSString *_ImageViewPic;
    NSInteger _Sex;
    NSString *_FriendId;
    NSMutableArray  *_UserInfoArr;
}
@end
@implementation FriendUserInfoVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self createData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KAppBackBgColor;
    _UserInfoArr = [NSMutableArray array];
    [self createNav];
   
}

-(void)creaetUI
{
    UIButton *FriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    FriendButton.frame = CGRectMake(10, 340, kScreenWidth-20,60);
    FriendButton.backgroundColor = kAppRedColor;
    [FriendButton setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(((kScreenWidth-20)-90)/2, 15,90, 30)];
    Label.font =[UIFont boldSystemFontOfSize:16];
    Label.textColor = kAppWhiteColor;
    if (_IsFriend == 1) {
        Label.text = @"添加好友";
        [FriendButton addTarget:self action:@selector(AddFriend) forControlEvents:UIControlEventTouchUpInside];
    }else if(_IsFriend == 2){
        Label.text = @"删除好友";
        [FriendButton addTarget:self action:@selector(DeleteFriend) forControlEvents:UIControlEventTouchUpInside];
    }
    [FriendButton addSubview:Label];
    [self.view addSubview:FriendButton];
}

-(void)AddFriend
{
    FriendYanZhengVC *Friend = [[FriendYanZhengVC alloc]init];
    Friend.FriendId = self.UserInfoId;
    [self.navigationController pushViewController:Friend animated:YES];
}

-(void)DeleteFriend
{
    NSLog(@"删除好友");
    NSLog(@"看看id%@",_FriendId);
    __weak typeof(self) weakSelf = self;
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"chatFriendId":self.UserInfoId} url:UrL_DeleteFriend success:^(id responseObject) {
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
    }];
}

-(void)createData
{
    FbwManager *Manager = [FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"friendUserId":self.UserInfoId} url:UrL_FriendDetails success:^(id responseObject) {
        NSLog(@"呵呵哒你妹%@",responseObject);
//        [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        NSDictionary *rootDic = [responseObject objectForKey:@"data"];
//        NSDictionary *FrendDic = [rootDic objectForKey:@"chatFriend"];
        _FriendId = [rootDic objectForKey:@"id"];
        _NickName = [rootDic objectForKey:@"nickName"];
        _IsFriend = [[rootDic objectForKey:@"isFriend"]integerValue];
        if ([[rootDic objectForKey:@"intro"] isKindOfClass:[NSNull class]]) {
            _Intro    = @"还没有简介呢";
        }else{
            _Intro    = [rootDic objectForKey:@"intro"];
        }
        _ImageViewPic = [rootDic objectForKey:@"userPhotoHead"];
        NSLog(@"我果然%@",[rootDic objectForKey:@"sex"]);
        if ([[rootDic objectForKey:@"sex"] isKindOfClass:[NSNull class]]) {
            _Sex = 2;
        }else{
            _Sex  = [[rootDic objectForKey:@"sex"]integerValue];
        }
        [_UserInfoArr addObject:_NickName];
        [_UserInfoArr addObject:_Intro];
        //        [_UserInfoArr addObject:_Sex];
        [_tableView reloadData];
        [self createTAbleView];
         [self creaetUI];
//        NSLog(@"看看好友%ld",_IsFriend);
    } failure:^(NSError *error) {
    }];
}

-(void)createTAbleView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 270) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *ARR = @[@"昵称",@"性别",@"个性签名"];
    if (indexPath.row == 0) {
        FriendUserInfoFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Could"];
        if (!cell) {
            cell = [[FriendUserInfoFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Could"];
        }
        if ([_ImageViewPic isKindOfClass:[NSNull class]]) {
            cell.ImageView.image = [UIImage imageNamed:@"哭脸.png"];
        }else{
            [cell.ImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,_ImageViewPic]] placeholderImage:nil];
        }
        [cell.contentView addSubview:cell.ImageView];
        return cell;
    }else{
        FriendUserInfoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Chat"];
        if (!cell) {
            cell = [[FriendUserInfoSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Chat"];
        }
        cell.InfoSecondTit.text = ARR[indexPath.row - 1];
        //        cell.InfoSecondInfo.text = _UserInfoArr[indexPath.row+1];
        if (indexPath.row == 1) {
            cell.InfoSecondInfo.text = _UserInfoArr[0];
        }
        if (indexPath.row == 2) {
            //            if ([[NSString stringWithFormat:@"%ld",_UserInfoArr[2]]isEqualToString:@"0"]) {
            //                cell.InfoSecondInfo.text = @"男";
            //            }else{
            if (_Sex == 0) {
                cell.InfoSecondInfo.text = @"女";
            }else if(_Sex == 1){
                cell.InfoSecondInfo.text = @"男";
            }else{
                cell.InfoSecondInfo.text = @"保密";
            }
            
            //            }
        }
        if (indexPath.row == 3) {
            cell.InfoSecondInfo.text = _UserInfoArr[1];
        }
        return cell;
    }
}

-(void)createNav
{
    UIView *NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, 10, 200, 30)];
    label.text = @"个人详情";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Frinedck) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

-(void)Frinedck
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
