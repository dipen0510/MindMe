//
//  ChooseCareTypeCollectionViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 23/01/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "ChooseCareTypeCollectionViewCell.h"

@implementation ChooseCareTypeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(19./667)*kScreenHeight];
    
}

- (IBAction)toggleButtonTapped:(UIButton *)sender {
}

@end
