//
//  YourInformationViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourInformationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UICollectionView *languagesCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *miscCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

- (IBAction)requiredOccassionalyButtonTapped:(UIButton *)sender;
- (IBAction)requiredRegulartlyButtonTapped:(UIButton *)sender;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addLanguagesButtonTapped:(id)sender;

@end
