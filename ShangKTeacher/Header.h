//
//  Header.h
//  ShangKTeacher
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark 获取当前屏幕的宽度、高度
//宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//http://139.196.233.19:8080/skl/
//        [SVProgressHUD showWithStatus:@"加载中..."];http://192.168.3.234:8080/skl/
//http://192.168.3.158:10000/skl/
#define BASEURL @"http://139.196.233.19:8080/skl/"
#define UrL_MACRO(p) [NSString stringWithFormat:@"%@%@",BASEURL,p]

#define UrL_Login                      UrL_MACRO(@"user/login")//登录
#define UrL_NewPassWord                UrL_MACRO(@"user/changePassword")//修改密码
#define UrL_HomeStudent                UrL_MACRO(@"course/queryCoursesForTeacher")//学生作业
#define UrL_HomeworkIssue              UrL_MACRO(@"courseHomeworkIssue/queryCourseHomeworkIssueByCourseId")//学生作业(发布作业)
#define UrL_HomeworkLieBiao            UrL_MACRO(@"courseHomeworkIssue/queryStudentCourseHomeworkAnswerList")//作业列表
#define UrL_AddHomeWork                UrL_MACRO(@"courseHomeworkIssue/addCourseHomeworkIssue")//添加作业
#define UrL_HomeWorkXiangQ             UrL_MACRO(@"courseHomeworkIssue/geCourseHomeworkIssueDetailById")//Every作业详情
#define UrL_StudentHomeWorkXiangQ      UrL_MACRO(@"courseHomeworkIssue/getCourseHomeworkAnswerById")//学生作业详情
#define UrL_StudentHomeworkAnswer      UrL_MACRO(@"courseHomeworkIssue/queryCourseHomeworkReplyList")//教师回复列表
#define UrL_UploadFile                 UrL_MACRO(@"file/uploadFile")//文件上传
#define UrL_VideoCourseSellCount       UrL_MACRO(@"videoCourse/queryVideoCourseByConditions")//畅销视频
#define UrL_EveryVideoDetail           UrL_MACRO(@"videoCourse/queryVideoCourseDetail")//视频详情
#define UrL_EveryVideoStore            UrL_MACRO(@"videoCourse/queryVideoStore")//视频商家  
#define UrL_courseConments             UrL_MACRO(@"videoCourse/queryCourseComments")//视频详情评价列表
#define UrL_BuyVideoS                  UrL_MACRO(@"videoCourse/submitVideoOrder")//购买视频 
#define UrL_MyVideoS                   UrL_MACRO(@"videoCourse/queryMyVideosByCondition")//我的视频
#define UrL_MyObject                   UrL_MACRO(@"course/queryCoursesForTeacher")//教师课程列表
#define UrL_ObjectConment              UrL_MACRO(@"course/queryCourseComments")//课程评论
#define UrL_CourseDetail               UrL_MACRO(@"course/queryCourseDetail")//课程详情
#define UrL_MyVideoS                   UrL_MACRO(@"videoCourse/queryMyVideosByCondition")//我的视频
#define UrL_BuyVideoS                  UrL_MACRO(@"videoCourse/submitVideoOrder")//购买视频
#define UrL_DownLoadMyVideoS           UrL_MACRO(@"videoCourse/downloadVideoCourse")//下载视频
#define UrL_BuyVip                     UrL_MACRO(@"videoCourse/submitVideoVipOrder")//会员包月
#define UrL_BuyVip                     UrL_MACRO(@"videoCourse/submitVideoVipOrder")//会员包月
#define UrL_PriceVip                   UrL_MACRO(@"videoCourse/submitVideoVipOrderShowAdd")//Vip价格表
#define UrL_DeleteDownLloadVideo       UrL_MACRO(@"videoCourse/removeDownloadVideoCourse")//删除已下载视频
#define UrL_VideoPlay                  UrL_MACRO(@"videoCourse/queryVideoCourseDetail")//获取视频
#define UrL_DeleteAleradySeeVideo      UrL_MACRO(@"videoCourse/removeWatchVideoCourse")//删除已观看视频
#define UrL_PlayVideoPlay              UrL_MACRO(@"videoCourse/playVideoCourse")//播放视频
#define UrL_MoneyOrder                 UrL_MACRO(@"useraccount/addUserAccountCash")//提现
#define UrL_FinancialDetails           UrL_MACRO(@"useraccount/queryUserAccountDetails")//资金明细
#define UrL_ChatGroupsQuery            UrL_MACRO(@"chat/queryMyChatGroupsForUser")//群聊列表
#define UrL_FriendQuery                UrL_MACRO(@"chat/queryMyFriends")//好友列表
#define UrL_DeleteFriend               UrL_MACRO(@"chat/deleteChatFriend")//删除好友
#define UrL_FriendDetails              UrL_MACRO(@"chat/queryFriendInfo")//好友详情
#define UrL_UpdateChatGroup            UrL_MACRO(@"chat/updateChatGroup")//群聊修改简介
#define UrL_GroupsInfo                 UrL_MACRO(@"chat/queryChatGroupInfo")//群聊详情
#define UrL_DelateChatGroup            UrL_MACRO(@"chat/deleteChatGroup")//群聊删除
#define UrL_RemoveGroupPeople          UrL_MACRO(@"chat/removeMembers")//删除成员  
#define UrL_GroupsOfGroup              UrL_MACRO(@"chat/queryMembersOfGroup")//查看群成员
#define UrL_AddStudentOther            UrL_MACRO(@"chat/queryOtherStudents")//未添加成员
#define UrL_AddStudent                 UrL_MACRO(@"chat/addMembers")//添加成员
#define UrL_AddFriend                  UrL_MACRO(@"messageCenter/sendMakeFriendApply")//好友申请
#define UrL_SearchTeacher              UrL_MACRO(@"teacher/queryTeacherInfo")//教师账号查询
#define UrL_GetRongYunToken            UrL_MACRO(@"user/getRongYunToken")//获取融云token
#define UrL_UpdataTeacherInfo          UrL_MACRO(@"teacher/modifyTeacherInfoByTeacher")//修改教师信息
#define UrL_NoFriend                   UrL_MACRO(@"messageCenter/resolveMakeFriendApply")//拒绝好友申请
#define UrL_FriendMessageCenter        UrL_MACRO(@"messageCenter/queryMakeFriendApplyList")//好友申请查询
#define UrL_VideoVipIs                 UrL_MACRO(@"videoCourse/queryMyVideoVipInfo")//我的Vip信息
#define UrL_ALiPayOrder                UrL_MACRO(@"alipay/payOrder")//订单支付宝支付
#define UrL_AppReturnOrder             UrL_MACRO(@"order/applyReturnGood")//退货申请
#define UrL_OrderDetails               UrL_MACRO(@"order/queryOrderDetail")//订单详情
#define UrL_MyOrder                    UrL_MACRO(@"order/queryOrderListByCondition")//我的订单
#define UrL_AddGoodComment             UrL_MACRO(@"good/addGoodComment")//商品添加评论
#define UrL_AddOrderComment            UrL_MACRO(@"order/setOrderComment")//订单评论
#define UrL_OrderDelete                UrL_MACRO(@"order/deleteOrder")//订单删除
#define UrL_FeedBack                   UrL_MACRO(@"system/addFeedback")//意见反馈
#define UrL_MyAccount                  UrL_MACRO(@"useraccount/queryUserAccount")//我的账号
#define UrL_TeacherAnswer              UrL_MACRO(@"courseHomeworkIssue/replyStudentCourseHomeworkAnswer")//教师提交回复
#define UrL_WxinPay                    UrL_MACRO(@"wechatPay/payOrder")//微信支付
#define UrL_PriceVip                   UrL_MACRO(@"videoCourse/submitVideoVipOrderShowAdd")//Vip价格表
#define UrL_VideoPingLun               UrL_MACRO(@"videoCourse/addCourseComment")//视频添加评论
#define UrL_QRShouHuo                  UrL_MACRO(@"order/confirmReceive")//确认收货
#define UrL_NotApplyHomeWork           UrL_MACRO(@"courseHomeworkIssue/queryNotApplyListByHomeworkId")//未完成学生列表
#define UrL_ChatGroups                 UrL_MACRO(@"chat/addChatGroups")//创建群组
#define UrL_ChangeGroupsAdmin          UrL_MACRO(@"chat/updateChatGroupAdmin")//更换管理员
#define UrL_SystemMessage              UrL_MACRO(@"messageCenter/querySysMessageList")//系统推送列表


#pragma mark 导航条的高度
//导航条高度
#define kNavBarHeight 64.0
//标签栏的高度
#define kTabBarHeight 49.0
//导航条title的font
#define kNavTitleFont UIFont_size(18.0)
//标签栏item的font
#define kTabBarItemFont UIFont_size(11.0)
//选项卡的高度
#define tabsHeight 45.0
//预定义圆角数
#define kAppMainCornerRadius 6.0


#pragma mark 字体相关
//字体
#define UIFont_size(size) [UIFont systemFontOfSize:size]
#define UIFont_bold_Size(size) [UIFont boldSystemFontOfSize:size]


#pragma mark - Dev
//Log
#ifdef DEBUG
#define DLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(xx, ...)  ((void)0)
#endif

//屏幕比例
#define WidthScale [UIScreen mainScreen].bounds.size.width/375.0
#define HeightScale [UIScreen mainScreen].bounds.size.height/667.0

#pragma mark 颜色相关
//颜色
#define UICOLOR_FROM_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kAppBlackColor [UIColor blackColor]         //黑色
#define kAppGrayColor [UIColor grayColor]           //灰色
#define kAppDarkGrayColor [UIColor darkGrayColor]   //深灰色
#define kAppLightGrayColor [UIColor lightGrayColor] //浅灰色
#define kAppWhiteColor [UIColor whiteColor]         //白色
#define kAppRedColor [UIColor redColor]             //红色
#define kAppOrangeColor [UIColor orangeColor]       //橙色
#define kAppClearColor [UIColor clearColor]         //透明色
#define KAppBackBgColor UICOLOR_FROM_RGB(240,240,240,1)//主背景色
#define kAppBlueColor UICOLOR_FROM_RGB(29,121,164,1)
#define kAppDarkTextColor [UIColor darkTextColor]
#define kAppLightTextColor [UIColor lightTextColor]
#define kAppLineColor UICOLOR_FROM_RGB(200,201,201,1)//细线的颜色
#define kAppMainBgColor UICOLOR_FROM_RGB(236,237,239,1)
//#define kCBlueBgColor UICOLOR_FROM_RGB(65,105,225,1)
#define UICOLOR_FROM_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kViewBgColor UICOLOR_FROM_RGB(235,236,237,1)
#define kFontColor UICOLOR_FROM_RGB(62,176,193,1)
#define kFontBtnBgColor UICOLOR_FROM_RGB(254,219,10,1)
#define kSectionFontColor UICOLOR_FROM_RGB(79,76,76,1)
#define kOrderNumColor UICOLOR_FROM_RGB(62,176,193,1)
#define kYellowBtnBgColor UICOLOR_FROM_RGB(255,222,0,1)
#define kCyanBtnBgColor UICOLOR_FROM_RGB(62,176,193,1)



#endif /* Header_h */
