//
//  SideMenuViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 21/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCollapseTableView.h"

@interface SideMenuViewController : UIViewController {
    NSArray *menuItemsArray;
    NSArray *menuItemsArrayForCarer;
    NSArray *menuImageArray;
    NSArray *menuImageArrayForCarer;
    NSMutableArray* sectionArr;
    NSInteger lastOpenedIndex;
    
    BOOL isUserSubscribed;
    
}

@property (weak, nonatomic) IBOutlet STCollapseTableView *sideMenuTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblViewHeightConstraint;
@end
