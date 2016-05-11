//
//  FDleanCloudTool.h
//  Runer
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "FDUserInfo.h"
#import "Singleton.h"

@protocol FDLoginDelegate <NSObject>
//登陆成功
- (void) loginSuccess;
//登陆失败
- (void) loginFaild;
//网路错误
- (void) loginNetError;
//注册成功
- (void) registerSuccess;
//注册失败
- (void) registerError;
//找回密码成功
- (void) registerpasswordSucceed;
//找回密码失败
- (void) registerpasswordError;
@end


@interface FDleanCloudTool : NSObject

@property (nonatomic,weak) id<FDLoginDelegate> loginDelegate;
singleton_interface(FDleanCloudTool)
//公开一个登陆接口
- (void) userLogin;
//公开一个注册接口
- (void) userRegister;
//公开一个修改密码接口
- (void) userRetrievePassword;
@end
