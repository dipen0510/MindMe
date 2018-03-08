//
//  ChatListViewController.h
//  MindMe
//
//  Created by Dipen Sekhsaria on 08/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *favoritesView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIButton *inboxButton;
@property (weak, nonatomic) IBOutlet UIButton *sentButton;
@property (weak, nonatomic) IBOutlet UIButton *archivedButton;

- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)inboxButtonTapped:(id)sender;
- (IBAction)sentButtonTapped:(id)sender;
- (IBAction)archivedButtonTapped:(id)sender;

@end
