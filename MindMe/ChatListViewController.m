//
//  ChatListViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 08/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "ChatListViewController.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _favoritesView.userInteractionEnabled = YES;
    [_favoritesView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favoritesViewTapped)]];
    
    _searchView.userInteractionEnabled = YES;
    [_searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchViewTapped)]];
    
    _profileView.userInteractionEnabled = YES;
    [_profileView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileViewTapped)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - User Interaction Methods

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}

- (IBAction)inboxButtonTapped:(id)sender {
    
    _inboxButton.backgroundColor = [UIColor colorWithRed:0.527 green:0.759 blue:0.274 alpha:1.0];
    _sentButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _archivedButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    
}

- (IBAction)sentButtonTapped:(id)sender {
    
    _inboxButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _sentButton.backgroundColor = [UIColor colorWithRed:0.527 green:0.759 blue:0.274 alpha:1.0];
    _archivedButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    
}

- (IBAction)archivedButtonTapped:(id)sender {
    
    _inboxButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _sentButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _archivedButton.backgroundColor = [UIColor colorWithRed:0.527 green:0.759 blue:0.274 alpha:1.0];
    
}

- (void) favoritesViewTapped {
    
    if (![[SharedClass sharedInstance] isGuestUser]) {
        [self performSegueWithIdentifier:@"showFavoritesSegue" sender:nil];
    }
    else {
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) searchViewTapped {
    
    if (![[SharedClass sharedInstance] isGuestUser]) {
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
    }
    else {
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) profileViewTapped {
    
    if (![[SharedClass sharedInstance] isGuestUser]) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
        }
        else {
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileParentViewController" forSideMenuController:self.sideMenuController];
        }
    }
    else {
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
