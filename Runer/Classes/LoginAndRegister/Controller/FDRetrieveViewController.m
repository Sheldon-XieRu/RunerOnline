//
//  FDRetrieveViewController.m
//  Runer
//
//  Created by tarena on 16/5/11.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDRetrieveViewController.h"
#import "FDleanCloudTool.h"
#import "MBProgressHUD+KR.h"
#import <AVOSCloud.h>
@interface FDRetrieveViewController ()<FDRetrieveDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
- (IBAction)retrieveBtnClick:(id)sender;
- (IBAction)backActionClick:(id)sender;

@end

@implementation FDRetrieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addIcon];
   
}
- (void)addIcon{
     UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail"]];
    imageView.frame = CGRectMake(0, 0, 50, 50);
    //    imageView.contentMode = UIViewContentModeCenter;
    self.mailTextField.leftView = imageView;
    self.mailTextField.leftViewMode = UITextFieldViewModeAlways;
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
//找回密码成功
- (void)retrievepasswordSucceed{
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"欢迎回来,请到邮箱:%@重置您的密码",[AVUser currentUser].username]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)retrieveBtnClick:(id)sender {
    [FDleanCloudTool sharedFDleanCloudTool].retrieveDelegate = self;
    [FDUserInfo sharedFDUserInfo].userEmail = self.mailTextField.text;
    [[FDleanCloudTool sharedFDleanCloudTool] userRetrievePassword];
}

- (IBAction)backActionClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)retrieveNetError{
    [MBProgressHUD showError:@"网络错误"];
    NSLog(@"网络错误");
    
}
//找回密码失败
-(void)retrievepasswordError{
    NSLog(@"找回密码失败");
}
@end
