//
//  CreateAdvertsCollectionViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "CreateAdvertsCollectionViewCell.h"
#import "ChooseCareTypeViewController.h"

@implementation CreateAdvertsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
        _titleLabel.userInteractionEnabled = YES;
        [_titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleButtonTapped:)]];
    
    _titleLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(14./667)*kScreenHeight];
    
}

- (IBAction)toggleButtonTapped:(UIButton *)sender {
        _toggleButton.selected = !_toggleButton.isSelected;
}

@end
