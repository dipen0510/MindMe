//
//  EditProfileViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 22/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <DataSyncManagerDelegate, UITableViewDataSource, UITableViewDelegate> {
    UITextField* activeField;
}

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobTextField;
@property (weak, nonatomic) IBOutlet UITextField *eirCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *emailPromotionsButton;
@property (weak, nonatomic) IBOutlet UIButton *receiveEmailsButton;
@property (weak, nonatomic) IBOutlet UIButton *tncButton;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITableView *addressTblView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)maleButtonTapped:(id)sender;
- (IBAction)femaleButtonTapped:(id)sender;
- (IBAction)miscOptionButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;

@end
