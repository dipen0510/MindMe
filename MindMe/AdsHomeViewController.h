//
//  AdsHomeViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsHomeViewController : UIViewController <DataSyncManagerDelegate, UITextFieldDelegate> {
    
    NSMutableArray* advertsArr;
    NSMutableArray* filteredAdvertsArr;
    NSMutableDictionary* selectedAdvertDict;
    
}

@property (weak, nonatomic) IBOutlet UIView *favoritesView;
@property (weak, nonatomic) IBOutlet UIView *messagesView;
@property (weak, nonatomic) IBOutlet UITextField *carerTypeTextField;
@property (weak, nonatomic) IBOutlet UITableView *advertTblView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITableView *addressTblView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *noAdsFoundsLabel;

- (IBAction)carerTypeButtonTapped:(id)sender;
- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)filterButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carerTypeTFLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carerTypeTFTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *advertTblViewTopConstraint;

@end
