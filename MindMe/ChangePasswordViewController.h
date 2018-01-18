//
//  ChangePasswordViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 10/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController <DataSyncManagerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *resetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *currentPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *nPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmNPwdTextField;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)resetPwdButtonTapped:(id)sender;

@end
