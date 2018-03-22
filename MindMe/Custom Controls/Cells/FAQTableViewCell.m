//
//  FAQTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 17/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FAQTableViewCell.h"

@implementation FAQTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headerTitle.font = [UIFont fontWithName:@"Montserrat-Regular" size:(20./667)*kScreenHeight];
    _bodyTitle.font = [UIFont fontWithName:@"Montserrat-Light" size:(20./667)*kScreenHeight];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
