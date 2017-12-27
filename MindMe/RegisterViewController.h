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

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *legalLabel;


- (IBAction)careGiverButtonTapped:(id)sender;
- (IBAction)careNeededButtonTapped:(id)sender;
- (IBAction)signInButtonTapped:(id)sender;
- (IBAction)registerButtonTapped:(id)sender;
- (IBAction)fbRegisterButtonTapped:(id)sender;

@end
