//
//  RegisterViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface RegisterViewController : UIViewController <TTTAttributedLabelDelegate, DataSyncManagerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *careGiverButton;
@property (weak, nonatomic) IBOutlet UIButton *careNeededButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstNameLabelTopConstraint;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UILabel *orStaticLabel;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UILabel *alreadyHaveAccountStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) IBOutlet UIView *backTapView;

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *legalLabel;
@property (weak, nonatomic) IBOutlet UILabel *findACaregiverStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *findACarejobStaticLabel;


- (IBAction)careGiverButtonTapped:(id)sender;
- (IBAction)careNeededButtonTapped:(id)sender;
- (IBAction)signInButtonTapped:(id)sender;
- (IBAction)registerButtonTapped:(id)sender;
- (IBAction)fbRegisterButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstNameTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastNameTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailTopCOnstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pwdTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionsTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signUpButtonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orStaticLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fbButtonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *legalLabelTopConstraint;
@end
