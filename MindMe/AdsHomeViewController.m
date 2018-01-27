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
    else {
        [self startGetAdvertsService];
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
    
    return advertsArr.count;
    
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
    
    cell.drivingLicenseImgView.hidden = YES;
    cell.euImgView.hidden = YES;
    cell.lastLoginLabel.hidden = YES;
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        cell.yearsExperienceStaticLabel.text = @"Years of Experience needed :";
    }
    else {
        cell.yearsExperienceStaticLabel.text = @"Years of Experience ";
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"second_name"]];
    cell.locationLabel.text = [[advertsArr objectAtIndex:indexPath.row] valueForKey:@"address1"];
    cell.careTypeLabel.text = [[advertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"];
    cell.experienceValueLabel.text = [NSString stringWithFormat:@"%@ yrs minimum",[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"experience"]];
    cell.descLabel.text = [[advertsArr objectAtIndex:indexPath.row] valueForKey:@"love_optional"];
    
    if (![[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"image_path"] isEqualToString:@""]) {
        __weak UIImageView* weakImageView = cell.profileImgView;
        [cell.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceURL,[[advertsArr objectAtIndex:indexPath.row] valueForKey:@"image_path"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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

#pragma mark - API Helpers

- (void) startGetAdvertsService {
    
    [SVProgressHUD showWithStatus:@"Fetching data"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetAllHomeAdverts;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetPostedAdverts]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetAllHomeAdverts]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Data refreshed successfully"];
        
        if ([[responseData valueForKey:@"message"] isKindOfClass:[NSArray class]]) {
            advertsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
        }
        
        [_advertTblView reloadData];
        
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
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        
        [dict setObject:@"53.3664257" forKey:@"lat"];
        [dict setObject:@"-6.0769125" forKey:@"long"];
        [dict setObject:@"Dublin, Ireland" forKey:@"address"];
        
    }
    else {
        
        NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetails"];
        NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
        
        [dict setObject:[responseData valueForKey:@"latitude"] forKey:@"lat"];
        [dict setObject:[responseData valueForKey:@"longitude"] forKey:@"long"];
        [dict setObject:[responseData valueForKey:@"address1"] forKey:@"address"];
        
    }
    
    return dict;
    
}


@end
