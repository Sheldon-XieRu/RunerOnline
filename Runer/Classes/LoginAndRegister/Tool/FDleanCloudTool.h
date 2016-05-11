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
@end

@protocol FDSRegisterDelegate <NSObject>
//注册成功
- (void) registerSuccess;
//注册失败
- (void) registerError;
//网路错误
- (void) registerNetError;
@end

@protocol FDRetrieveDelegate <NSObject>
//找回密码成功
- (void) retrievepasswordSucceed;
//找回密码失败
- (void) retrievepasswordError;
//网路错误
- (void) retrieveNetError;
@end

@interface FDleanCloudTool : NSObject

@property (nonatomic,weak) id<FDLoginDelegate> loginDelegate;
@property (nonatomic,weak) id<FDSRegisterDelegate> registerDelegate;
@property (nonatomic,weak) id<FDRetrieveDelegate> retrieveDelegate;

singleton_interface(FDleanCloudTool)
/**
 *  公开登陆接口
 */
- (void) userLogin;
/**
 *  公开注册接口
 */
- (void) userRegister;
/**
 *  公开修改密码接口
 */
- (void) userRetrievePassword;
/**
 *  公开三方登录
 */
- (void) sinaAutho;
@end
