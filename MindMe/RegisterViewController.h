//
//  RegisterViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *careGiverButton;
@property (weak, nonatomic) IBOutlet UIButton *careNeededButton;
@property (weak, nonatomic) IBOutlet UIButton *tncButton;


- (IBAction)careGiverButtonTapped:(id)sender;
- (IBAction)careNeededButtonTapped:(id)sender;
- (IBAction)tncButtonTapped:(id)sender;

@end
