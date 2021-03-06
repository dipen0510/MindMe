//
//  BuyPlansForParentsViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyPlansForParentsViewController : UIViewController <DataSyncManagerDelegate> {
    
    NSMutableArray* subscriptionsArr;
    
    NSMutableDictionary* goldMonthlyDict;
    NSMutableDictionary* goldQuarterlyDict;
    NSMutableDictionary* goldAnnualDict;
    NSMutableDictionary* silverMonthlyDict;
    NSMutableDictionary* silverQuarterlyDict;
    NSMutableDictionary* silverAnnualDict;
    
    NSMutableDictionary* selectedSubscriptionDict;
    
}

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

@property (weak, nonatomic) IBOutlet UILabel *silverMonthlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverQuarterlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverAnnualLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldMonthlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldQuarterlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldAnnualLabel;
@property (weak, nonatomic) IBOutlet UITextField *vouchertextField;

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *couvherStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverStaticLabel;

@property (weak, nonatomic) IBOutlet UILabel *goldMonthlyStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldQuarterlyStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldAnnualStaticLabel;

@property (weak, nonatomic) IBOutlet UILabel *silverMonthlyStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverQuarterlyStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverAnnualStaticLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel1;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel2;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)selectButtonTapped:(id)sender;
- (IBAction)voucherApplyButtonTapped:(id)sender;

@end
