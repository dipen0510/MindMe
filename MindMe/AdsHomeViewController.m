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
#import "AdsDetailViewController.h"
#import "FilterMiscTableViewCell.h"

@interface AdsHomeViewController () {
    DrivingLicenseInfoViewController *drivingInfoViewController;
    FilterViewController* filterViewController;
    UIView* blackBgView;
    NSString* latLong;
    NSMutableArray* googleResponseArr;
    
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
    
    _profileView.userInteractionEnabled = YES;
    [_profileView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileViewTapped)]];
    
    _carerTypeTFTopConstraint.constant = (13./667)*[UIScreen mainScreen].bounds.size.height;
    _carerTypeTFLeadingConstraint.constant = (12./375)*[UIScreen mainScreen].bounds.size.width;
    
    if ([[SharedClass sharedInstance] isFeaturedFilterApplied] || [[SharedClass sharedInstance] isLastMinuiteCareFilterApplied]) {
        _advertTblViewTopConstraint.constant = 0.0;
    }
    else {
        _advertTblViewTopConstraint.constant = 50.0;
    }
    
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
    
    _addressView.hidden = YES;
    _addressTextField.delegate = self;
    
}

- (void) dismissKeyboard {
    
    [self.view endEditing:YES];
    _addressView.hidden = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        
        [self.view endEditing:YES];
        _addressView.hidden = YES;
        
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
    
    if (tableView == _addressTblView) {
        return googleResponseArr.count;
    }
    
    return filteredAdvertsArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _addressTblView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
        
        /*
         *   If the cell is nil it means no cell was available for reuse and that we should
         *   create a new one.
         */
        if (cell == nil) {
            
            /*
             *   Actually create a new cell (with an identifier so that it can be dequeued).
             */
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        /*
         *   Now that we have a cell we can configure it to display the data corresponding to
         *   this row/section
         */
        
        cell.textLabel.text = [[[[googleResponseArr objectAtIndex:indexPath.row] valueForKey:@"address_components"] valueForKey:@"short_name"] componentsJoinedByString:@", "];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressCellTapped:)]];
        cell.tag = indexPath.row;
        
        
        /* Now that the cell is configured we return it to the table view so that it can display it */
        
        return cell;

        
    }
    
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
    
    if (tableView == _addressTblView) {
        _addressTextField.text = [[[[googleResponseArr objectAtIndex:indexPath.row] valueForKey:@"address_components"] valueForKey:@"short_name"] componentsJoinedByString:@", "];
        latLong = [NSString stringWithFormat:@"%@,%@",[[[[googleResponseArr objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"], [[[[googleResponseArr objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"]] ;
    }
    else {
        selectedAdvertDict = [[NSMutableDictionary alloc] initWithDictionary:[filteredAdvertsArr objectAtIndex:indexPath.row]];
        [self performSegueWithIdentifier:@"showAdsDetailSegue" sender:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _addressTblView) {
        return 30.0;
    }
    
    return 200;
    
}

- (void) addressCellTapped:(UITapGestureRecognizer *)gesture {
    
    int index = (int)gesture.view.tag;
    
    _addressTextField.text = [[[[googleResponseArr objectAtIndex:index] valueForKey:@"address_components"] valueForKey:@"short_name"] componentsJoinedByString:@", "];
    latLong = [NSString stringWithFormat:@"%@,%@",[[[[googleResponseArr objectAtIndex:index] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"], [[[[googleResponseArr objectAtIndex:index] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"]] ;
    
    [self filterAdvertsForLocation];
    [_advertTblView reloadData];
    
    [self dismissKeyboard];
    
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
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@.",[[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"second_name"] substringToIndex:1]];
    cell.locationLabel.text = [[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"address1"];
    cell.careTypeLabel.text = [[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"care_type"];
    cell.experienceValueLabel.text = [NSString stringWithFormat:@"%@ years",[[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"experience"]];
    cell.descLabel.text = [[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"about_you"];
    
    if (![[[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"image_path"] isEqualToString:@""]) {
        __weak UIImageView* weakImageView = cell.profileImgView;
        [cell.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceURL,[[filteredAdvertsArr objectAtIndex:indexPath.row] valueForKey:@"image_path"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showAdsDetailSegue"]) {
        
        AdsDetailViewController* controller = (AdsDetailViewController *)[segue destinationViewController];
        controller.advertDict = selectedAdvertDict;
        
    }
    
}

#pragma mark - User Interaction Methods

- (IBAction)menuButtonTapped:(id)sender {
    
    [self dismissKeyboard];
    [self.sideMenuController showLeftViewAnimated];
    
}

- (IBAction)filterButtonTapped:(id)sender {
    
    [self dismissKeyboard];
    
    filterViewController = [[FilterViewController alloc] init];
    filterViewController.view.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 140);
    
    filterViewController.careTypeTextField.delegate = self;
    filterViewController.distanceTextField.delegate = self;
    
    [filterViewController.applyButton addTarget:self action:@selector(filterViewApplyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [filterViewController.primaryApplyButton addTarget:self action:@selector(filterViewApplyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self dismissKeyboard];
    
    NSArray *colors = [NSArray arrayWithObjects:@"All", @"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@""
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           _carerTypeTextField.text = selectedValue;
                                           [self filterAdvertsForCareType:selectedValue];
                                           [_advertTblView reloadData];
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

- (void) startGoogleMapsGeocodeAPIWithAddressParam:(NSString *)params {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GoogleAPIAddressGeocode;
    manager.delegate = self;
    [manager startGoogleAPIGeocodeWebService:params];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetAllHomeAdverts]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Data refreshed successfully"];
        
        if ([[responseData valueForKey:@"message"] isKindOfClass:[NSArray class]]) {
            advertsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
            
            if ([[SharedClass sharedInstance] isLastMinuiteCareFilterApplied]) {
                [self filterAdvertsForlastMinuteCare];
            }
            else if ([[SharedClass sharedInstance] isFeaturedFilterApplied]) {
                [self filterAdvertsForFeatured];
            }
            else {
                filteredAdvertsArr = [[NSMutableArray alloc] initWithArray:advertsArr];
            }
            
        }
        
        [_advertTblView reloadData];
        
    }
    
    if ([requestServiceKey isEqualToString:GoogleAPIAddressGeocode]) {
        
        googleResponseArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"results"]];
        
        if (googleResponseArr.count > 0) {
            _addressView.hidden = NO;
            [_addressTblView reloadData];
        }
        else if (googleResponseArr.count == 0){
            _addressTextField.text = @"";
            latLong = [NSString stringWithFormat:@""];
        }
        
        
        
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


- (void) filterAdvertsForFeatured {
    
    filteredAdvertsArr = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary* advertDict in advertsArr) {
        
        if ([[advertDict valueForKey:@"Sub_active"] intValue] == 1) {
            [filteredAdvertsArr addObject:advertDict];
        }
        
    }
    
}

- (void) filterAdvertsForlastMinuteCare {
    
    filteredAdvertsArr = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary* advertDict in advertsArr) {
        
        if ([[advertDict valueForKey:@"emer"] intValue] == 1) {
            [filteredAdvertsArr addObject:advertDict];
        }
        
    }
    
}

- (void) filterAdvertsForCareType:(NSString *)careType {
    
    filteredAdvertsArr = [[NSMutableArray alloc] init];
    
    if ([careType isEqualToString:@"All"]) {
        filteredAdvertsArr = [[NSMutableArray alloc] initWithArray:advertsArr];
    }
    else {
        for (NSMutableDictionary* advertDict in advertsArr) {
            
            if ([[advertDict valueForKey:@"care_type"] isEqualToString:careType]) {
                [filteredAdvertsArr addObject:advertDict];
            }
            
        }
    }
    
}

- (void) filterAdvertsForLocation {
    
    filteredAdvertsArr = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary* advertDict in advertsArr) {
        
        NSString* advertLocation = [NSString stringWithFormat:@"%@,%@",[advertDict valueForKey:@"latitude"],[advertDict valueForKey:@"longitude"]];
        
        if ([advertLocation isEqualToString:latLong]) {
            [filteredAdvertsArr addObject:advertDict];
        }
        
    }
    
}

- (void) resetAllAdvertsFilter {
    
    if (filteredAdvertsArr.count != advertsArr.count) {
        filteredAdvertsArr = [[NSMutableArray alloc] initWithArray:advertsArr];
        [_advertTblView reloadData];
    }
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField ==_addressTextField) {
        
        if ([string isEqualToString:@""]) {
            if (textField.text.length<=1) {
                [self dismissKeyboard];
                textField.text = @"";
            }
            [self resetAllAdvertsFilter];
        }
        else {
            [self startGoogleMapsGeocodeAPIWithAddressParam:[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    
    }
    
    return YES;
    
}

- (IBAction)filterCarerTypeButtonTapped {
    
    NSArray *colors = [NSArray arrayWithObjects:@"All", @"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@""
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           filterViewController.careTypeTextField.text = selectedValue;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
    
}

- (IBAction)filterDistanceButtonTapped {
    
    NSArray *colors = [NSArray arrayWithObjects:@"0-20 Km", @"0-10 Km", @"0-5 Km", @"0-3 Km", @"0-1 Km", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@""
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           filterViewController.distanceTextField.text = selectedValue;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
    
}

- (void) filterViewApplyButtonTapped {
    
    filteredAdvertsArr = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary* advertDict in advertsArr) {
        
        if ([filterViewController.careTypeTextField.text isEqualToString:@"All"]) {
            [filteredAdvertsArr addObject:advertDict];
        }
        else if ([[advertDict valueForKey:@"care_type"] isEqualToString:filterViewController.careTypeTextField.text]) {
            [filteredAdvertsArr addObject:advertDict];
        }
        
    }
    
    NSMutableArray* tmpAdvertsArr = [[NSMutableArray alloc] initWithArray:filteredAdvertsArr];
    filteredAdvertsArr = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary* advertDict in tmpAdvertsArr) {
        
        NSString* distanceStr = [[[[filterViewController.distanceTextField.text componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"] lastObject];
        
        if ([[advertDict valueForKey:@"distance"] doubleValue] <= [distanceStr doubleValue]) {
            [filteredAdvertsArr addObject:advertDict];
        }
        
    }
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        tmpAdvertsArr = [[NSMutableArray alloc] initWithArray:filteredAdvertsArr];
        filteredAdvertsArr = [[NSMutableArray alloc] init];
        
        for (NSMutableDictionary* advertDict in tmpAdvertsArr) {
            
            float selectedMax = filterViewController.ageSlider.selectedMaximum;
            float selectedMin = filterViewController.ageSlider.selectedMinimum;
            
            NSInteger userAge = [self ageFromYear:[advertDict valueForKey:@"birth_year"] Month:[advertDict valueForKey:@"birth_month"] day:[advertDict valueForKey:@"birth_day"]];
            
            if (userAge>= selectedMin && userAge<= selectedMax) {
                [filteredAdvertsArr addObject:advertDict];
            }
            
        }
    }
    
    
    
    tmpAdvertsArr = [[NSMutableArray alloc] initWithArray:filteredAdvertsArr];
    filteredAdvertsArr = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary* advertDict in tmpAdvertsArr) {
        
        float selectedMax = filterViewController.experienceSlider.selectedMaximum;
        float selectedMin = filterViewController.experienceSlider.selectedMinimum;
        
        int userExp = [[advertDict valueForKey:@"experience"] intValue];
        
        if (userExp>= selectedMin && userExp<= selectedMax) {
            [filteredAdvertsArr addObject:advertDict];
        }
        
    }
    
    if (!filterViewController.isRefineSearchEnabled) {
        tmpAdvertsArr = [[NSMutableArray alloc] initWithArray:filteredAdvertsArr];
        filteredAdvertsArr = [[NSMutableArray alloc] init];
        
        for (NSMutableDictionary* advertDict in tmpAdvertsArr) {
            
            for (int i = 0; i<filterViewController.availabilityArr.count; i++) {
                
                if ([[filterViewController.availabilityArr objectAtIndex:i] intValue]) {
                    NSString* booking = [NSString stringWithFormat:@"%@ %@", [self fullNameForWeekdayAvailabilityIndex:i], [self fullNameForAvailabilityIndex:i]];
                    
                    if ([[advertDict valueForKey:@"booking"] containsString:booking]) {
                        if (![filteredAdvertsArr containsObject:advertDict]) {
                            [filteredAdvertsArr addObject:advertDict];
                        }
                    }
                    
                }
                
            }
            
        }
        
        
        tmpAdvertsArr = [[NSMutableArray alloc] initWithArray:filteredAdvertsArr];
        filteredAdvertsArr = [[NSMutableArray alloc] init];
        
        for (NSMutableDictionary* advertDict in tmpAdvertsArr) {
            
            for (int i = 0; i<filterViewController.caretypeArr.count; i++) {
                
                FilterMiscTableViewCell* cell = (FilterMiscTableViewCell *)[filterViewController.miscTblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                if ([[filterViewController.servicesArr objectAtIndex:i] intValue]) {
                    if ([[advertDict valueForKey:@"services"] containsString:cell.miscLabel.text]) {
                        if (![filteredAdvertsArr containsObject:advertDict]) {
                            [filteredAdvertsArr addObject:advertDict];
                        }
                    }
                }
                
            }
            
        }
    }
    
    
    
    [_advertTblView reloadData];
    [self closeFilterView];
    
}

- (NSInteger)ageFromYear:(NSString *)year Month:(NSString *)month day:(NSString *)day {
    
    NSString* dobStr = [NSString stringWithFormat:@"%@/%@/%@",day,month,year];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSDate* userDoB = [dateFormatter dateFromString:dobStr];
    
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:userDoB
                                       toDate:today
                                       options:0];
    return ageComponents.year;
}

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == filterViewController.careTypeTextField) {
        [self filterCarerTypeButtonTapped];
        return NO;
    }
    if (textField == filterViewController.distanceTextField) {
        [self filterDistanceButtonTapped];
        return NO;
    }
    
    return YES;
    
}

- (NSString *) fullNameForAvailabilityIndex:(int)i {
    
    if (i/8 <= 1) {
        return @"Morning";
    }
    else if (i/8 > 1 && i/8 <= 2) {
        return @"Afternoon";
    }
    else if (i/8 > 2 && i/8 <= 3) {
        return @"Evening";
    }
    else if (i/8 > 3 && i/8 <= 4) {
        return @"Night";
    }
    
    return @"Overnight";
    
}

- (NSString *) fullNameForWeekdayAvailabilityIndex:(int)i {
    
    if (i%8 == 1) {
        return @"Monday";
    }
    else if (i%8 == 2) {
        return @"Tuesday";
    }
    else if (i%8 == 3) {
        return @"Wednesday";
    }
    else if (i%8 == 4) {
        return @"Thursday";
    }
    else if (i%8 == 5) {
        return @"Friday";
    }
    else if (i%8 == 6) {
        return @"Saturday";
    }
    
    return @"Sunday";
    
}

@end
