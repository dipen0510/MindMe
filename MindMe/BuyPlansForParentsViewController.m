//
//  BuyPlansForParentsViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "BuyPlansForParentsViewController.h"
#import "PaymentViewController.h"

@interface BuyPlansForParentsViewController ()

@end

@implementation BuyPlansForParentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self startGetSubscriptionsService];
    
}

- (void) setupInitialUI {
    
    _voucherApplyButton.layer.cornerRadius = 12.5;
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
    
    _goldMonthlyLabel.text = @"";
    _goldQuarterlyLabel.text = @"";
    _goldAnnualLabel.text = @"";
    _silverMonthlyLabel.text = @"";
    _silverQuarterlyLabel.text = @"";
    _silverAnnualLabel.text = @"";
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(17./667)*kScreenHeight];
    _goldStaticLabel.font = _silverStaticLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(19./667)*kScreenHeight];
    
    _couvherStaticLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(15./667)*kScreenHeight];
    
    _vouchertextField.font = [UIFont fontWithName:@"Montserrat-Light" size:(15./667)*kScreenHeight];
    
    _voucherApplyButton.titleLabel.font = _goldMonthlySelectButton.titleLabel.font = _goldQuarterlySelectButton.titleLabel.font = _goldYearlySelectButton.titleLabel.font = _silverMonthlySelectButton.titleLabel.font = _silverQuarterlySelectButton.titleLabel.font = _silverYearlySelectButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(14./667)*kScreenHeight];
    
    _goldMonthlyLabel.font = _goldAnnualLabel.font = _goldQuarterlyLabel.font = _silverMonthlyLabel.font = _silverQuarterlyLabel.font = _silverAnnualLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(15./667)*kScreenHeight];
    
    _goldMonthlyStaticLabel.font = _goldAnnualStaticLabel.font = _goldQuarterlyStaticLabel.font = _silverMonthlyStaticLabel.font = _silverQuarterlyStaticLabel.font = _silverAnnualStaticLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(15./667)*kScreenHeight];
    
    _infoLabel1.font = _infoLabel2.font =  [UIFont fontWithName:@"Montserrat-Light" size:(12./667)*kScreenHeight];
    
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
            else if ([[subsDict valueForKey:@"short_description"] containsString:@"year"]) {
                _goldAnnualLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                goldAnnualDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
            }
            
        }
        else {
            
            if ([[subsDict valueForKey:@"short_description"] containsString:@"month"]) {
                _silverMonthlyLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                silverMonthlyDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
            }
            else if ([[subsDict valueForKey:@"short_description"] containsString:@"quarter"]) {
                _silverQuarterlyLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                silverQuarterlyDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
            }
            else if ([[subsDict valueForKey:@"short_description"] containsString:@"year"]) {
                _silverAnnualLabel.text = [NSString stringWithFormat:@"€%@",[subsDict valueForKey:@"price_to_charge"]];
                silverAnnualDict = [[NSMutableDictionary alloc] initWithDictionary:subsDict];
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
    [self.sideMenuController showLeftViewAnimated];
}

- (IBAction)selectButtonTapped:(id)sender {
    
    if (((UIButton *)sender).tag == 100) {
        selectedSubscriptionDict = silverMonthlyDict;
    }
    else if (((UIButton *)sender).tag == 101) {
        selectedSubscriptionDict = silverQuarterlyDict;
    }
    else if (((UIButton *)sender).tag == 102) {
        selectedSubscriptionDict = silverAnnualDict;
    }
    else if (((UIButton *)sender).tag == 103) {
        selectedSubscriptionDict = goldMonthlyDict;
    }
    else if (((UIButton *)sender).tag == 104) {
        selectedSubscriptionDict = goldQuarterlyDict;
    }
    else if (((UIButton *)sender).tag == 105) {
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
