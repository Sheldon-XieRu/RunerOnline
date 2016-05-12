//
//  FDMyProfileViewController.m
//  Runer
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDMyProfileViewController.h"
#import <AVUser+SNS.h>
@interface FDMyProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;

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

@end
