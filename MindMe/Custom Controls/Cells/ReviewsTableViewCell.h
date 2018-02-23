//
//  ReviewsTableViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 23/02/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstStarButton;
@property (weak, nonatomic) IBOutlet UIButton *secondStarButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthStarButton;
@property (weak, nonatomic) IBOutlet UILabel *reviewTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *reviewDescriptionTextView;

@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end
