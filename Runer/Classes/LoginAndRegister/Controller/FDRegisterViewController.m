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
@interface FDRegisterViewController ()<FDLoginDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)retrieveBtnClick:(id)sender;

@end

@implementation FDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addIcon];
}
#pragma mark -- 界面相关
- (void)addIcon{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail"]];
    imageView.frame = CGRectMake(0, 0, 50, 50);
//    imageView.contentMode = UIViewContentModeCenter;
    self.emailField.leftView = imageView;
    self.emailField.leftViewMode = UITextFieldViewModeAlways;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)retrieveBtnClick:(id)sender {
    [FDUserInfo sharedFDUserInfo].userEmail = self.emailField.text;
    
    [[FDleanCloudTool sharedFDleanCloudTool] userRetrievePassword];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
