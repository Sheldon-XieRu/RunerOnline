//
//  FDEditPofrofileViewController.m
//  Runer
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDEditPofrofileViewController.h"
#import <AVOSCloudSNS.h>
#import "FDUserInfo.h"
#import "FDleanCloudTool.h"
@interface FDEditPofrofileViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userAgeTextfield;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
- (IBAction)editUserImage:(id)sender;

- (IBAction)editMyProfileBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;

@end

@implementation FDEditPofrofileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.userImageView addGestureRecognizer:[[UIGestureRecognizer alloc]initWithTarget:self action:@selector(headImageViewTep)]];
//    self.userImageView.userInteractionEnabled = YES;
}
- (void)headImageViewTep{
    [self choolImage:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma MARK -- 照片选择方法一
-(void)choolImage:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType =type;
    picker.allowsEditing = YES;
    //设置代理
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.userImageView.image = image;
    [self updateUserImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark --照片选择方法二

- (void) headImageViewTap{
    NSLog(@"你敲我干啥?");
    // 打开相册 或者相机 选取图片
    UIActionSheet *sht = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册",nil];
    //<!---注意这个逆天的反过来的语法---->
    [sht showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) {
        NSLog(@"取消");
    }else if(1 == buttonIndex){
        NSLog(@"相册");
        UIImagePickerController *imageControl = [UIImagePickerController new];
        imageControl.delegate = self;
        imageControl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imageControl.allowsEditing = YES;
        [self presentViewController:imageControl animated:YES completion:nil];
        
    }else{
        NSLog(@"相机");
        //判断当前设备是否支持 相机打开
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imageControl = [UIImagePickerController new];
            imageControl.delegate = self;
            imageControl.sourceType = UIImagePickerControllerSourceTypeCamera;
            imageControl.allowsEditing = YES;
            [self presentViewController:imageControl animated:YES completion:nil];
        }
    }
}
#pragma mark --上传照片
- (void)updateUserImage:(UIImage *)image{
    NSData *imageData = UIImagePNGRepresentation(image);
   [FDUserInfo sharedFDUserInfo].userHeadImage = [[FDleanCloudTool sharedFDleanCloudTool]saveDataWith:imageData andFileName:@"headImage.png"];
    [FDUserInfo sharedFDUserInfo].userHeadImageData = imageData;
}
- (void)viewWillAppear:(BOOL)animated{
    self.userNameTextField.text = [AVUser currentUser].username;
    self.userEmailTextField.text = [AVUser currentUser].email;
    if ([AVUser currentUser][@"age"]) {
        self.userAgeTextfield.text = [AVUser currentUser][@"age"];
    }
    self.userImageView.image = [UIImage imageWithData:[FDUserInfo sharedFDUserInfo].userHeadImageData];
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

- (IBAction)editUserImage:(id)sender {
//    [self headImageViewTep];
    [self headImageViewTap];
}

- (IBAction)editMyProfileBtnClick:(id)sender {

    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [[AVUser currentUser] setObject:self.userEmailTextField.text forKey:@"email"];
        [[AVUser currentUser] setObject:self.userNameTextField.text forKey:@"username"];
   
        [[AVUser currentUser] setObject:self.userAgeTextfield.text forKey:@"age"];
        [[AVUser currentUser] saveInBackground];
     }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}
@end
