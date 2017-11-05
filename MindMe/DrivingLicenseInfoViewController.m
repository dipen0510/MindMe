//
//  DrivingLicenseInfoViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 05/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "DrivingLicenseInfoViewController.h"

@interface DrivingLicenseInfoViewController ()

@end

@implementation DrivingLicenseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _contentView.layer.cornerRadius = 5.0;
    _contentView.layer.masksToBounds = YES;
    
    [self.bgTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDrivingLicenseInfo:)]];
    self.bgTapView.userInteractionEnabled = YES;
    
}

- (void) hideDrivingLicenseInfo:(id)sender {
    
    [self.view removeFromSuperview];
    
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
