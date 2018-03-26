//
//  RegisterViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    NSRange range = [self.legalLabel.text rangeOfString:NSLocalizedString(@"Terms of Services", nil)];
    [self.legalLabel addLinkToURL:[NSURL URLWithString:@"action://ToS"] withRange:range];
    NSRange range1 = [self.legalLabel.text rangeOfString:NSLocalizedString(@"Privacy Policy", nil)];
    [self.legalLabel addLinkToURL:[NSURL URLWithString:@"action://PP"] withRange:range1];
    self.legalLabel.delegate = self;
    
    _firstNameTextField.delegate = self;
    _lastNameTextField.delegate = self;
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    [_findACaregiverStaticLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(careGiverButtonTapped:)]];
    [_findACarejobStaticLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(careNeededButtonTapped:)]];
    
    _findACarejobStaticLabel.font =  _findACaregiverStaticLabel.font = _orStaticLabel.font = _fbButton.titleLabel.font = _signInLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(17.5/667)*kScreenHeight];
    
    _emailTextField.font = _passwordTextField.font = _firstNameTextField.font = _lastNameTextField.font = _alreadyHaveAccountStaticLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    
    _headerLabelTopConstraint.constant = (51./667) * kScreenHeight;
    _firstNameTopConstraint.constant = (32./667) * kScreenHeight;
    _lastNameTopConstraint.constant = (22./667) * kScreenHeight;
    _emailTopCOnstraint.constant = (22./667) * kScreenHeight;
    _pwdTopConstraint.constant = (22./667) * kScreenHeight;
    _optionsTopConstraint.constant = (30./667) * kScreenHeight;
    _signUpButtonTopConstraint.constant = (32./667.) * kScreenHeight;
    _orStaticLabelTopConstraint.constant = (10./667.) * kScreenHeight;
    _fbButtonTopConstraint.constant = (16./667.) * kScreenHeight;
    _legalLabelTopConstraint.constant = (16./667.) * kScreenHeight;
    
    if (kScreenWidth < 375) {
        _firstNameTopConstraint.constant = (25./667) * kScreenHeight;
        _signUpButtonTopConstraint.constant = (25./667.) * kScreenHeight;
        _legalLabelTopConstraint.constant = (10./667.) * kScreenHeight;
        _fbButtonTopConstraint.constant = (10./667.) * kScreenHeight;
    }
    
    [_backTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonTapped:)]];
    
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

- (IBAction)careGiverButtonTapped:(id)sender {
    
    _careGiverButton.selected = YES;
    _careNeededButton.selected = NO;
    
}

- (IBAction)careNeededButtonTapped:(id)sender {
    
    _careGiverButton.selected = NO;
    _careNeededButton.selected = YES;
    
}

- (IBAction)signInButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)registerButtonTapped:(id)sender {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        [self startRegisterUserDetailsService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }
    
}

- (IBAction)fbRegisterButtonTapped:(id)sender {
    
    if (!_careGiverButton.isSelected && !_careNeededButton.isSelected) {
        [SVProgressHUD showErrorWithStatus:@"Please select at least one Care option"];
    }
    else {
        if ([[FBLoginHelper sharedInstance] emailId]) {
            [SVProgressHUD showWithStatus:@"Registering"];
            [self startFBRegisterService];
        }
        else
        {
            [[FBLoginHelper sharedInstance] initiateFBLoginFromView:self withCompletionBlock:^(BOOL finished){
                if (finished) {
                    [SVProgressHUD showWithStatus:@"Registering"];
                    [self startFBRegisterService];
                }
            }];
        }
    }
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString*) isFormValid {
    if ([_firstNameTextField.text isEqualToString:@""]) {
        return @"Please enter first name to proceed";
    }
    else if ([_lastNameTextField.text isEqualToString:@""]) {
        return @"Please enter last name to proceed";
    }
    else if ([_emailTextField.text isEqualToString:@""]) {
        return @"Please enter email to proceed";
    }
    else if(![self validateEmailWithString:_emailTextField.text]) {
        return @"Please enter a valid email to proceed";
    }
    else if ([_passwordTextField.text isEqualToString:@""]) {
        return @"Please enter password to proceed";
    }
    else if (!_careGiverButton.isSelected && !_careNeededButton.isSelected) {
        return @"Please select at least one Care option";
    }
    return nil;
}

- (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"^[a-zA-Z0-9]+(_)?([-_+.][a-zA-Z0-9_]+)*\\@[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*\\.[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

#pragma mark - Text Field Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField==_emailTextField) {
        
        if ([textField.text isEqualToString:@"Email"]) {
            textField.text = @"";
        }
        
    }
    else {
        textField.text = @"";
    }
    
}

#pragma mark - TTTAttributedLabel Delegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    
    if ([[url scheme] hasPrefix:@"action"]) {
        
        if ([[url host] hasPrefix:@"ToS"]) {
            
            NSLog(@"ToS");
            [self performSegueWithIdentifier:@"showToSSegue" sender:nil];
            
        } else if ([[url host] hasPrefix:@"PP"]) {
            
            NSLog(@"PP");
            [self performSegueWithIdentifier:@"showPrivacySegue" sender:nil];
            
        }
        
    }
}

#pragma mark - API Helpers

- (void) startRegisterUserDetailsService {
    
    [SVProgressHUD showWithStatus:@"Registering"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = RegisterServiceKey;
    manager.delegate = self;
    [manager startPOSTingFormData:[self prepareDictionaryForRegisterUserDetails]];
    
}

- (void) startFBRegisterService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = FBRegisterServiceKey;
    manager.delegate = self;
    [manager startPOSTingFormData:[self prepareDictionaryForFBRegisterUserDetails]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    
    if ([requestServiceKey isEqualToString:RegisterServiceKey] || [requestServiceKey isEqualToString:FBRegisterServiceKey]) {
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
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

- (NSMutableDictionary *) prepareDictionaryForRegisterUserDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_emailTextField.text forKey:@"username"];
    [dict setObject:_passwordTextField.text forKey:@"password"];
    [dict setObject:@"1" forKey:@"device"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [dict setObject:@"iOS" forKey:@"type"];
    [dict setObject:_firstNameTextField.text forKey:@"first_name"];
    [dict setObject:_lastNameTextField.text forKey:@"last_name"];
    [dict setObject:@"0.0.0.0" forKey:@"user_ip"];
    
    if (_careNeededButton.isSelected) {
        [dict setObject:@"2" forKey:@"flag"];
    }
    else {
        [dict setObject:@"1" forKey:@"flag"];
    }
    
    
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForFBRegisterUserDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[[FBLoginHelper sharedInstance] emailId] forKey:@"username"];
    [dict setObject:[[FBLoginHelper sharedInstance] socialId] forKey:@"facebook_id"];
    [dict setObject:@"1" forKey:@"device"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [dict setObject:@"iOS" forKey:@"type"];
    [dict setObject:[[FBLoginHelper sharedInstance] firstName] forKey:@"first_name"];
    [dict setObject:[[FBLoginHelper sharedInstance] lastName] forKey:@"last_name"];
    [dict setObject:@"0.0.0.0" forKey:@"user_ip"];
    
    if (_careNeededButton.isSelected) {
        [dict setObject:@"2" forKey:@"flag"];
    }
    else {
        [dict setObject:@"1" forKey:@"flag"];
    }
    
    
    
    return dict;
    
}


@end
