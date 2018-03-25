//
//  PaymentViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "PaymentViewController.h"
#import <Stripe/Stripe.h>

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _cancelButton.layer.cornerRadius = 17;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    _cardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _monthTextField.keyboardType = UIKeyboardTypeNumberPad;
    _yearTextField.keyboardType = UIKeyboardTypeNumberPad;
    _cvvTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    /*if ([UIScreen mainScreen].bounds.size.height<667) {
        _monthTextField.font = _yearTextField.font = _cvvTextField.font = [UIFont fontWithName:@"VisbyRoundCF-Regular" size:10.0];
    }*/
    
    _cardNumberTextField.delegate = self;
    
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

- (IBAction)payButtonTapped:(id)sender {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        [self.view endEditing:YES];
        [self startCreatingStripeToken];
    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NSString*) isFormValid {
    if ([_cardNumberTextField.text isEqualToString:@""]) {
        return @"Please enter card number to proceed";
    }
    else if ([_cardNameTextField.text isEqualToString:@""]) {
        return @"Please enter card name to proceed";
    }
    else if ([_monthTextField.text isEqualToString:@""]) {
        return @"Please enter month to proceed";
    }
    else if ([_yearTextField.text isEqualToString:@""]) {
        return @"Please enter year to proceed";
    }
    else if ([_cvvTextField.text isEqualToString:@""]) {
        return @"Please enter CVV to proceed";
    }
    return nil;
}

#pragma mark - Payment Helpers

- (void) startCreatingStripeToken {
    
    [SVProgressHUD showWithStatus:@"Verifying card details"];
    
    STPCardParams *cardParams = [[STPCardParams alloc] init];
    cardParams.number = _cardNumberTextField.text;
    cardParams.expMonth = [_monthTextField.text intValue];
    cardParams.expYear = [_yearTextField.text intValue];
    cardParams.cvc = _cvvTextField.text;
    
    [[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken *token, NSError *error) {
        if (token == nil || error != nil) {
            // Present error to user...
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            return;
        }
        
        cardToken = token.tokenId;
        [self startCreatingCustomerService];
        
    }];
    
}

- (void) startCreatingCustomerService {
    
    [SVProgressHUD showWithStatus:@"Processing payment"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = StripeCustomerKey;
    manager.delegate = self;
    [manager startStripeAPIWithsData:[self prepareDictionaryForCreatingStripeCustomer]];
    
}

- (void) startStripeSubscriptionService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = StripeSubscriptionKey;
    manager.delegate = self;
    [manager startStripeAPIWithsData:[self prepareDictionaryForStripeSubscription]];
    
}

- (void) startPostSubscriptionReceiptService {
    
    [SVProgressHUD showWithStatus:@"Registering payment receipt"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = PostSubscriptionReceipt;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForRegisteringSubscriptionReceipt]];
    
}

- (void) startGetProfileDetailsService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetUserPersonalDetails;
    manager.delegate = nil;
    [manager startPOSTingFormDataForRefreshingUserToken:[self prepareDictionaryForGetProfileDetails]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:StripeCustomerKey]) {
        customerId = [responseData valueForKey:@"id"];
        [self startStripeSubscriptionService];
    }
    if ([requestServiceKey isEqualToString:StripeSubscriptionKey]) {
        subscriptionId = [responseData valueForKey:@"id"];
        [self startPostSubscriptionReceiptService];
    }
    if ([requestServiceKey isEqualToString:PostSubscriptionReceipt]) {
        [SVProgressHUD showSuccessWithStatus:@"Successfully Subscribed"];
        [self startGetProfileDetailsService];
        [self performSelector:@selector(changeScreenToAdvertControl) withObject:nil afterDelay:1.5];
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

- (NSMutableDictionary *) prepareDictionaryForCreatingStripeCustomer {
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetails"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[responseData valueForKey:@"user_email"] forKey:@"email"];
    [dict setObject:cardToken forKey:@"source"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForStripeSubscription {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* itemsDict = [[NSMutableDictionary alloc] init];
    
    [itemsDict setObject:[_subscriptionDict valueForKey:@"service_name"] forKey:@"plan"];
    
    [dict setObject:customerId forKey:@"customer"];
    [dict setObject:[[NSMutableArray alloc] initWithObjects:itemsDict,nil] forKey:@"items"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForRegisteringSubscriptionReceipt {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    [dict setObject:[_subscriptionDict valueForKey:@"id"] forKey:@"plan_id"];
    [dict setObject:subscriptionId forKey:@"sub_id"];
    [dict setObject:customerId forKey:@"ref_id"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForGetProfileDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _cardNumberTextField) {
        
        if ([textField.text stringByAppendingString:string].length > 16) {
            
            [_cardNameTextField becomeFirstResponder];
            return NO;
            
        }
        
    }
    
    return YES;
    
}

- (void) changeScreenToAdvertControl {
    [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
}

@end
