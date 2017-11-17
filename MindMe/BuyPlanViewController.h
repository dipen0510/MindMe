//
//  BuyPlanViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 17/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyPlanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *voucherApplyButton;
@property (weak, nonatomic) IBOutlet UIButton *silverQuarterlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *silverMonthlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *silverYearlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *goldMonthlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *goldQuarterlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *goldYearlySelectButton;
@property (weak, nonatomic) IBOutlet UIView *silverMonthlyView;
@property (weak, nonatomic) IBOutlet UIView *silverQuaretlyView;
@property (weak, nonatomic) IBOutlet UIView *silverYearlyView;
@property (weak, nonatomic) IBOutlet UIView *goldMonthlyView;
@property (weak, nonatomic) IBOutlet UIView *goldQuarterlyView;
@property (weak, nonatomic) IBOutlet UIView *goldYearlyView;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)selectButtonTapped:(id)sender;

@end
