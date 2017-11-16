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
    NSArray *menuImageArray;
    NSMutableArray* sectionArr;
    NSInteger lastOpenedIndex;
}

@property (weak, nonatomic) IBOutlet STCollapseTableView *sideMenuTableView;
@end
