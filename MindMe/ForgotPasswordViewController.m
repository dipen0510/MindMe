//
//  ForgotPasswordViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/01/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _resetPasswordButton.layer.cornerRadius = 21;
    _resetPasswordButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 21;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    _emailTextField.delegate = self;
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resetPasswordButtonTapped:(id)sender {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        [self startForgotPasswordService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

#pragma mark - Text Field Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField==_emailTextField && [textField.text isEqualToString:@"Email"]) {
        textField.text = @"";
    }
    
}

#pragma mark - API Helpers

- (void) startForgotPasswordService {
    
    [SVProgressHUD showWithStatus:@"Resetting password"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = ForgotPasswordKey;
    manager.delegate = self;
    [manager startPOSTingFormData:[self prepareDictionaryForForgotPassword]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD showSuccessWithStatus:@"An email has been sent with new password"];
    
    if ([requestServiceKey isEqualToString:ForgotPasswordKey]) {
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

- (NSMutableDictionary *) prepareDictionaryForForgotPassword {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_emailTextField.text forKey:@"email"];
    
    return dict;
    
}

- (NSString*) isFormValid {
    if ([_emailTextField.text isEqualToString:@""]) {
        return @"Please enter email to proceed";
    }
    else if(![self validateEmailWithString:_emailTextField.text]) {
        return @"Please enter a valid email to proceed";
    }
    return nil;
}

- (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"^[a-zA-Z0-9]+(_)?([-_+.][a-zA-Z0-9_]+)*\\@[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*\\.[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end