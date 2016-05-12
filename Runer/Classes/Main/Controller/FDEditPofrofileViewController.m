//
//  FDEditPofrofileViewController.m
//  Runer
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDEditPofrofileViewController.h"
#import <AVOSCloudSNS.h>
@interface FDEditPofrofileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userAgeTextfield;

- (IBAction)editMyProfileBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;

@end

@implementation FDEditPofrofileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    self.userNameTextField.text = [AVUser currentUser].username;
    self.userEmailTextField.text = [AVUser currentUser].email;
    if ([AVUser currentUser][@"age"]) {
        self.userAgeTextfield.text = [AVUser currentUser][@"age"];
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

- (IBAction)editMyProfileBtnClick:(id)sender {

    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [[AVUser currentUser] setObject:self.userEmailTextField.text forKey:@"eamil"];
        [[AVUser currentUser] saveInBackground];
    }];
    [[AVUser currentUser] setObject:self.userAgeTextfield.text forKey:@"age"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
