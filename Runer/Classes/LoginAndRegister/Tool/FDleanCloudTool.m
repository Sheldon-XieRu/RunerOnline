//
//  FDleanCloudTool.m
//  Runer
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDleanCloudTool.h"
#import <AVOSCloud.h>

@interface  FDleanCloudTool()


//**注册 */
- (void)userRegister;
/** 登陆*/
- (void)userLogin;

@end

@implementation FDleanCloudTool



- (void)userLogin{
    [AVUser logInWithUsernameInBackground:[FDUserInfo sharedFDUserInfo].userName password:[FDUserInfo sharedFDUserInfo].userpassword block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登陆成功");
             [self.loginDelegate loginSuccess];
        } else {
            NSLog(@"登陆失败%@",error);
            [self.loginDelegate loginFaild];
        }
    }];
}

- (void)userRegister{
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = [FDUserInfo sharedFDUserInfo].userName;// 设置用户名
    user.password =  [FDUserInfo sharedFDUserInfo].userpassword;// 设置密码
    user.email = [NSString stringWithFormat:@"%@@live.com",[FDUserInfo sharedFDUserInfo].userName];// 设置邮箱
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功
            NSLog(@"注册成功");
           
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
            NSLog(@"%@",error);
            [self.loginDelegate loginNetError];
        }
    }];
}
singleton_implementation(FDleanCloudTool)
@end
