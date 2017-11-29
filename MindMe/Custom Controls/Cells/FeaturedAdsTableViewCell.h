//
//  FeaturedAdsTableViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedAdsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UIImageView *drivingLicenseImgView;
@property (weak, nonatomic) IBOutlet UILabel *yearsExperienceStaticLabel;

@end
