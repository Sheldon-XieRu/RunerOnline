//
//  FDSinaViewController.m
//  Runer
//
//  Created by tarena on 16/5/11.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDSinaViewController.h"
#import <AVOSCloudSNS.h>
@interface FDSinaViewController ()
- (IBAction)backBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *oauthWebView;

@end

@implementation FDSinaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AVOSCloudSNS];
    
}

#pragma mark -- 三方认证
- (void)AVOSCloudSNS{
    
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"2871162928" andAppSecret:@"48251a10a8ec697289ed23faf7e0626c" andRedirectURI:@"https://api.weibo.com/oauth2/default.html"];
    
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            [self reloadInputViews];
        } else {
            NSString *accessToken = object[@"access_token"];
            NSString *username = object[@"username"];
            NSString *avatar = object[@"avatar"];
            NSDictionary *rawUser = object[@"raw-user"]; // 性别等第三方平台返回的用户信息
            //...
            NSLog(@"\naccessToken:%@\nusername:%@\navatar:%@\nrawUser:%@",accessToken,username,avatar,rawUser);
            
        }  
    } toPlatform:AVOSCloudSNSSinaWeibo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
