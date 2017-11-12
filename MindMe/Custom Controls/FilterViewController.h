//
//  FilterViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 10/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    NSMutableArray* availabilityArr;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *availabilityCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *miscTblView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@end
