//
//  AdvertsViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mailLabel;
@property (weak, nonatomic) IBOutlet UILabel *upgradedLabel;
@property (weak, nonatomic) IBOutlet UILabel *advertLabel;
@property (weak, nonatomic) IBOutlet UIButton *createAdvertButton;

- (IBAction)menuButtonTapped:(id)sender;

@end
