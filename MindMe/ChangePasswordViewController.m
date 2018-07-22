//
//  ChangePasswordViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 10/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _resetPasswordButton.layer.cornerRadius = (21./667)*kScreenHeight;
    _resetPasswordButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = (21./667)*kScreenHeight;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    _currentPwdTextField.delegate = self;
    _nPwdTextField.delegate = self;
    _confirmNPwdTextField.delegate = self;

    _currentPwdTextField.secureTextEntry = NO;
    _nPwdTextField.secureTextEntry = NO;
    _confirmNPwdTextField.secureTextEntry = NO;
    
    _resetPasswordButton.titleLabel.font = _cancelButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(17.5/667)*kScreenHeight];
    
    _currentPwdTextField.font = _nPwdTextField.font = _confirmNPwdTextField.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    _infoLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    
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

- (IBAction)cancelButtonTapped:(id)sender {
    if ([[SharedClass sharedInstance] isChangePasswordOpenedFromSideMenu]) {
        [[SharedClass sharedInstance] setIsChangePasswordOpenedFromSideMenu:NO];
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)resetPwdButtonTapped:(id)sender {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        [self startChangePasswordService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (NSString*) isFormValid {
    if ([_currentPwdTextField.text isEqualToString:@""]) {
        return @"Please enter current password to proceed";
    }
    else if ([_nPwdTextField.text isEqualToString:@""]) {
        return @"Please enter new password to proceed";
    }
    else if ([_confirmNPwdTextField.text isEqualToString:@""]) {
        return @"Please enter confirm new password to proceed";
    }
    else if(![_nPwdTextField.text isEqualToString:_confirmNPwdTextField.text]) {
        return @"New password and confirm new password should be same";
    }
    else if (_nPwdTextField.text.length < 5) {
        return @"Please enter at least five characters for new password to proceed";
    }
    return nil;
}

- (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"^[a-zA-Z0-9]+(_)?([-_+.][a-zA-Z0-9_]+)*\\@[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*\\.[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark - API Helpers

- (void) startChangePasswordService {
    
    [SVProgressHUD showWithStatus:@"Changing password"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = ChangePasswordKey;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForChangePassword]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD showSuccessWithStatus:@"Password changed successfully"];
    
    if ([requestServiceKey isEqualToString:ChangePasswordKey]) {
        [self cancelButtonTapped:nil];
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

- (NSMutableDictionary *) prepareDictionaryForChangePassword {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_currentPwdTextField.text forKey:@"current_pwd"];
    [dict setObject:_nPwdTextField.text forKey:@"new_pwd"];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

#pragma mark - Text Field Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.text = @"";
    textField.secureTextEntry = YES;
    
}

@end
