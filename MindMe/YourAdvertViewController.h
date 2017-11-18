//
//  YourAdvertViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourAdvertViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    NSMutableArray* availabilityArr;
    
}

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

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addButtonTapped:(id)sender;

@end
