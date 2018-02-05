//
//  FavoritesTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FavoritesTableViewCell.h"

@implementation FavoritesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _containerView.layer.cornerRadius = 5.0;
    _containerView.layer.masksToBounds = NO;
    _containerView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.7].CGColor;
    _containerView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _containerView.layer.shadowOpacity = 0.4f;
    _containerView.layer.shadowRadius = 5.0;
    
    _profileImgView.layer.cornerRadius = ((92./800.) * [UIScreen mainScreen].bounds.size.width);
    _profileImgView.layer.masksToBounds = YES;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
