//
//  FilterMiscTableViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 12/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FilterMiscTableViewCell.h"

@implementation FilterMiscTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)miscButtonTapped:(id)sender {
    _miscButton.selected = !_miscButton.isSelected;
}
@end
