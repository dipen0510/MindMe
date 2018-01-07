//
//  AdsHomeViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AdsHomeViewController.h"
#import "AdsHomeTableViewCell.h"
#import "DrivingLicenseInfoViewController.h"
#import "FilterViewController.h"
#import "ActionSheetPicker.h"

@interface AdsHomeViewController () {
    DrivingLicenseInfoViewController *drivingInfoViewController;
    FilterViewController* filterViewController;
    UIView* blackBgView;
}

@end

@implementation AdsHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _favoritesView.userInteractionEnabled = YES;
    [_favoritesView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favoritesViewTapped)]];
    
    _messagesView.userInteractionEnabled = YES;
    [_messagesView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messagesViewTapped)]];
    
    _carerTypeTFTopConstraint.constant = (13./667)*[UIScreen mainScreen].bounds.size.height;
    _carerTypeTFLeadingConstraint.constant = (12./375)*[UIScreen mainScreen].bounds.size.width;
    
    if ([[SharedClass sharedInstance] isEditProfileMenuButtonHidden]) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
        }
        else {
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileParentViewController" forSideMenuController:self.sideMenuController];
        }

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AdsHomeTableViewCell";
    AdsHomeTableViewCell *cell = (AdsHomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AdsHomeTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"showAdsDetailSegue" sender:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200;
    
}


- (void) populateContentForAdsCell:(AdsHomeTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.drivingLicenseImgView.userInteractionEnabled = YES;
    [cell.drivingLicenseImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drivingLicenseImgViewTapped)]];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        cell.yearsExperienceStaticLabel.text = @"Years of Experience needed :";
    }
    else {
        cell.yearsExperienceStaticLabel.text = @"Years of Experience ";
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

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}

- (IBAction)filterButtonTapped:(id)sender {
    
    filterViewController = [[FilterViewController alloc] init];
    filterViewController.view.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 140);
    [filterViewController.applyButton addTarget:self action:@selector(closeFilterView) forControlEvents:UIControlEventTouchUpInside];
    
    blackBgView = [[UIView alloc] initWithFrame:self.view.frame];
    blackBgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    blackBgView.userInteractionEnabled = YES;
    [blackBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeFilterView)]];
    
    [self addChildViewController:filterViewController];
    [filterViewController didMoveToParentViewController:self];
    
    [self.view addSubview:blackBgView];
    [self.view addSubview:filterViewController.view];
    
}

- (void) favoritesViewTapped {
    
    if (![[SharedClass sharedInstance] isGuestUser]) {
        [self performSegueWithIdentifier:@"showFavoritesSegue" sender:nil];
    }
    else {
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) messagesViewTapped {
    
    if (![[SharedClass sharedInstance] isGuestUser]) {
        [self performSegueWithIdentifier:@"showChatSegue" sender:nil];
    }
    else {
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) closeFilterView {
    
    [filterViewController.view removeFromSuperview];
    [blackBgView removeFromSuperview];
    
}

#pragma mark - Driving License Info Helpers

- (void) drivingLicenseImgViewTapped {
    
    drivingInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DrivingLicenseInfoViewController"];
    drivingInfoViewController.view.frame = self.view.bounds;
    [self.view addSubview:drivingInfoViewController.view];
    
}



- (IBAction)carerTypeButtonTapped:(id)sender {
    
    NSArray *colors = [NSArray arrayWithObjects:@"AU Pairs", @"Babysitters", @"Childminders", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@""
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           _carerTypeTextField.text = selectedValue;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
}
@end
