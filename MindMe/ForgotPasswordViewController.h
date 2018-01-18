//
//  ForgotPasswordViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/01/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController <DataSyncManagerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *resetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)resetPasswordButtonTapped:(id)sender;

@end
