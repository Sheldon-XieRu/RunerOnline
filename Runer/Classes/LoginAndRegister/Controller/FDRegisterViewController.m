//
//  FDRegisterViewController.m
//  Runer
//
//  Created by tarena on 16/5/10.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDRegisterViewController.h"
#import "FDleanCloudTool.h"
#import "FDUserInfo.h"
#import "MBProgressHUD+KR.h"
@interface FDRegisterViewController ()<FDSRegisterDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordField;
- (IBAction)retrieveBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;



@end

@implementation FDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addIcon];
}
#pragma mark -- 界面相关
- (void)addIcon{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    imageView.image = [UIImage imageNamed:@"mail"];
    imageView.contentMode = UIViewContentModeCenter;
    self.emailField.leftView = imageView;
    self.emailField.leftViewMode = UITextFieldViewModeAlways;
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    imageView.image = [UIImage imageNamed:@"lock"];
    imageView.contentMode = UIViewContentModeCenter;
    self.userPasswordField.leftView = imageView;
    self.userPasswordField.leftViewMode = UITextFieldViewModeAlways;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)retrieveBtnClick:(id)sender {
    NSString *userEmal = self.emailField.text;
    [FDUserInfo sharedFDUserInfo].userEmail = userEmal;
   //截取邮箱前面字符为用户名
    NSRange renge = [userEmal rangeOfString:@"@"];
    if (renge.length) {
        [FDUserInfo sharedFDUserInfo].userRegisterName = [userEmal substringToIndex:renge.location];
    }else{
        [MBProgressHUD showError:@"请输入正确的邮箱地址"];
    }
    
     NSLog(@"%@",[FDUserInfo sharedFDUserInfo].userRegisterName);
    [FDUserInfo sharedFDUserInfo].userRegisterPassword = self.userPasswordField.text;
    [[FDleanCloudTool sharedFDleanCloudTool] userRegister];
    [FDleanCloudTool sharedFDleanCloudTool].registerDelegate = self;
}

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)registerError{
        
     [MBProgressHUD showError:@"注册失败"];
    
}
-(void)registerSuccess{
    [MBProgressHUD showSuccess:@"注册成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)registerNetError{
    [MBProgressHUD showMessage:@"网络错误"];
    NSLog(@"网络错误");
}
@end
