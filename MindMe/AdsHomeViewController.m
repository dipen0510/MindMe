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

@interface AdsHomeViewController () {
    DrivingLicenseInfoViewController *drivingInfoViewController;
}

@end

@implementation AdsHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200;
    
}


- (void) populateContentForAdsCell:(AdsHomeTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.drivingLicenseImgView.userInteractionEnabled = YES;
    [cell.drivingLicenseImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drivingLicenseImgViewTapped)]];
    
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

#pragma mark - Driving License Info Helpers

- (void) drivingLicenseImgViewTapped {
    
    drivingInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DrivingLicenseInfoViewController"];
    drivingInfoViewController.view.frame = self.view.bounds;
    [self.view addSubview:drivingInfoViewController.view];
    
}



@end
