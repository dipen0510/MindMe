//
//  ReviewsTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 23/02/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "ReviewsTableViewCell.h"

@implementation ReviewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.height/2.;
    _profileImgView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
