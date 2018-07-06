//
//  SideMenuViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 21/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"
#import "SideMenuSectionView.h"

@interface SideMenuViewController ()<STCollapseTableViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    float sectionHeight;
}

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [_sideMenuTableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUIForSubscription) name:@"SideMenuOpened" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     _sideMenuTableView.delegate1 = self;
    _sideMenuTableView.dataSource = self;
    
}

-(void) viewWillDisappear:(BOOL) animated
{
    [super viewWillDisappear:animated];

    _sideMenuTableView.delegate1 = nil;
    _sideMenuTableView.dataSource = nil;
    
}

- (void) setupInitialUI {
    
    sectionHeight = (60./667.) * kScreenHeight;
    
    lastOpenedIndex = -1;
    menuItemsArray=[[NSArray alloc]initWithObjects:@"My Details", @"My Adverts", @"Search for a Carer", @"Featured Carers", @"Last Minute Care", @"Messages", @"Subscribe Now", @"Information", @"Contact Us", @"Logout", nil];
    menuItemsArrayForCarer=[[NSArray alloc]initWithObjects:@"My Details", @"My Profiles", @"Search Jobs", @"Upgrade", @"Messages", @"Information", @"Contact Us", @"Logout", nil];
    menuImageArray = [[NSArray alloc]initWithObjects:@"ic_avatar",@"ic_avatar",@"ic_search",@"ic_search",@"ic_search",@"news_icon",@"ic_email",@"info_icon",@"ic_email",@"logout",nil];
    menuImageArrayForCarer = [[NSArray alloc]initWithObjects:@"ic_avatar",@"ic_avatar",@"ic_search",@"news_icon",@"ic_email",@"info_icon",@"ic_email",@"logout",nil];
    sectionArr = [[NSMutableArray alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        for (int i = 0; i<menuItemsArrayForCarer.count; i++) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuSectionView" owner:self options:nil];
            SideMenuSectionView *header = [topLevelObjects objectAtIndex:0];
            header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
            header.menuImage.image = [UIImage imageNamed:[menuImageArrayForCarer objectAtIndex:i]];
            header.menuTitle.text = [menuItemsArrayForCarer objectAtIndex:i];
            [sectionArr addObject:header];
            
        }
        _tblViewHeightConstraint.constant = sectionHeight * menuItemsArrayForCarer.count;
    }
    else {
        for (int i = 0; i<menuItemsArray.count; i++) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuSectionView" owner:self options:nil];
            SideMenuSectionView *header = [topLevelObjects objectAtIndex:0];
            header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
            header.menuImage.image = [UIImage imageNamed:[menuImageArray objectAtIndex:i]];
            header.menuTitle.text = [menuItemsArray objectAtIndex:i];
            [sectionArr addObject:header];
            
        }
        _tblViewHeightConstraint.constant = sectionHeight * menuItemsArray.count;
    }
    
    _sideMenuTableView.delegate1 = self;
    
}

- (void) refreshUIForSubscription {
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    isUserSubscribed = [[responseData valueForKey:@"Sub_active"] intValue];
    
    if (isUserSubscribed) {
        
        
        menuItemsArray=[[NSArray alloc]initWithObjects:@"My Details", @"My Adverts", @"Search for a Carer", @"Featured Carers", @"Last Minute Care", @"Messages", @"Information", @"Contact Us", @"Logout", nil];
        menuItemsArrayForCarer=[[NSArray alloc]initWithObjects:@"My Details", @"My Profiles", @"Search Jobs", @"Messages", @"Information", @"Contact Us", @"Logout", nil];
        menuImageArray = [[NSArray alloc]initWithObjects:@"ic_avatar",@"ic_avatar",@"ic_search",@"ic_search",@"ic_search",@"ic_email",@"info_icon",@"ic_email",@"logout",nil];
        menuImageArrayForCarer = [[NSArray alloc]initWithObjects:@"ic_avatar",@"ic_avatar",@"ic_search",@"ic_email",@"info_icon",@"ic_email",@"logout",nil];
        sectionArr = [[NSMutableArray alloc] init];
        
        if ([[SharedClass sharedInstance] isUserCarer]) {
            for (int i = 0; i<menuItemsArrayForCarer.count; i++) {
                
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuSectionView" owner:self options:nil];
                SideMenuSectionView *header = [topLevelObjects objectAtIndex:0];
                header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
                header.menuImage.image = [UIImage imageNamed:[menuImageArrayForCarer objectAtIndex:i]];
                header.menuTitle.text = [menuItemsArrayForCarer objectAtIndex:i];
                [sectionArr addObject:header];
                
            }
            _tblViewHeightConstraint.constant = sectionHeight * menuItemsArrayForCarer.count;
        }
        else {
            for (int i = 0; i<menuItemsArray.count; i++) {
                
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuSectionView" owner:self options:nil];
                SideMenuSectionView *header = [topLevelObjects objectAtIndex:0];
                header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
                header.menuImage.image = [UIImage imageNamed:[menuImageArray objectAtIndex:i]];
                header.menuTitle.text = [menuItemsArray objectAtIndex:i];
                [sectionArr addObject:header];
                
            }
            _tblViewHeightConstraint.constant = sectionHeight * menuItemsArray.count;
        }
        
        
    }
    else {
        menuItemsArray=[[NSArray alloc]initWithObjects:@"My Details", @"My Adverts", @"Search for a Carer", @"Featured Carers", @"Last Minute Care", @"Subscribe Now", @"Messages", @"Information", @"Contact Us", @"Logout", nil];
        menuItemsArrayForCarer=[[NSArray alloc]initWithObjects:@"My Details", @"My Profiles", @"Search Jobs", @"Upgrade", @"Messages", @"Information", @"Contact Us", @"Logout", nil];
        menuImageArray = [[NSArray alloc]initWithObjects:@"ic_avatar",@"ic_avatar",@"ic_search",@"ic_search",@"ic_search",@"news_icon",@"ic_email",@"info_icon",@"ic_email",@"logout",nil];
        menuImageArrayForCarer = [[NSArray alloc]initWithObjects:@"ic_avatar",@"ic_avatar",@"ic_search",@"news_icon",@"ic_email",@"info_icon",@"ic_email",@"logout",nil];
        sectionArr = [[NSMutableArray alloc] init];
        
        if ([[SharedClass sharedInstance] isUserCarer]) {
            for (int i = 0; i<menuItemsArrayForCarer.count; i++) {
                
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuSectionView" owner:self options:nil];
                SideMenuSectionView *header = [topLevelObjects objectAtIndex:0];
                header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
                header.menuImage.image = [UIImage imageNamed:[menuImageArrayForCarer objectAtIndex:i]];
                header.menuTitle.text = [menuItemsArrayForCarer objectAtIndex:i];
                [sectionArr addObject:header];
                
            }
            _tblViewHeightConstraint.constant = sectionHeight * menuItemsArrayForCarer.count;
        }
        else {
            for (int i = 0; i<menuItemsArray.count; i++) {
                
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuSectionView" owner:self options:nil];
                SideMenuSectionView *header = [topLevelObjects objectAtIndex:0];
                header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
                header.menuImage.image = [UIImage imageNamed:[menuImageArray objectAtIndex:i]];
                header.menuTitle.text = [menuItemsArray objectAtIndex:i];
                [sectionArr addObject:header];
                
            }
            _tblViewHeightConstraint.constant = sectionHeight * menuItemsArray.count;
        }

    }
    
    [_sideMenuTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return sectionArr.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isUserSubscribed) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            switch (section) {
                case 4:
                    return 3;
                    break;
                default:
                    break;
            }
        }
        else {
            switch (section) {
                case 6:
                    return 3;
                    break;
                default:
                    break;
            }
        }
    }
    else {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            switch (section) {
                case 5:
                    return 3;
                    break;
                default:
                    break;
            }
        }
        else {
            switch (section) {
                case 7:
                    return 3;
                    break;
                default:
                    break;
            }
        }
    }
    
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SideMenuTableViewCell";
    SideMenuTableViewCell *cell = (SideMenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
}

-(void)willSectionOpen:(NSInteger)section {
    
    
    
}

- (void)willSectionClose:(NSInteger)section {
    
    lastOpenedIndex = -1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row == 0 && indexPath.section == 0) {
//        
//        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
//        
//    }
//    else if (indexPath.row == 1 && indexPath.section == 0) {
//        
//        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
//        
//    }
//    else if (indexPath.section == 1) {
//        
//        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
//        
//    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35.;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    SideMenuSectionView *header = [sectionArr objectAtIndex:section];
    header.messageCounterLabel.hidden = YES;
    
    if (isUserSubscribed) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            
            if (section == 4) {
                header.chevronImgView.hidden = NO;
            }
            else {
                header.chevronImgView.hidden = YES;
            }
            
            if (section == 3) {
                header.messageCounterLabel.hidden = NO;
            }
            else {
                header.messageCounterLabel.hidden = YES;
            }
            
        }
        else {
            
            if (section == 6) {
                header.chevronImgView.hidden = NO;
            }
            else {
                header.chevronImgView.hidden = YES;
            }
            
            if (section == 5) {
                header.messageCounterLabel.hidden = NO;
            }
            else {
                header.messageCounterLabel.hidden = YES;
            }
            
        }

    }
    else {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            
            if (section == 5) {
                header.chevronImgView.hidden = NO;
            }
            else {
                header.chevronImgView.hidden = YES;
            }
            if (section == 3) {
                header.menuTitle.textColor = [UIColor colorWithRed:253./255. green:137./255. blue:8./155. alpha:1.0];
            }
            
            if (section == 4) {
                header.messageCounterLabel.hidden = NO;
            }
            else {
                header.messageCounterLabel.hidden = YES;
            }
            
        }
        else {
            
            if (section == 7) {
                header.chevronImgView.hidden = NO;
            }
            else {
                header.chevronImgView.hidden = YES;
            }
            if (section == 5) {
                header.menuTitle.textColor = [UIColor colorWithRed:253./255. green:137./255. blue:8./155. alpha:1.0];
            }
            
            if (section == 6) {
                header.messageCounterLabel.hidden = NO;
            }
            else {
                header.messageCounterLabel.hidden = YES;
            }
            
        }

    }
    
    
    header.menuTitle.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
    header.messageCounterLabel.text = [[SharedClass sharedInstance] unreadMessageCount];
    header.messageCounterLabel.layer.cornerRadius = 10;
    header.messageCounterLabel.layer.masksToBounds = YES;
    
    return header;
}


- (void) populateContentForAdsCell:(SideMenuTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.userInteractionEnabled = YES;
    cell.tag = (indexPath.section*100) + indexPath.row;
    [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childCellTapped:)]];
    
    if (isUserSubscribed) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            switch (indexPath.section) {
                case 4:
                    if (indexPath.row == 0) {
                        cell.menuTitle.text = @"Information";
                    }
                    else if (indexPath.row == 1) {
                        cell.menuTitle.text = @"Membership";
                    }
                    else {
                        cell.menuTitle.text = @"Password";
                    }
                    break;
                default:
                    break;
            }
        }
        else {
            switch (indexPath.section) {
                case 6:
                    if (indexPath.row == 0) {
                        cell.menuTitle.text = @"Information";
                    }
                    else if (indexPath.row == 1) {
                        cell.menuTitle.text = @"Membership";
                    }
                    else {
                        cell.menuTitle.text = @"Password";
                    }
                    break;
                default:
                    break;
            }
        }

    }
    else {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            switch (indexPath.section) {
                case 5:
                    if (indexPath.row == 0) {
                        cell.menuTitle.text = @"Information";
                    }
                    else if (indexPath.row == 1) {
                        cell.menuTitle.text = @"Membership";
                    }
                    else {
                        cell.menuTitle.text = @"Password";
                    }
                    break;
                default:
                    break;
            }
        }
        else {
            switch (indexPath.section) {
                case 7:
                    if (indexPath.row == 0) {
                        cell.menuTitle.text = @"Information";
                    }
                    else if (indexPath.row == 1) {
                        cell.menuTitle.text = @"Membership";
                    }
                    else {
                        cell.menuTitle.text = @"Password";
                    }
                    break;
                default:
                    break;
            }
        }

    }
    
}

-(void)didTapOnSectionHeader:(NSInteger)section {
    
    SideMenuSectionView *header = [sectionArr objectAtIndex:section];
    
    if (lastOpenedIndex>-1 && lastOpenedIndex!=section) {
        SideMenuSectionView *openedHeader = [sectionArr objectAtIndex:lastOpenedIndex];
        [UIView animateWithDuration:0.3 animations:^{
            openedHeader.chevronImgView.transform = CGAffineTransformRotate(openedHeader.chevronImgView.transform, M_PI);
        }];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        header.chevronImgView.transform = CGAffineTransformRotate(header.chevronImgView.transform, M_PI);
    }];
    
    lastOpenedIndex = section;
    
    if (isUserSubscribed) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            
            if (section == 0) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 1) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 2) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 3) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ChatListViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 5) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ContactUsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 6) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [[SharedClass sharedInstance] setIsGuestUser:NO];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Userid"];
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUserCarer"];
                    [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                    [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                    [[SharedClass sharedInstance] setUserId:nil];
                    [[SharedClass sharedInstance] setAuthorizationKey:nil];
                    [[SharedClass sharedInstance] setIsUserCarer:NO];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEditProfileMenuButtonHidden"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isProfileUpdated"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            
        }
        else {
            
            if (section == 0) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileParentViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 1) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 2) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 3) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:YES];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 4) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:YES];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 5) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ChatListViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 7) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ContactUsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 8) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [[SharedClass sharedInstance] setIsGuestUser:NO];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Userid"];
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUserCarer"];
                    [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                    [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                    [[SharedClass sharedInstance] setUserId:nil];
                    [[SharedClass sharedInstance] setAuthorizationKey:nil];
                    [[SharedClass sharedInstance] setIsUserCarer:NO];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEditProfileMenuButtonHidden"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isProfileUpdated"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            
        }

    }
    else {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            
            if (section == 0) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 1) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 2) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 3) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"FeaturedCarerViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 4) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ChatListViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 6) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ContactUsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 7) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [[SharedClass sharedInstance] setIsGuestUser:NO];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Userid"];
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUserCarer"];
                    [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                    [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                    [[SharedClass sharedInstance] setUserId:nil];
                    [[SharedClass sharedInstance] setAuthorizationKey:nil];
                    [[SharedClass sharedInstance] setIsUserCarer:NO];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEditProfileMenuButtonHidden"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isProfileUpdated"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            
        }
        else {
            
            if (section == 0) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileParentViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 1) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 2) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 3) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:YES];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 4) {
                [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:YES];
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 5) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"BuyPlansForParentsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 6) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ChatListViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 8) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ContactUsViewController" forSideMenuController:self.sideMenuController];
            }
            else if (section == 9) {
                if ([[SharedClass sharedInstance] isGuestUser]) {
                    [[SharedClass sharedInstance] setIsGuestUser:NO];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Userid"];
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUserCarer"];
                    [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
                    [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
                    [[SharedClass sharedInstance] setUserId:nil];
                    [[SharedClass sharedInstance] setAuthorizationKey:nil];
                    [[SharedClass sharedInstance] setIsUserCarer:NO];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEditProfileMenuButtonHidden"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isProfileUpdated"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            
        }

    }
    
}

- (void) childCellTapped:(UITapGestureRecognizer *)gesture {
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else {
        int tag = (int)gesture.view.tag;
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:(tag%100) inSection:(tag/100)];
        
        
        if (indexPath.row == 0 ) {
            
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"FAQViewController" forSideMenuController:self.sideMenuController];
            
        }
        else if (indexPath.row == 1 ) {
            
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"MembershipFAQViewController" forSideMenuController:self.sideMenuController];
            
        }
        else if (indexPath.row == 2 ) {
            
            [[SharedClass sharedInstance] setIsChangePasswordOpenedFromSideMenu:YES];
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ChangePasswordViewController" forSideMenuController:self.sideMenuController];
            
        }

    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
