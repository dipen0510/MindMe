//
//  PhoneVerificationViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/05/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneVerificationViewController : UIViewController<DataSyncManagerDelegate, UITextFieldDelegate> {
    
    NSMutableArray* phoneArr;
    NSMutableArray* codeArr;
    
    NSString* selectedPrefix;
    
}

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *subHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *isdCodesLabel;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UIView *enterMobileContentView;
@property (weak, nonatomic) IBOutlet UIButton *sendSmsButton;
@property (weak, nonatomic) IBOutlet UIView *enterCodeContentView;
@property (weak, nonatomic) IBOutlet UITextField *enterCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *validateAccountButton;
@property (weak, nonatomic) IBOutlet UIImageView *codeSuccessImgView;
@property (weak, nonatomic) IBOutlet UILabel *codeSuccessLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeSuccessMobileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *accountValidatedImgView;
@property (weak, nonatomic) IBOutlet UILabel *accountValidatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountValidatedSuccessfullyLabel;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)sendSmsButtonTapped:(id)sender;
- (IBAction)validateAccountButtonTapped:(id)sender;


@end
