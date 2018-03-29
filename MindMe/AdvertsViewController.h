//
//  AdvertsViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertsViewController : UIViewController <DataSyncManagerDelegate, UIAlertViewDelegate> {
    
    NSMutableArray* advertsArr;
    NSMutableDictionary* editAdvertDict;
    NSMutableDictionary* deleteAdvertDict;
    
}

@property (weak, nonatomic) IBOutlet UILabel *mailLabel;
@property (weak, nonatomic) IBOutlet UILabel *upgradedLabel;
@property (weak, nonatomic) IBOutlet UILabel *advertLabel;
@property (weak, nonatomic) IBOutlet UIButton *createAdvertButton;
@property (weak, nonatomic) IBOutlet UITableView *advertTblView;
@property (weak, nonatomic) IBOutlet UILabel *liveAdvertValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subscribedValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *tableViewheaderLabel;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boxesHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *boxLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subscribedValueTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *liveAdvertValueTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *advertTblViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *favoritesView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIView *messagesView;
@property (weak, nonatomic) IBOutlet UILabel *unreadMessageLabel;

- (IBAction)menuButtonTapped:(id)sender;

@end
