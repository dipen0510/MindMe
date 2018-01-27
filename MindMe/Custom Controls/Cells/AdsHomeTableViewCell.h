//
//  AdsHomeTableViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsHomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UIImageView *drivingLicenseImgView;
@property (weak, nonatomic) IBOutlet UIImageView *euImgView;
@property (weak, nonatomic) IBOutlet UILabel *yearsExperienceStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *careTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewMoreButton;

@end
