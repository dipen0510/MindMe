//
//  AdsDetailCollectionViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/01/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsDetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *detailsTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailsTickImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailsTextLabelLeadingConstraint;

@end
