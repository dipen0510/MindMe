//
//  ChatListViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 08/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+TimeAgo.h"

@interface ChatListViewController : UIViewController <DataSyncManagerDelegate> {
    NSMutableArray* msgListArr;
    int selectedIndex;
}

@property (weak, nonatomic) IBOutlet UIView *favoritesView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIButton *inboxButton;
@property (weak, nonatomic) IBOutlet UIButton *sentButton;
@property (weak, nonatomic) IBOutlet UIButton *archivedButton;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)inboxButtonTapped:(id)sender;
- (IBAction)sentButtonTapped:(id)sender;
- (IBAction)archivedButtonTapped:(id)sender;

@end
