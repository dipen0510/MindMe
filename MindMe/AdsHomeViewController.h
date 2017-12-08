//
//  AdsHomeViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsHomeViewController : UIViewController

- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)filterButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *favoritesView;
@property (weak, nonatomic) IBOutlet UIView *messagesView;
- (IBAction)carerTypeButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *carerTypeTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carerTypeTFLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carerTypeTFTopConstraint;

@end
