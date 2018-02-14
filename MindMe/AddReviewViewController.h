//
//  AddReviewViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 19/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddReviewViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate, DataSyncManagerDelegate> {
    int rating;
}

@property (strong, nonatomic) NSMutableDictionary* advertDict;

@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@property (weak, nonatomic) IBOutlet UIButton *postReviewButton;
@property (weak, nonatomic) IBOutlet UIButton *firstStar;
@property (weak, nonatomic) IBOutlet UIButton *secondStar;
@property (weak, nonatomic) IBOutlet UIButton *thordStar;
@property (weak, nonatomic) IBOutlet UIButton *fourthStar;
@property (weak, nonatomic) IBOutlet UIButton *fifthStar;
@property (weak, nonatomic) IBOutlet UILabel *reviewNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *reviewTitleTextField;

- (IBAction)firstStarButtonTapped:(id)sender;
- (IBAction)secondStarButtonTapped:(id)sender;
- (IBAction)thirStarButtonTapped:(id)sender;
- (IBAction)fourthStarButtonTapped:(id)sender;
- (IBAction)fifthStarButtonTapped:(id)sender;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)postReviewButtonTapped:(id)sender;

@end
