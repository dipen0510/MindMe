//
//  AdsDetailViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 09/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    NSMutableArray* availabilityArr;
    
}

@property (weak, nonatomic) IBOutlet UILabel *yearsExperienceLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *footerContactButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UICollectionView *daysRequiredCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationPinLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yearsOfExpLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doneButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *carerLikeButton;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;
@end
