//
//  RegisterViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface RegisterViewController : UIViewController <TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UIButton *careGiverButton;
@property (weak, nonatomic) IBOutlet UIButton *careNeededButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstNameLabelTopConstraint;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *legalLabel;


- (IBAction)careGiverButtonTapped:(id)sender;
- (IBAction)careNeededButtonTapped:(id)sender;
- (IBAction)signInButtonTapped:(id)sender;

@end
