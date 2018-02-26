//
//  AdsDetailViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 09/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, DataSyncManagerDelegate> {
    
    NSMutableArray* availabilityArr;
    
    NSMutableArray* firstCollectionViewArr;
    NSMutableArray* secondCollectionViewArr;
    NSMutableArray* thirdCollectionViewArr;
    NSMutableArray* fourthCollectionViewArr;
    NSMutableArray* fifthCollectionViewArr;
    NSMutableArray* sixthCollectionViewArr;
    
    NSMutableArray* reviewArr;
    
}

@property (nonatomic, strong) NSMutableDictionary* advertDict;
@property BOOL isOpenedFromFavorites;

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
@property (weak, nonatomic) IBOutlet UITextField *otherRelevantInfoStaticLabel;
@property (weak, nonatomic) IBOutlet UITextView *otherRelevantInfoTextView;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationPinLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yearsOfExpLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doneButtonHeightConstraint;

@property (weak, nonatomic) IBOutlet UITextField *firstCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UITextField *secondCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UITextField *thirdCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UITextField *fourthCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UITextField *fifthCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UITextField *sixthCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UITextField *reviewStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileStaticLabel2;
@property (weak, nonatomic) IBOutlet UIView *mobileSeparatorView;

@property (weak, nonatomic) IBOutlet UICollectionView *firstCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *secondCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *thirdCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *fourthCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *fifthCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *sixthCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourthCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fifthCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sixthCollectionViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourthCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fifthCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sixthCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daysRequiredLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelButtonTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *firstCollectionViewSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *secondCollectionViewSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *thirdCollectionViewSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *fourthCollectionViewSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *fifthCollectionViewSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *sixthCollectionViewSeparatorView;

@property (weak, nonatomic) IBOutlet UITableView *reviewTblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewTblViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutTextViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carImgViewTopConstraint;

@end
