//
//  ChatStartViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatStartViewController : UIViewController <DataSyncManagerDelegate> {
    NSString* selectedCareType;
    NSMutableArray* allCareTypesArr;
}

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UILabel *selectActiveProfStaticLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *careTypeCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *footerLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)sendButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
