//
//  ProfileAvailabilityCollectionViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 30/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileAvailabilityCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *availabilityLabel;
@property (weak, nonatomic) IBOutlet UIButton *availabilityButton;
@property (weak, nonatomic) IBOutlet UIImageView *availabilityImgView;
- (IBAction)availabilityButtonTapped:(id)sender;

@end
