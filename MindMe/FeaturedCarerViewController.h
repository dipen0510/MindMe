//
//  FeaturedCarerViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedCarerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *becomeFeaturedButton;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;

- (IBAction)menuButtonTapped:(id)sender;

@end
