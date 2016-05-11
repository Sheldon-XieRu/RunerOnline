//
//  FDViewController.m
//  Runer
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDViewController.h"
#import "FDUserInfo.h"
#import <AVOSCloud.h>
#import "FDleanCloudTool.h"
#import "MBProgressHUD+KR.h"
@interface FDViewController ()<FDLoginDelegate>
/**
 *  用户名字段
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
/**
 *  用户密码字段
 */
@property (weak, nonatomic) IBOutlet UITextField *userPasswordField;
/**
 *  登录按钮被点击
 */
- (IBAction)loginBtnClick:(id)sender;
/**
 *  注册按钮被点击
 */
- (IBAction)registerBtnClick:(id)sender;
/**
 *  sinaAhto点击
 */
- (IBAction)sinaAthoBtnClick:(id)sender;

@end

@implementation FDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加输入框左边的额ico
    [self addUserIcon];
    
    }

#pragma mark -- 界面视图相关
- (void)addUserIcon{
    UIImageView *leftVN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    leftVN.frame = CGRectMake(0, 0, 55, 20);
    leftVN.contentMode = UIViewContentModeCenter;
    self.userNameField.leftView = leftVN;
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIImageView *leftVP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    leftVP.frame = CGRectMake(0, 0, 55, 20);
    leftVP.contentMode = UIViewContentModeCenter;
    self.userPasswordField.leftView = leftVP;
    self.userPasswordField.leftViewMode = UITextFieldViewModeAlways;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnClick:(id)sender {
    [FDUserInfo sharedFDUserInfo].userName = self.userNameField.text;
    [FDUserInfo sharedFDUserInfo].userpassword = self.userPasswordField.text;
    //设置登陆状态代理
    [FDleanCloudTool sharedFDleanCloudTool].loginDelegate = self;
    if (self.userNameField.text.length == 0 || self.userPasswordField.text.length == 0) {
        [MBProgressHUD showError:@"请输入用户名和密码"];
    }else{
    //登陆
    [[FDleanCloudTool sharedFDleanCloudTool]userLogin];
    }
}
//注册按钮
- (IBAction)registerBtnClick:(id)sender {
   
}
#pragma mark -- KRLoginDelegate
- (void)loginSuccess{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
    
}

- (void)loginFaild{
    NSLog(@"登录失败");
}
-(void)loginNetError{
    NSLog(@"网络错误");
}
-(void)dealloc{
    NSLog(@"登陆窗户消失");
}

- (IBAction)sinaAthoBtnClick:(id)sender {
    [[FDleanCloudTool sharedFDleanCloudTool]sinaAutho];
}
@end
