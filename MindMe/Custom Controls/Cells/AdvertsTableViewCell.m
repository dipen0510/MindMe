//
//  AdvertsTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AdvertsTableViewCell.h"

@implementation AdvertsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _editButton.layer.cornerRadius = (18.5/568) * [UIScreen mainScreen].bounds.size.height;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
