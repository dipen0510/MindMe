//
//  FAQViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 17/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCollapseTableView.h"

@interface FAQViewController : UIViewController {
    NSArray *menuItemsArray;
    NSMutableArray* sectionArr;
    NSMutableArray* faqArr;
    NSInteger lastOpenedIndex;
}


@property (weak, nonatomic) IBOutlet STCollapseTableView *faqTableView;

- (IBAction)menuButtonTapped:(id)sender;

@end
