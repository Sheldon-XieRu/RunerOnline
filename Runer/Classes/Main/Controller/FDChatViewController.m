//
//  FDChatViewController.m
//  Runer
//
//  Created by tarena on 16/5/17.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDChatViewController.h"
#import "FDMeTableViewCell.h"
#import "FDOtherTableViewCell.h"
@interface FDChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FDChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FDOtherTableViewCell *meCell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
    return meCell;
}
@end
