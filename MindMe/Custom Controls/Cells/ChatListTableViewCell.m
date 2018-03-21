//
//  ChatListTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 08/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "ChatListTableViewCell.h"

@implementation ChatListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.height/2.;
    _profileImgView.layer.masksToBounds = YES;
    
    _titleLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    _descriptionLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(20./667)*kScreenHeight];
    _dateLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(15./667)*kScreenHeight];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
