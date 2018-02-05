//
//  FavoritesViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController <DataSyncManagerDelegate> {
    NSMutableArray* favoritesArr;
}

@property (weak, nonatomic) IBOutlet UITableView *favoritesTblView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
- (IBAction)backButtonTapped:(id)sender;

@end
