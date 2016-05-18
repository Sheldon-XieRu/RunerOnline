//
//  FDMyProfileViewController.m
//  Runer
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDMyProfileViewController.h"
#import "FDUserInfo.h"
#import "FDleanCloudTool.h"
#import <AVOSCloud.h>
#import <AVUser+SNS.h>
@interface FDMyProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;

- (IBAction)backBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *myprofileBackgroundImage;

- (IBAction)exitBtnClick:(id)sender;

@end

@implementation FDMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    self.userNameLabel.text = [AVUser currentUser].username;
    self.userEmailLabel.text = [AVUser currentUser].email;
    self.userAgeLabel.text = [AVUser currentUser][@"age"];
    NSData *data = [[FDleanCloudTool sharedFDleanCloudTool]getDataWithUrl:[FDUserInfo sharedFDUserInfo].userHeadImageUrl];

    if ([FDUserInfo sharedFDUserInfo].userHeadImageData) {
      UIImage *headImage = [UIImage imageWithData:[FDUserInfo sharedFDUserInfo].userHeadImageData];
        self.userImageView.image =headImage;
        self.myprofileBackgroundImage.image = headImage;
    }else if([UIImage imageWithData:data]){
        UIImage *headImage = [UIImage imageWithData:data];
        self.userImageView.image =headImage;
        self.myprofileBackgroundImage.image = headImage;
    }else{
        self.userImageView.image = [UIImage imageNamed:@"瓦力"];
    }
    
    
    
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

- (IBAction)exitBtnClick:(id)sender {
        [AVUser logOut];  //清除缓存用户对象
        AVUser *currentUser = [AVUser currentUser];
    NSLog(@"%@",currentUser);
    //清空用户头像数据
    [FDUserInfo sharedFDUserInfo].userHeadImageData = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
}
@end
