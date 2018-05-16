//
//  PhoneVerificationViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/05/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "PhoneVerificationViewController.h"

@interface PhoneVerificationViewController ()

@end

@implementation PhoneVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(18./667)*kScreenHeight];
    _subHeaderLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(17./667)*kScreenHeight];
    
    _isdCodesLabel.font = _mobileNumberTextField.font = _enterCodeTextField.font = [UIFont fontWithName:@"Montserrat-Regular" size:(14./667)*kScreenHeight];
    
    _enterCodeContentView.layer.cornerRadius = _enterMobileContentView.layer.cornerRadius = 22.5;
    _enterCodeContentView.layer.masksToBounds = _enterMobileContentView.layer.masksToBounds = YES;
    
    
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

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendSmsButtonTapped:(id)sender {
}

- (IBAction)validateAccountButtonTapped:(id)sender {
}
@end
