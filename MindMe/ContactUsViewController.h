//
//  ContactUsViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 08/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController <UITextFieldDelegate, DataSyncManagerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *enquiryTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (weak, nonatomic) IBOutlet UITextView *enquireyDescTextView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)menuButtonTapped:(id)sender;

@end
