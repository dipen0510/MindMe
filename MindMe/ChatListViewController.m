//
//  ChatListViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 08/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatListTableViewCell.h"
#import "ChatViewController.h"

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
    
    msgListArr = [[NSMutableArray alloc] init];
    [self startSendMessageService];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showChatSegue"]) {
        
        ChatViewController* controller = (ChatViewController *)[segue destinationViewController];
        controller.chatInfoDict = selectedChatDict;
        
    }
    
}


#pragma mark - User Interaction Methods

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}

- (IBAction)inboxButtonTapped:(id)sender {
    
    _inboxButton.backgroundColor = [UIColor colorWithRed:0.527 green:0.759 blue:0.274 alpha:1.0];
    _sentButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _archivedButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    
    selectedIndex = 0;
    [self startSendMessageService];
    
}

- (IBAction)sentButtonTapped:(id)sender {
    
    _inboxButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _sentButton.backgroundColor = [UIColor colorWithRed:0.527 green:0.759 blue:0.274 alpha:1.0];
    _archivedButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    
    selectedIndex = 1;
    [self startSendMessageService];
    
}

- (IBAction)archivedButtonTapped:(id)sender {
    
    _inboxButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _sentButton.backgroundColor = [UIColor colorWithRed:0.190  green:0.331 blue:0.444 alpha:1.0];
    _archivedButton.backgroundColor = [UIColor colorWithRed:0.527 green:0.759 blue:0.274 alpha:1.0];
    
    selectedIndex = 2;
    [self startSendMessageService];
    
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

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return msgListArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ChatListTableViewCell";
    ChatListTableViewCell *cell = (ChatListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ChatListTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedChatDict = [[NSMutableDictionary alloc] initWithDictionary:[msgListArr objectAtIndex:indexPath.row]];
    [self performSegueWithIdentifier:@"showChatSegue" sender:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return (125./667.)*kScreenHeight;
    
}


- (void) populateContentForAdsCell:(ChatListTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ %@.",[[msgListArr objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[[msgListArr objectAtIndex:indexPath.row] valueForKey:@"second_name"] substringToIndex:1]];
    cell.descriptionLabel.text = [[msgListArr objectAtIndex:indexPath.row] valueForKey:@"message_title"];
    
    NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [dateformatter dateFromString:[[msgListArr objectAtIndex:indexPath.row] valueForKey:@"date_sent"]];
    
    cell.dateLabel.text = [date dateTimeAgo];
    
    if (![[[msgListArr objectAtIndex:indexPath.row] valueForKey:@"image_path"] isEqualToString:@""]) {
        __weak UIImageView* weakImageView = cell.profileImgView;
        [cell.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceURL,[[msgListArr objectAtIndex:indexPath.row] valueForKey:@"image_path"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                     cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                                 timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"profile_icon"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            weakImageView.alpha = 0.0;
            weakImageView.image = image;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 weakImageView.alpha = 1.0;
                             }];
        } failure:NULL];
    }
    else {
        cell.profileImgView.image = [UIImage imageNamed:@"profile_icon"];
    }
    
}

#pragma mark - API Helpers

- (void) startSendMessageService {
    
    [SVProgressHUD showWithStatus:@"Refreshing List"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetAllMessageList;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForSendMesssage]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetAllMessageList]) {
        
        [SVProgressHUD showSuccessWithStatus:@"List refreshed successfully"];
        
        if ([[responseData valueForKey:@"message"] isKindOfClass:[NSArray class]]) {
            
            msgListArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
            
        }
        
        [_listTableView reloadData];
        
    }
    
}


- (void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    
    [SVProgressHUD dismiss];
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                        otherButtonTitles: nil];
    
    if (![errorMsg isEqualToString:@""]) {
        [alert setMessage:errorMsg];
    }
    
    if ([errorMsg isEqualToString:NSLocalizedString(@"Verify your internet connection and try again", nil)]) {
        [alert setTitle:NSLocalizedString(@"Connection unsuccessful", nil)];
    }
    
    [alert show];
    
    return;
    
}




#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForSendMesssage {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    switch (selectedIndex) {
    
        case 1:
        [dict setObject:@"sent" forKey:@"custom"];
        break;
        
        case 2:
        [dict setObject:@"archive" forKey:@"custom"];
        break;
        
        default:
        [dict setObject:@"inbox" forKey:@"custom"];
        break;
        
    }
    
    return dict;
    
}

@end
