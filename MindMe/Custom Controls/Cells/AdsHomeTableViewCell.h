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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *careTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ageImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageImgViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *featuredImgView;
@property (weak, nonatomic) IBOutlet UILabel *featuredLabel;
@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileImgViewTopCOnstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featuredImgViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descTopConstraint;

@end
