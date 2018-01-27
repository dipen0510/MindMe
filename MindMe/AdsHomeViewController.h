//
//  AdsHomeViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsHomeViewController : UIViewController <DataSyncManagerDelegate> {
    
    NSMutableArray* advertsArr;
    NSMutableDictionary* selectedAdvertDict;
    
}

@property (weak, nonatomic) IBOutlet UIView *favoritesView;
@property (weak, nonatomic) IBOutlet UIView *messagesView;
@property (weak, nonatomic) IBOutlet UITextField *carerTypeTextField;
@property (weak, nonatomic) IBOutlet UITableView *advertTblView;

- (IBAction)carerTypeButtonTapped:(id)sender;
- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)filterButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carerTypeTFLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carerTypeTFTopConstraint;

@end
