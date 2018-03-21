//
//  SideMenuTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 21/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "SideMenuTableViewCell.h"

@implementation SideMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _menuTitle.font = [UIFont fontWithName:@"Montserrat-Regular" size:(20./667)*kScreenHeight];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
