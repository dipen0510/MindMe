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
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *forgetPasswordStaticLabel;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UILabel *orStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *dontHaveAccountStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *signUplabel;
@property (weak, nonatomic) IBOutlet UIView *backButtonTapView;

- (IBAction)loginButtonTapped:(id)sender;
- (IBAction)fbLoginButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailImgTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailTFTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonTopConstraint;

@end
