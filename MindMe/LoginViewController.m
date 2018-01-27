//
//  LoginViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
    }
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([[SharedClass sharedInstance] userId]) {
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

#pragma mark - Text Field Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField==_emailTextField && [textField.text isEqualToString:@"Email"]) {
        textField.text = @"";
    }
    else if (textField==_passwordTextField) {
        textField.text = @"";
    }
    
}

#pragma mark - API Helpers

- (void) startLoginService {
    
    [SVProgressHUD showWithStatus:@"Logging in"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = LoginServiceKey;
    manager.delegate = self;
    [manager startPOSTingFormData:[self prepareDictionaryForLoginUserDetails]];
    
}

- (void) startFBSignInService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = FBLoginServiceKey;
    manager.delegate = self;
    [manager startPOSTingFormData:[self prepareDictionaryForFBLoginUserDetails]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    
    if ([requestServiceKey isEqualToString:LoginServiceKey] || [requestServiceKey isEqualToString:FBLoginServiceKey]) {
        [[SharedClass sharedInstance] setIsEditProfileMenuButtonHidden:NO];
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

- (NSMutableDictionary *) prepareDictionaryForLoginUserDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_emailTextField.text forKey:@"username"];
    [dict setObject:_passwordTextField.text forKey:@"password"];
    [dict setObject:@"1" forKey:@"device"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [dict setObject:@"iOS" forKey:@"type"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForFBLoginUserDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[[FBLoginHelper sharedInstance] emailId] forKey:@"username"];
    [dict setObject:[[FBLoginHelper sharedInstance] socialId] forKey:@"facebook_id"];
    [dict setObject:@"1" forKey:@"device"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [dict setObject:@"iOS" forKey:@"type"];
    
    return dict;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonTapped:(id)sender {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        [self startLoginService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }
    
}

- (IBAction)fbLoginButtonTapped:(id)sender {
    
    if ([[FBLoginHelper sharedInstance] emailId]) {
        [SVProgressHUD showWithStatus:@"Logging in"];
        [self startFBSignInService];
    }
    else
    {
        [[FBLoginHelper sharedInstance] initiateFBLoginFromView:self withCompletionBlock:^(BOOL finished){
            if (finished) {
                    [SVProgressHUD showWithStatus:@"Logging in"];
                    [self startFBSignInService];
            }
        }];
    }
    
}

- (NSString*) isFormValid {
    if ([_emailTextField.text isEqualToString:@""]) {
        return @"Please enter email to proceed";
    }
    else if(![self validateEmailWithString:_emailTextField.text]) {
        return @"Please enter a valid email to proceed";
    }
    else if ([_passwordTextField.text isEqualToString:@""]) {
        return @"Please enter password to proceed";
    }
    return nil;
}

- (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"^[a-zA-Z0-9]+(_)?([-_+.][a-zA-Z0-9_]+)*\\@[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*\\.[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
