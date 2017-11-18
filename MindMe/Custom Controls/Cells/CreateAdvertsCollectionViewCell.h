//
//  CreateAdvertsCollectionViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAdvertsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
- (IBAction)toggleButtonTapped:(UIButton *)sender;
@end
