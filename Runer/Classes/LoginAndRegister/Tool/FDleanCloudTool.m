//
//  FDleanCloudTool.m
//  Runer
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDleanCloudTool.h"
#import <AVOSCloud.h>
#import <AVOSCloudSNS.h>
#import "MBProgressHUD+KR.h"
#import <LeanCloudSocial/AVUser+SNS.h>
@interface  FDleanCloudTool()
/**
 *  公开登陆接口
 */
- (void) userLogin;
/**
 *  公开注册接口
 */
- (void) userRegister;
/**
 *  公开找回密码接口
 */
- (void) userRetrievePassword;
/**
 *  公开三方微博登录
 */
- (void) sinaAutho;
/**
 *  公开三方qq登录
 */
- (void) TencentAutho;
@end

@implementation FDleanCloudTool

singleton_implementation(FDleanCloudTool)

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
    user.username = [FDUserInfo sharedFDUserInfo].userRegisterName;// 设置用户名
    user.password =  [FDUserInfo sharedFDUserInfo].userRegisterPassword;// 设置密码
    user.email = [FDUserInfo sharedFDUserInfo].userEmail;// 设置邮箱
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功
            NSLog(@"注册成功");
            if ([FDUserInfo sharedFDUserInfo].sinaLogin) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
            }
            //上传头像
            [self uploadImage];
            
            [self.registerDelegate registerSuccess];
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
            if ([FDUserInfo sharedFDUserInfo].sinaLogin) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
            }
            NSLog(@"%@注册失败",error);
            [self.registerDelegate registerError];
        }
    }];
    
    /*
    //准备头像数据
    NSData *data = [@"我的工作经历" dataUsingEncoding:NSUTF8StringEncoding];
    AVFile *file = [AVFile fileWithName:@"resume.txt" data:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //返回一个唯一的 Url 地址
        NSLog(@"test======%@",file.url);
    }];
    */
     
    
}
- (void)uploadImage{
    //================//上传头像
    UIImage *image = [UIImage imageNamed:@"瓦力"];
    NSData *headData = UIImagePNGRepresentation(image);
    AVFile *headImage = [AVFile fileWithName:@"headImage.png" data:headData];
    [headImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"头像地址%@",headImage.url);
    }];
    //上传进度
    [headImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // 成功或失败处理...
    } progressBlock:^(NSInteger percentDone) {
        // 上传进度数据，percentDone 介于 0 和 100。
        [MBProgressHUD showMessage:@"上传头像中..."];
        NSLog(@"%ld",(long)percentDone);
    }];
    //下载进度
    [headImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // data 就是文件的数据流
    } progressBlock:^(NSInteger percentDone) {
        //下载的进度数据，percentDone 介于 0 和 100。
    }];
}
- (void) userRetrievePassword{
    [AVUser requestPasswordResetForEmailInBackground:[NSString stringWithFormat:@"%@",[FDUserInfo sharedFDUserInfo].userEmail] block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showMessage:@"正在发送邮件"];
            NSLog(@"邮件已发送");
            [self.retrieveDelegate retrievepasswordSucceed];
        } else {
            [self.retrieveDelegate retrievepasswordError];
            [MBProgressHUD showError:@"邮箱地址错误"];
        }
    }];
}


#pragma mark -- 三方认证
- (void)sinaAutho{
        [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"2871162928" andAppSecret:@"48251a10a8ec697289ed23faf7e0626c" andRedirectURI:@"https://api.weibo.com/oauth2/default.html"];
        [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
            if (error) {
                [MBProgressHUD showError:@"认证失败"];
            } else {
                NSString *accessToken = object[@"access_token"];
                NSString *username = object[@"username"];
                NSString *avatar = object[@"avatar"];
                NSDictionary *rawUser = object[@"raw-user"]; // 性别等第三方平台返回的用户信息
                //...
                NSLog(@"\naccessToken:%@\nusername:%@\navatar:%@\nrawUser:%@",accessToken,username,avatar,rawUser);
                NSLog(@"%@",object);
                
<<<<<<< Updated upstream
                [FDUserInfo sharedFDUserInfo].userRegisterName = username;
                [FDUserInfo sharedFDUserInfo].userRegisterPassword =   accessToken;
                [FDUserInfo sharedFDUserInfo].userRegister = YES;
                [FDUserInfo sharedFDUserInfo].sinaToken = accessToken;
                [FDUserInfo sharedFDUserInfo].sinaLogin = YES;
                [self userRegister];
                
            }
        } toPlatform:AVOSCloudSNSSinaWeibo];
=======
                [AVUser loginWithAuthData:rawUser platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                    if (error) {
                        //关联失败
                        NSLog(@"三方登陆关联失败");
                    }else{
                        //登陆成功
                        [self.registerDelegate registerSuccess];
                    }
                }];
            }
        } toPlatform:AVOSCloudSNSSinaWeibo];
    
>>>>>>> Stashed changes
}
- (void) TencentAutho{
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ
                     withAppKey:@"2871162928" andAppSecret:@"48251a10a8ec697289ed23faf7e0626c" andRedirectURI:@"https://api.weibo.com/oauth2/default.html"];
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            
        } else {
            NSString *accessToken = object[@"access_token"];
            NSString *username = object[@"username"];
            NSString *avatar = object[@"avatar"];
            NSDictionary *rawUser = object[@"raw-user"]; // 性别等第三方平台返回的用户信息
            //...
            NSLog(@"\naccessToken:%@\nusername:%@\navatar:%@\nrawUser:%@",accessToken,username,avatar,rawUser);
            
        }
    } toPlatform:AVOSCloudSNSQQ];
}

//存储数据
- (void)saveDataWith:(id)object forKey:(NSString *)str{
    [[AVUser currentUser] setObject:object forKey:str];
    [[AVUser currentUser] saveInBackground];
}
//读取数据
@end
