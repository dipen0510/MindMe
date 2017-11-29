//
//  BuyPlansForParentsViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "BuyPlansForParentsViewController.h"

@interface BuyPlansForParentsViewController ()

@end

@implementation BuyPlansForParentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _voucherApplyButton.layer.cornerRadius = 10.0;
    _voucherApplyButton.layer.masksToBounds = NO;
    
    _goldMonthlySelectButton.layer.cornerRadius = 12.0;
    _goldMonthlySelectButton.layer.masksToBounds = NO;
    _goldQuarterlySelectButton.layer.cornerRadius = 12.0;
    _goldQuarterlySelectButton.layer.masksToBounds = NO;
    _goldYearlySelectButton.layer.cornerRadius = 12.0;
    _goldYearlySelectButton.layer.masksToBounds = NO;
    _goldHalfYearlySelectButton.layer.cornerRadius = 12.0;
    _goldHalfYearlySelectButton.layer.masksToBounds = NO;
    
    
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
    _goldhalfYearlyView.layer.cornerRadius = 5.0;
    _goldhalfYearlyView.layer.masksToBounds = NO;
    _goldhalfYearlyView.layer.borderWidth = 1.0;
    _goldhalfYearlyView.layer.borderColor = _goldMonthlySelectButton.backgroundColor.CGColor;
    
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
    [self.sideMenuController showLeftViewAnimated];
}

- (IBAction)selectButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"showPaymentSegue" sender:nil];
}

@end
