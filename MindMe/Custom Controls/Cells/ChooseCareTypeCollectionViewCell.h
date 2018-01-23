//
//  ChooseCareTypeCollectionViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 23/01/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCareTypeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
- (IBAction)toggleButtonTapped:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingConstraint;

@end
