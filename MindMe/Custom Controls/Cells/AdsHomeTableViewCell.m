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
    _containerView.layer.shadowOpacity = 0.4f;
    _containerView.layer.shadowRadius = 5.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
