//
//  ViewController.m
//  Runer
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "ViewController.h"
#import <AVOSCloud.h>
#import "MBProgressHUD+KR.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void) test{
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    NSLog(@"你好:%@",currentUsername);
    
    [MBProgressHUD showSuccess:currentUsername];
    NSString *currentEmail = [AVUser currentUser].email; // 当前用户的邮箱
    NSLog(@"请牢记您的邮箱:%@",currentEmail);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
     [self.view.window setRootViewController: storyboard.instantiateInitialViewController];
    //[UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
    
//    [AVUser logOut];  //清除缓存用户对象
//    AVUser *currentUser = [AVUser currentUser];
    NSLog(@"退出登录");
}
@end
