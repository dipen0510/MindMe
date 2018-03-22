//
//  AdsDetailCollectionViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/01/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "AdsDetailCollectionViewCell.h"

@implementation AdsDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _detailsTextLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(19./667)*kScreenHeight];
    
}

@end
