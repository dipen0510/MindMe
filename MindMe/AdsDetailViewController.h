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

@property (nonatomic, strong) NSMutableDictionary* advertDict;

@property (weak, nonatomic) IBOutlet UILabel *yearsExperienceLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *footerContactButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UICollectionView *daysRequiredCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *carerLikeButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobActiveViewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *careTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceValueLabel;
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;
@property (weak, nonatomic) IBOutlet UILabel *lastLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberSinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *haveACaerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *haveACarImgView;
@property (weak, nonatomic) IBOutlet UILabel *acceptOnlinePaymentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *acceptOnlinePaymentImgView;
@property (weak, nonatomic) IBOutlet UILabel *languagesValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfortableWithpetsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *comfortableWithPetsImgView;
@property (weak, nonatomic) IBOutlet UILabel *nonSmokerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nonSmokerImgView;
@property (weak, nonatomic) IBOutlet UIImageView *shortNoticeImgView;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationPinLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yearsOfExpLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doneButtonHeightConstraint;

@end
