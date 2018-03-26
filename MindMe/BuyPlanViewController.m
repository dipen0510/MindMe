//
//  BuyPlanViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 17/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "BuyPlanViewController.h"
#import "PaymentViewController.h"

@interface BuyPlanViewController ()

@end

@implementation BuyPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self startGetSubscriptionsService];
    
}

- (void) setupInitialUI {
    
    _voucherApplyButton.layer.cornerRadius = 12.5;
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
    
    _goldMonthlyLabel.text = @"";
    _goldQuarterlyLabel.text = @"";
    _goldAnnualLabel.text = @"";
    _goldHalfAnnualLabel.text = @"";
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    _goldStaticLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    
    _couvherStaticLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
    _vouchertextField.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _voucherApplyButton.titleLabel.font = _goldMonthlySelectButton.titleLabel.font = _goldHalfYearlySelectButton.titleLabel.font = _goldQuarterlySelectButton.titleLabel.font = _goldYearlySelectButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
    _goldMonthlyLabel.font = _goldAnnualLabel.font = _goldQuarterlyLabel.font = _goldHalfAnnualLabel.font =  [UIFont fontWithName:@"Montserrat-Medium" size:(17.5/667)*kScreenHeight];
    
    _goldMonthlyStaticLabel.font = _goldAnnualStaticLabel.font = _goldQuarterlyStaticLabel.font = _goldHalfAnnualStaticLabel.font =  [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _infoLabel.font =  [UIFont fontWithName:@"Montserrat-Light" size:(16./667)*kScreenHeight];
    
}

- (void) setupUIAfterAPISuccess {
    
    for (NSDictionary* subsDict in subscriptionsArr) {
        
        if ([[subsDict valueForKey:@"plan_type"] containsString:@"GOLD"]) {
            
            if ([[subsDict valueForKey:@"short_description"] containsString:@"month"]) {
                _goldMonthlyLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                goldMonthlyDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
            }
            else if ([[subsDict valueForKey:@"short_description"] containsString:@"quarter"]) {
                _goldQuarterlyLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                goldQuarterlyDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
            }
            else if ([[subsDict valueForKey:@"short_description"] containsString:@"half"]) {
                _goldHalfAnnualLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                goldHalfAnnualDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
            }
            else if ([[subsDict valueForKey:@"short_description"] containsString:@"year"]) {
                _goldAnnualLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                goldAnnualDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
            }
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showPaymentSegue"]) {
        
        PaymentViewController* controller = (PaymentViewController *)[segue destinationViewController];
        controller.subscriptionDict = selectedSubscriptionDict;
        
    }
    
}

- (IBAction)backButtonTapped:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)selectButtonTapped:(id)sender {
    
    if (((UIButton *)sender).tag == 100) {
        selectedSubscriptionDict = goldMonthlyDict;
    }
    else if (((UIButton *)sender).tag == 101) {
        selectedSubscriptionDict = goldQuarterlyDict;
    }
    else if (((UIButton *)sender).tag == 102) {
        selectedSubscriptionDict = goldHalfAnnualDict;
    }
    else if (((UIButton *)sender).tag == 103) {
        selectedSubscriptionDict = goldAnnualDict;
    }
    
    [self performSegueWithIdentifier:@"showPaymentSegue" sender:nil];
    
}

- (IBAction)voucherApplyButtonTapped:(id)sender {
    
    [self.view endEditing:YES];
    [self startGetVouchersService];
    
}

#pragma mark - API Helpers

- (void) startGetSubscriptionsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Subscriptions"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetSubscriptions;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForSubscriptions]];
    
}

- (void) startGetVouchersService {
    
    [SVProgressHUD showWithStatus:@"Validating voucher"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetVouchers;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForVouchers]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetSubscriptions]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Subscriptions fetched successfully"];
        
        subscriptionsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
        [self setupUIAfterAPISuccess];
        
        
    }
    if ([requestServiceKey isEqualToString:GetVouchers]) {
        
        NSMutableArray* messageArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
        
        if (messageArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"Invalid voucher code"];
        }
        else {
            [SVProgressHUD showSuccessWithStatus:@"Voucher applied successfully"];
            selectedSubscriptionDict = [messageArr objectAtIndex:0];
            [self performSegueWithIdentifier:@"showPaymentSegue" sender:nil];
        }
        
    }
    
    
}


- (void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    
    [SVProgressHUD dismiss];
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                        otherButtonTitles: nil];
    
    if (![errorMsg isEqualToString:@""]) {
        [alert setMessage:errorMsg];
    }
    
    if ([errorMsg isEqualToString:NSLocalizedString(@"Verify your internet connection and try again", nil)]) {
        [alert setTitle:NSLocalizedString(@"Connection unsuccessful", nil)];
    }
    
    [alert show];
    
    return;
    
}




#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForSubscriptions {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForVouchers {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    [dict setObject:_vouchertextField.text forKey:@"voucharcode"];
    
    return dict;
    
}

@end
