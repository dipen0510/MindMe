//
//  ChooseCareTypeViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCareTypeViewController : UIViewController {
    
    NSMutableArray* newAdvertsArr;
    NSMutableArray* existingAdvertsArr;
    NSMutableArray* allAdvertsArr;
    NSString* selectedCareType;
    
}

@property (nonatomic, strong) NSMutableArray* userAdvertsArr;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UICollectionView *firstCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *secondCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *editSectionHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nSectionHeaderLabel;

- (IBAction)backButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCollectionViewHeightConstraint;
@end
