//
//  FDSportViewController.m
//  Runer
//
//  Created by tarena on 16/5/18.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDSportViewController.h"
#import "BMapKit.h"
@interface FDSportViewController ()
@property (nonatomic, strong) BMKMapView *mapView;
@end

@implementation FDSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [BMKMapView new];
    self.mapView.frame = self.view.bounds;
    [self.view insertSubview:self.mapView atIndex:0];
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
