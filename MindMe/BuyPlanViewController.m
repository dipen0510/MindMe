//
//  BuyPlanViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 17/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "BuyPlanViewController.h"

@interface BuyPlanViewController ()

@end

@implementation BuyPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _voucherApplyButton.layer.cornerRadius = 10.0;
    _voucherApplyButton.layer.masksToBounds = NO;
    
    _silverMonthlySelectButton.layer.cornerRadius = 12.0;
    _silverMonthlySelectButton.layer.masksToBounds = NO;
    _silverQuarterlySelectButton.layer.cornerRadius = 12.0;
    _silverQuarterlySelectButton.layer.masksToBounds = NO;
    _silverYearlySelectButton.layer.cornerRadius = 12.0;
    _silverYearlySelectButton.layer.masksToBounds = NO;
    
    _goldMonthlySelectButton.layer.cornerRadius = 12.0;
    _goldMonthlySelectButton.layer.masksToBounds = NO;
    _goldQuarterlySelectButton.layer.cornerRadius = 12.0;
    _goldQuarterlySelectButton.layer.masksToBounds = NO;
    _goldYearlySelectButton.layer.cornerRadius = 12.0;
    _goldYearlySelectButton.layer.masksToBounds = NO;
    
    _silverQuaretlyView.layer.cornerRadius = 5.0;
    _silverQuaretlyView.layer.masksToBounds = NO;
    _silverQuaretlyView.layer.borderWidth = 1.0;
    _silverQuaretlyView.layer.borderColor = _silverMonthlySelectButton.backgroundColor.CGColor;
    _silverMonthlyView.layer.cornerRadius = 5.0;
    _silverMonthlyView.layer.masksToBounds = NO;
    _silverMonthlyView.layer.borderWidth = 1.0;
    _silverMonthlyView.layer.borderColor = _silverMonthlySelectButton.backgroundColor.CGColor;
    _silverYearlyView.layer.cornerRadius = 5.0;
    _silverYearlyView.layer.masksToBounds = NO;
    _silverYearlyView.layer.borderWidth = 1.0;
    _silverYearlyView.layer.borderColor = _silverMonthlySelectButton.backgroundColor.CGColor;
    
    _goldQuarterlyView.layer.cornerRadius = 5.0;
    _goldQuarterlyView.layer.masksToBounds = NO;
    _goldQuarterlyView.layer.borderWidth = 1.0;
    _goldQuarterlyView.layer.borderColor = _goldMonthlySelectButton.backgroundColor.CGColor;
    _goldMonthlyView.layer.cornerRadius = 5.0;
    _goldMonthlyView.layer.masksToBounds = NO;
    _goldMonthlyView.layer.borderWidth = 1.0;
    _goldMonthlyView.layer.borderColor = _goldMonthlySelectButton.backgroundColor.CGColor;
    _goldYearlyView.layer.cornerRadius = 5.0;
    _goldYearlyView.layer.masksToBounds = NO;
    _goldYearlyView.layer.borderWidth = 1.0;
    _goldYearlyView.layer.borderColor = _goldMonthlySelectButton.backgroundColor.CGColor;
    
    
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
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)selectButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"showPaymentSegue" sender:nil];
}
@end