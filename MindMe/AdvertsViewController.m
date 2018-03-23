//
//  AdvertsViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AdvertsViewController.h"
#import "AdvertsTableViewCell.h"
#import "ChooseCareTypeViewController.h"
#import "YourInformationViewController.h"

@interface AdvertsViewController ()

@end

@implementation AdvertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _menuButton.hidden = [[NSUserDefaults standardUserDefaults] boolForKey:@"isEditProfileMenuButtonHidden"];
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
    }
    else {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isEditProfileMenuButtonHidden"]) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isProfileUpdated"]) {
                [self performSegueWithIdentifier:@"showChooseCareTypeSegue" sender:nil];
            }
            else {
                if ([[SharedClass sharedInstance] isUserCarer]) {
                    [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
                }
                else {
                    [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileParentViewController" forSideMenuController:self.sideMenuController];
                }
            }
            
        }
        else {
            [self startGetAdvertsService];
        }
    }
    
}

- (void) setupInitialUI {
    
    _createAdvertButton.layer.cornerRadius = 17.5;
    _createAdvertButton.layer.masksToBounds = NO;
    
    _mailLabel.layer.cornerRadius = 5;
    _mailLabel.layer.masksToBounds = NO;
    _mailLabel.layer.borderColor = _createAdvertButton.backgroundColor.CGColor;
    _mailLabel.layer.borderWidth = 1.0;
    
    _advertLabel.layer.cornerRadius = 5;
    _advertLabel.layer.masksToBounds = NO;
    _advertLabel.layer.borderColor = _createAdvertButton.backgroundColor.CGColor;
    _advertLabel.layer.borderWidth = 1.0;
    
    _upgradedLabel.layer.cornerRadius = 5;
    _upgradedLabel.layer.masksToBounds = NO;
    _upgradedLabel.layer.borderColor = _createAdvertButton.backgroundColor.CGColor;
    _upgradedLabel.layer.borderWidth = 1.0;
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    _nameLabel.font = _tableViewheaderLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(20./667)*kScreenHeight];
    
    _liveAdvertValueLabel.font = _subscribedValueLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(18./667)*kScreenHeight];
    _mailLabel.font = _upgradedLabel.font = _advertLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(18./667)*kScreenHeight];
    
    _createAdvertButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(20./667)*kScreenHeight];
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        
        _upgradedLabel.attributedText = [self attributedTextForUpgradedLabel:@"Subscribed\n"];
        _tableViewheaderLabel.text = @"Adverts";
        
    }
    else {
        _headerLabel.text = @"Profile Control";
        [_createAdvertButton setTitle:@"Create Profile" forState:UIControlStateNormal];
        _advertLabel.text = @"Live Profiles\n";
    }
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetails"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    _nameLabel.text = [NSString stringWithFormat:@"Hi %@ %@",[responseData valueForKey:@"first_name"],[responseData valueForKey:@"second_name"]];
    
    NSData *dictionaryData1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
    NSDictionary *responseData1 = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData1];
    
    if ([[responseData1 valueForKey:@"Sub_active"] intValue] == 1) {
        _subscribedValueLabel.text = @"YES";
    }
    else {
        if (![[SharedClass sharedInstance] isUserCarer]) {
            _upgradedLabel.attributedText = [self attributedTextForUpgradedLabel:@"Subscribed\n\n"];
            _subscribedValueLabel.text = @"Subscribe\nNow";
            _subscribedValueTopConstraint.constant = 40.;
        }
        else {
            _upgradedLabel.attributedText = [self attributedTextForUpgradedLabel:@"Upgraded\n\n"];
            _subscribedValueLabel.text = @"Upgrade\nNow";
            _subscribedValueTopConstraint.constant = 40.;
        }
        
        _boxesHeightConstraint.constant = 80;
        _boxLabelTopConstraint.constant = (85.+12);
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showChooseCareTypeSegue"]) {
        
        ChooseCareTypeViewController* destController = (ChooseCareTypeViewController *)[segue destinationViewController];
        destController.userAdvertsArr = advertsArr;
        
    }
    if ([segue.identifier isEqualToString:@"showYourInfoSegue"]) {
        
        YourInformationViewController* controller = (YourInformationViewController*)[segue destinationViewController];
        controller.selectedCareType = [editAdvertDict valueForKey:@"care_type"];
        controller.advertDictToBeEdited = editAdvertDict;
        
    }
    
}


#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return advertsArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AdvertsTableViewCell";
    AdvertsTableViewCell *cell = (AdvertsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AdvertsTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
    
}


- (void) populateContentForAdsCell:(AdvertsTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        cell.careTypeLabel.text = [NSString stringWithFormat:@"%@ advert [%@ views]",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"],[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"viewed"]];
        [cell.editButton setTitle:[NSString stringWithFormat:@"Edit %@ Advert",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"]] forState:UIControlStateNormal];
        
        
        NSMutableAttributedString *strText = [[NSMutableAttributedString alloc] initWithString:cell.careTypeLabel.text];
        
        [strText addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"Montserrat-Medium" size:(19./667.)*kScreenHeight]
                        range:[cell.careTypeLabel.text rangeOfString:[NSString stringWithFormat:@"%@",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"]]]];
        
        [strText addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"Montserrat-Light" size:(19./667.)*kScreenHeight]
                        range:[cell.careTypeLabel.text rangeOfString:[NSString stringWithFormat:@"advert [%@ views]",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"viewed"]]]];
        
        cell.careTypeLabel.attributedText = strText;
        
    }
    else {
        cell.careTypeLabel.text = [NSString stringWithFormat:@"%@ profile [%@ views]",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"],[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"viewed"]];
        [cell.editButton setTitle:[NSString stringWithFormat:@"Edit %@ Profile",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"]] forState:UIControlStateNormal];
        
        
        NSMutableAttributedString *strText = [[NSMutableAttributedString alloc] initWithString:cell.careTypeLabel.text];
        
        [strText addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"Montserrat-Medium" size:(19./667.)*kScreenHeight]
                        range:[cell.careTypeLabel.text rangeOfString:[NSString stringWithFormat:@"%@",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"]]]];
        
        [strText addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"Montserrat-Light" size:(19./667.)*kScreenHeight]
                        range:[cell.careTypeLabel.text rangeOfString:[NSString stringWithFormat:@"profile [%@ views]",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"viewed"]]]];
        
        cell.careTypeLabel.attributedText = strText;
        
    }
    
    cell.toggleButton.tag = indexPath.row;
    [cell.toggleButton addTarget:self action:@selector(advertToggleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.toggleButton.selected = ![[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"job_ad_active"] boolValue];
    
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(advertDeleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.editButton.tag = indexPath.row;
    [cell.editButton addTarget:self action:@selector(advertEditButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void) advertToggleButtonTapped:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    [self startToggleAdvertsServiceForAdvert:[advertsArr objectAtIndex:sender.tag]];
    
}

- (void) advertDeleteButtonTapped:(UIButton *)sender {
    
    deleteAdvertDict = [[NSMutableDictionary alloc] initWithDictionary:[advertsArr objectAtIndex:sender.tag]];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Confirm Delete" message:@"Are you sure you want to delete." delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];

}

- (void) advertEditButtonTapped:(UIButton *)sender {
    
    editAdvertDict = [[NSMutableDictionary alloc] initWithDictionary:[advertsArr objectAtIndex:sender.tag]];
    [self performSegueWithIdentifier:@"showYourInfoSegue" sender:nil];
    
}

- (NSMutableAttributedString *) attributedTextForUpgradedLabel:(NSString *) labelText {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    return attributedString ;
    
}


#pragma mark - API Helpers

- (void) startGetAdvertsService {
    
    [SVProgressHUD showWithStatus:@"Fetching data"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetPostedAdverts;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetPostedAdverts]];
    
}

- (void) startToggleAdvertsServiceForAdvert:(NSMutableDictionary *)advertDict {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = ToggleAdvertActive;
    manager.delegate = nil;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForToggleAdverts:advertDict]];
    
}

- (void) startDeleteAdvertsServiceForAdvert:(NSMutableDictionary *)advertDict {
    
    [SVProgressHUD showWithStatus:@"Deleting data"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = DeleteAdvert;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForDeleteAdverts:advertDict]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetPostedAdverts]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Data refreshed successfully"];
        
        if ([[responseData valueForKey:@"message"] isKindOfClass:[NSArray class]]) {
            advertsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
            [self updateLiveAdvertsValueLabel];
        }
        else {
            _liveAdvertValueLabel.text = @"0";
        }
        
        [_advertTblView reloadData];

    }
    
    if ([requestServiceKey isEqualToString:DeleteAdvert]) {
        
        [self startGetAdvertsService];
        
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

- (NSMutableDictionary *) prepareDictionaryForGetPostedAdverts {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForToggleAdverts:(NSMutableDictionary *)advertDict {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    BOOL jobActive = [[advertDict valueForKey:@"job_ad_active"] boolValue];
    
    [dict setObject:[advertDict valueForKey:@"care_type"] forKey:@"care_type"];
    [dict setObject:[NSString stringWithFormat:@"%d",!jobActive] forKey:@"job_ad_active"];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForDeleteAdverts:(NSMutableDictionary *)advertDict {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[advertDict valueForKey:@"care_type"] forKey:@"care_type"];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

- (void) updateLiveAdvertsValueLabel {
    
    int count = 0;
    
    for (NSDictionary* dict in advertsArr) {
        if ([[dict valueForKey:@"job_ad_active"] intValue] == 1) {
            count++;
        }
    }
    
    _liveAdvertValueLabel.text = [NSString stringWithFormat:@"%d",count];
    
}

#pragma mark - AlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self startDeleteAdvertsServiceForAdvert:deleteAdvertDict];
    }
    
}
@end
