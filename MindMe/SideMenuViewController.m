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

@interface SideMenuViewController ()<STCollapseTableViewDelegate> {
    int sectionHeight;
}

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    if ([UIScreen mainScreen].bounds.size.height<667) {
        sectionHeight = 60;
    }
    else {
        sectionHeight = 70;
    }
    
    lastOpenedIndex = -1;
    menuItemsArray=[[NSArray alloc]initWithObjects:@"Account Details", @"Search for a Carer", @"Subscribe Now", @"Information", @"Contact", @"Logout", nil];
    menuImageArray = [[NSArray alloc]initWithObjects:@"ic_avatar",@"ic_search",@"news_icon",@"info_icon",@"ic_email",@"ic_email",nil];
    sectionArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<menuItemsArray.count; i++) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SideMenuSectionView" owner:self options:nil];
        SideMenuSectionView *header = [topLevelObjects objectAtIndex:0];
        header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
        header.menuImage.image = [UIImage imageNamed:[menuImageArray objectAtIndex:i]];
        header.menuTitle.text = [menuItemsArray objectAtIndex:i];
        [sectionArr addObject:header];
        
    }
    
    _sideMenuTableView.delegate1 = self;
    
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
    
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 3:
            return 3;
            break;
        default:
            break;
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
    
    if (section == 2) {
        
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"FeaturedCarerViewController" forSideMenuController:self.sideMenuController];
        
    }
    else if (section == 4) {
        
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"ContactUsViewController" forSideMenuController:self.sideMenuController];
        
    }
    
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
    
    return 40.;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    SideMenuSectionView *header = [sectionArr objectAtIndex:section];
    if (section == 0 || section == 1 || section == 3) {
        header.chevronImgView.hidden = NO;
    }
    else {
        header.chevronImgView.hidden = YES;
    }
    
    if (section == 2) {
        header.menuTitle.textColor = [UIColor colorWithRed:253./255. green:137./255. blue:8./155. alpha:1.0];
    }
    
    return header;
}


- (void) populateContentForAdsCell:(SideMenuTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.userInteractionEnabled = YES;
    cell.tag = (indexPath.section*100) + indexPath.row;
    [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childCellTapped:)]];
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.menuTitle.text = @"Personal Details";
            }
            else {
                cell.menuTitle.text = @"Adverts";
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                cell.menuTitle.text = @"Carers";
            }
            else if (indexPath.row == 1) {
                cell.menuTitle.text = @"Featured Carers";
            }
            else {
                cell.menuTitle.text = @"Last Minute Care";
            }
            break;
        case 3:
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

- (void) childCellTapped:(UITapGestureRecognizer *)gesture {
    
    int tag = (int)gesture.view.tag;
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:(tag%100) inSection:(tag/100)];
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
        
    }
    else if (indexPath.row == 1 && indexPath.section == 0) {
        
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
        
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"FeaturedAdsViewController" forSideMenuController:self.sideMenuController];
        }
        else {
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
        }
        
        
    }
    else if (indexPath.row == 0 && indexPath.section == 3) {
        
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"FAQViewController" forSideMenuController:self.sideMenuController];
        
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
