//
//  EditProfileViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 22/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)menuButtonTapped:(id)sender;

@end
