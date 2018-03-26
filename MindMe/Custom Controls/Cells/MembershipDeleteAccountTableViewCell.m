//
//  MembershipDeleteAccountTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 26/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "MembershipDeleteAccountTableViewCell.h"

@implementation MembershipDeleteAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _deactivateButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    _deactivateButton.layer.cornerRadius = 20.;
    _deactivateButton.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
