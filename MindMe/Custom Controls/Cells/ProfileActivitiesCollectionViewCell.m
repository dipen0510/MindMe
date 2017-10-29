//
//  ProfileActivitiesCollectionViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 23/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "ProfileActivitiesCollectionViewCell.h"

@implementation ProfileActivitiesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _activityLabel.layer.cornerRadius = 5.;
    _activityLabel.layer.masksToBounds = YES;
    
}

@end
