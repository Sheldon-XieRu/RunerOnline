//
//  FDRetrieveViewController.m
//  Runer
//
//  Created by tarena on 16/5/11.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDRetrieveViewController.h"

@interface FDRetrieveViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
- (IBAction)retrieveBtnClick:(id)sender;

@end

@implementation FDRetrieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)retrieveBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
