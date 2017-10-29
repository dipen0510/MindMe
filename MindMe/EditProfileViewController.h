//
//  EditProfileViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 22/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UICollectionView *activitiesCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *servicesCollectionView;

- (IBAction)menuButtonTapped:(id)sender;

@end
