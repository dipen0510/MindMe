//
//  AdsHomeTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AdsHomeTableViewCell.h"

@implementation AdsHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _containerView.layer.cornerRadius = 5.0;
    _containerView.layer.masksToBounds = NO;
    _containerView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.7].CGColor;
    _containerView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _containerView.layer.shadowOpacity = 0.2f;
    _containerView.layer.shadowRadius = 3.5;
    
    _nameLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(19./667)*kScreenHeight];
    _locationLabel.font = _ageLabel.font = _experienceValueLabel.font = _careTypeLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(15./667)*kScreenHeight];
    _descLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(15./667)*kScreenHeight];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
