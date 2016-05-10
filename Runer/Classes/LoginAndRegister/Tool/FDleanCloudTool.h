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

@interface FDleanCloudTool : NSObject

@property (nonatomic,weak) id<FDLoginDelegate> loginDelegate;
singleton_interface(FDleanCloudTool)
//公开一个登陆接口
- (void) userLogin;
- (void) userRegister;
@end
