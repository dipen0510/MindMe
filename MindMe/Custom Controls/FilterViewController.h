//
//  FilterViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 10/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRangeSlider.h"

@interface FilterViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate> {
    
}

@property (strong, nonatomic) NSMutableArray* availabilityArr;
@property (strong, nonatomic) NSMutableArray* servicesArr;
@property BOOL isRefineSearchEnabled;
@property (strong, nonatomic) NSArray* caretypeArr;

@property (weak, nonatomic) IBOutlet UICollectionView *availabilityCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *miscTblView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UITextField *careTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *distanceTextField;
@property (weak, nonatomic) IBOutlet TTRangeSlider *ageSlider;
@property (weak, nonatomic) IBOutlet TTRangeSlider *experienceSlider;
@property (weak, nonatomic) IBOutlet UIButton *refineSearchButton;
@property (weak, nonatomic) IBOutlet UIButton *primaryApplyButton;
@property (weak, nonatomic) IBOutlet UILabel *availabilityStaticLabel;
@property (weak, nonatomic) IBOutlet UIView *availabilitySeparatorView;

- (IBAction)refineSearchButtonTapped:(id)sender;
@end
