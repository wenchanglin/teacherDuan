//
//  ChatWithFriendVc.m
//  ShangKTeacher
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 Fbw. All rights reserved.
//
#define PLUGIN_BOARD_ITEM_LOCATION_TAG 1003
#import "ChatWithFriendVc.h"
#import "AppDelegate.h"
#import "FriendUserInfoVC.h"
#import "GroupMembersVC.h"
#import "LocationVCMap.h"
@interface ChatWithFriendVc ()<RCLocationPickerViewControllerDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource>
{
    UIButton * button2;
    UIView *NavBarview;
    NSString     *_UserInfoPic;
    NSString     *_UserInfoName;
}
@end
@implementation ChatWithFriendVc
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.barView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = kAppWhiteColor;
    [self createNav];
}

-(void)createNav
{
    NavBarview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    NavBarview.backgroundColor = kAppBlueColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 200)/2, 10, 200, 30)];
    label.text = self.NavTitleStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = kAppWhiteColor;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 10, 30, 30);
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button1 setImage:[UIImage imageNamed:@"图层-54.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(BaCYlick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:kAppWhiteColor];
    if ([self.QuTitle isEqualToString:@"Dan"]) {
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
        [button2 setBackgroundImage:[UIImage imageNamed:@"我的@3x你的.png"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(FriendInfoClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
        [button2 setBackgroundImage:[UIImage imageNamed:@"群组Y-(2)@2x.png"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(FriendfoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [NavBarview addSubview:button1];
    [NavBarview addSubview:button2];
    [NavBarview addSubview:label];
    [self.view addSubview:NavBarview];
}

- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    switch (tag) {
        case  PLUGIN_BOARD_ITEM_LOCATION_TAG : {
            LocationVCMap *vc = [[LocationVCMap alloc]init];
            vc.delegate = self;
            self.navigationController.navigationBar.barTintColor = kAppBlueColor;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        default:
            [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
            break;
    }
}

- (void)locationPicker:(RCLocationPickerViewController *)locationPicker
     didSelectLocation:(CLLocationCoordinate2D)location
          locationName:(NSString *)locationName
         mapScreenShot:(UIImage *)mapScreenShot
{
    RCLocationMessage *locationMessage =
    [RCLocationMessage messageWithLocationImage:mapScreenShot
                                       location:location
                                   locationName:locationName];
    [self sendMessage:locationMessage pushContent:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    FbwManager *Manager =[FbwManager shareManager];
    [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"teacherId":Manager.UUserId} url:UrL_SearchTeacher success:^(id responseObject) {
        NSLog(@"教师信息%@",responseObject);
        NSDictionary *rootTDic = [responseObject objectForKey:@"data"];
        NSDictionary *diTct = [rootTDic objectForKey:@"userInfoBase"];
        if ([[diTct objectForKey:@"userPhotoHead"] isKindOfClass:[NSNull class]]) {
            
        }else{
            _UserInfoPic = [diTct objectForKey:@"userPhotoHead"];
        }
        if ([[diTct objectForKey:@"nickName"] isKindOfClass:[NSNull class]]) {
            
        }else{
            _UserInfoName = [diTct objectForKey:@"nickName"];
        }
        if ([userId isEqualToString:Manager.UUserId]) {
            return completion([[RCUserInfo alloc] initWithUserId:userId name:_UserInfoName portrait:[NSString stringWithFormat:@"%@%@",BASEURL,_UserInfoPic]]);
        }else
        {
            {
                [[AFHttpClient shareInstance]startRequestMethod:POST parameters:@{@"userId":Manager.UUserId,@"friendUserId":self.UserInfoId} url:UrL_FriendDetails success:^(id responseObject) {
                    NSLog(@"好友详情%@",responseObject);
                    if([responseObject[@"data"][@"userPhotoHead"] isKindOfClass:[NSNull class]] || responseObject[@"data"][@"userPhotoHead"] == nil )
                    {
                        return completion([[RCUserInfo alloc] initWithUserId:self.targetId name:responseObject[@"data"][@"nickName"] portrait:nil]);
                    }
                    else
                    {
                        NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,responseObject[@"data"][@"userPhotoHead"]];
                        return completion([[RCUserInfo alloc] initWithUserId:self.targetId name:responseObject[@"data"][@"nickName"] portrait:url]);
                    }
                } failure:^(NSError *error) {
                }];
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)FriendfoClick
{
    GroupMembersVC *Meb = [[GroupMembersVC alloc]init];
    Meb.NavTitle = self.NavTitleStr;
    Meb.GroupId  = self.GroupId;
    [self.navigationController pushViewController:Meb animated:YES];
}

-(void)FriendInfoClick:(UIButton *)Inf
{
    FriendUserInfoVC *friendInfo = [[FriendUserInfoVC alloc]init];
    friendInfo.UserInfoId = self.UserInfoId;
    [self.navigationController pushViewController:friendInfo animated:YES];
}

-(void)BaCYlick:(UIButton *)btn
{
    FbwManager *Manager = [FbwManager shareManager];
    Manager.IsListPulling = 3;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
