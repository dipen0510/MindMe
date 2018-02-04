//
//  BuyPlanViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 17/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyPlanViewController : UIViewController <DataSyncManagerDelegate> {
    
    NSMutableArray* subscriptionsArr;
    
    NSMutableDictionary* goldMonthlyDict;
    NSMutableDictionary* goldQuarterlyDict;
    NSMutableDictionary* goldHalfAnnualDict;
    NSMutableDictionary* goldAnnualDict;
    
    NSMutableDictionary* selectedSubscriptionDict;
    
}


@property (weak, nonatomic) IBOutlet UIButton *voucherApplyButton;
@property (weak, nonatomic) IBOutlet UIButton *goldMonthlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *goldYearlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *goldQuarterlySelectButton;
@property (weak, nonatomic) IBOutlet UIButton *goldHalfYearlySelectButton;
@property (weak, nonatomic) IBOutlet UIView *goldMonthlyView;
@property (weak, nonatomic) IBOutlet UIView *goldQuarterlyView;
@property (weak, nonatomic) IBOutlet UIView *goldYearlyView;
@property (weak, nonatomic) IBOutlet UIView *goldhalfYearlyView;

@property (weak, nonatomic) IBOutlet UILabel *goldHalfAnnualLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldMonthlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldQuarterlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldAnnualLabel;
@property (weak, nonatomic) IBOutlet UITextField *vouchertextField;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)selectButtonTapped:(id)sender;
- (IBAction)voucherApplyButtonTapped:(id)sender;

@end
