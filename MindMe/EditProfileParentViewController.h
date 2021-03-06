//
//  EditProfileParentViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileParentViewController : UIViewController <DataSyncManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phonetextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *eirCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *receiveEmailButton;
@property (weak, nonatomic) IBOutlet UIButton *mailNotifButton;
@property (weak, nonatomic) IBOutlet UIButton *tncButton;
@property (weak, nonatomic) IBOutlet UIButton *receiveSMSButton;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITableView *addressTblView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UITextField *eircodeStaticLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityStaticLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *option1StaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *option2StaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *option3StaticLabel;
@property (weak, nonatomic) IBOutlet UITextField *regionStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *option4StaticLabel;

- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)miscOptionButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;

@end
