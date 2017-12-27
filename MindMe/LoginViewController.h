//
//  LoginViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <DataSyncManagerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *joinUsButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;

- (IBAction)loginButtonTapped:(id)sender;
- (IBAction)fbLoginButtonTapped:(id)sender;

@end
