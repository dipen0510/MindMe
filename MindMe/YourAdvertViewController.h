//
//  YourAdvertViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourAdvertViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, DataSyncManagerDelegate, UITextFieldDelegate, UITextViewDelegate> {
    
    NSMutableArray* availabilityArr;
    
    NSMutableArray* firstCollectionViewArr;
    NSMutableArray* secondCollectionViewArr;
    NSMutableArray* thirdCollectionViewArr;
    NSMutableArray* fourthCollectionViewArr;
    NSMutableArray* fifthCollectionViewArr;
    NSMutableArray* sixthCollectionViewArr;
    NSMutableArray* seventhCollectionViewArr;
    
    NSMutableArray* secondPreselectedArr;
    NSMutableArray* thirdPreselectedArr;
    NSMutableArray* fourthPreselectedArr;
    NSMutableArray* fifthPreselectedArr;
    NSMutableArray* sixthPreselectedArr;
    NSMutableArray* seventhPreselectedArr;
    
    BOOL isEMERType;
    
}

@property BOOL isAdvertInEditingMode;
@property (strong, nonatomic) NSMutableDictionary * advertDetailsDict;

@property (weak, nonatomic) IBOutlet UICollectionView *daysRequiredCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *firstCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *secondCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *thirdCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *forthCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *fifthCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *sixthCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *seventhCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UICollectionView *cvCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *weeklyHeaderLabel;
@property (weak, nonatomic) IBOutlet UITextField *isAdvertActiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *firstCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *thirdCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *fourthCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *fifthCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *sixthCollectionViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *seventhCollectionViewTitle;

@property (weak, nonatomic) IBOutlet UIView *firstCollectionSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *secondCollectionSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *thirdCollectionSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *fourthCollectionSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *fifthCollectionSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *sixthCollectionSeparatorView;
@property (weak, nonatomic) IBOutlet UIView *seventhCollectionSeparatorView;

@property (weak, nonatomic) IBOutlet UILabel *uploadCVStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *uploadCVDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherRelevantInfoStaticLabel;
@property (weak, nonatomic) IBOutlet UITextView *otherRelevantInfoTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourthCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fifthCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sixthCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seventhCollectionViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourthCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fifthCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sixthCollectionViewTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seventhCollectionViewTitleTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *advertIsActiveLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherRelevantInfoTopConstraint;

@end
