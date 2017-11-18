//
//  CreateAdvertsCollectionViewCell.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "CreateAdvertsCollectionViewCell.h"

@implementation CreateAdvertsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)toggleButtonTapped:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
@end
