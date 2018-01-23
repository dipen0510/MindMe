//
//  YourInformationViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface YourInformationViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PECropViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate> {
    
    UIActionSheet* actSheet;
    UIImage* profileImage;
    
    NSMutableArray* selectedLanguageArr;
    
}

@property (nonatomic, strong) NSString* selectedCareType;

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UICollectionView *languagesCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *miscCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UITextView *addYourBioTextView;
@property (weak, nonatomic) IBOutlet UITextField *preferredRateTextField;
@property (weak, nonatomic) IBOutlet UIButton *requiredRegularlyButton;
@property (weak, nonatomic) IBOutlet UIButton *requiredOcassionalyButton;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *requiredRegularlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *requiredOccasionallyLabel;

- (IBAction)requiredOccassionalyButtonTapped:(UIButton *)sender;
- (IBAction)requiredRegulartlyButtonTapped:(UIButton *)sender;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addLanguagesButtonTapped:(id)sender;
- (IBAction)experienceMinusButtonTapped:(id)sender;
- (IBAction)experiencePlusButtonTapped:(id)sender;

@end
