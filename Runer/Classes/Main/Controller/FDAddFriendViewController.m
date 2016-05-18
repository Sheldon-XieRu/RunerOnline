//
//  FDAddFriendViewController.m
//  Runer
//
//  Created by tarena on 16/5/13.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDAddFriendViewController.h"
#import <AVUser+SNS.h>
#import <AVOSCloud/AVOSCloud.h>
@interface FDAddFriendViewController ()
- (IBAction)delFriendField:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addFriendField;
- (IBAction)addfriendBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;

@end

@implementation FDAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)addfriendBtnClick:(id)sender {
    NSString *userObjectId = self.addFriendField.text;
    //关注
    [[AVUser currentUser] follow:userObjectId andCallback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"关注成功%@",error);
        }else{
            NSLog(@"关注失败%@",error);
        }
    }];

}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)delFriendField:(id)sender {
    NSString *userObjectId = self.addFriendField.text;
        [[AVUser currentUser] unfollow:userObjectId andCallback:^(BOOL succeeded, NSError *error) {
        }];
}
@end
