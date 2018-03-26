//
//  MembershipFAQViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCollapseTableView.h"

@interface MembershipFAQViewController : UIViewController <DataSyncManagerDelegate, UIAlertViewDelegate> {
    NSArray *menuItemsArray;
    NSMutableArray* sectionArr;
    NSMutableArray* faqArr;
    NSInteger lastOpenedIndex;
    
    BOOL isSubscriptionCancelled;
    
}


@property (weak, nonatomic) IBOutlet STCollapseTableView *faqTableView;

- (IBAction)menuButtonTapped:(id)sender;


@end
