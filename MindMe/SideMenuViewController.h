//
//  SideMenuViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 21/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController {
    NSArray *menuItemsArray;
    NSArray *menuImageArray;
}

@property (weak, nonatomic) IBOutlet UITableView *sideMenuTableView;
@end
