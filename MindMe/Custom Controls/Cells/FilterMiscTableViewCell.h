//
//  FilterMiscTableViewCell.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 12/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterMiscTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *miscButton;
@property (weak, nonatomic) IBOutlet UILabel *miscLabel;
@property BOOL isSelected;

- (IBAction)miscButtonTapped:(id)sender;

@end
