//
//  EditProfileParentViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "EditProfileParentViewController.h"
#import "ProfileActivitiesCollectionViewCell.h"
#import "ProfileAvailabilityCollectionViewCell.h"

@interface EditProfileParentViewController ()<UITextFieldDelegate> {
    NSString* latLong;
    NSMutableArray* googleResponseArr;
}

@end

@implementation EditProfileParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupProfileDetails];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    [self startGetProfileDetailsService];
    
}

- (void) setupInitialUI {
    
    _doneButton.layer.cornerRadius = 17.5;
    _doneButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 17.5;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [_contentScrollView addGestureRecognizer:tapGesture];
    
    googleResponseArr = [[NSMutableArray alloc] init];
    
    _eirCodeTextField.delegate = self;
    _addressTextField.delegate = self;
    
    _phonetextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _addressView.hidden = YES;
    _menuButton.hidden = [[NSUserDefaults standardUserDefaults] boolForKey:@"isEditProfileMenuButtonHidden"];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isEditProfileMenuButtonHidden"]) {
        _tncButton.selected = YES;
    }
    
    _doneButton.titleLabel.font = _cancelButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(15./667)*kScreenHeight];
    
    _regionStaticLabel.font = _eircodeStaticLabel.font = _cityStaticLabel.font = _addressStaticLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(15./667)*kScreenHeight];
    
    _firstNameTextField.font = _lastNameTextField.font = _phonetextField.font = _emailTextField.font = _eirCodeTextField.font = _addressTextField.font = _option1StaticLabel.font = _option2StaticLabel.font = _option3StaticLabel.font = _option4StaticLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(15./667)*kScreenHeight];
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(17./667)*kScreenHeight];
    
    [_option1StaticLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(option1StaticLabelTapped)]];
    _option1StaticLabel.userInteractionEnabled = YES;
    
    [_option2StaticLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(option2StaticLabelTapped)]];
    _option2StaticLabel.userInteractionEnabled = YES;
    
    [_option3StaticLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(option3StaticLabelTapped)]];
    _option3StaticLabel.userInteractionEnabled = YES;
    
    [_option4StaticLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(option4StaticLabelTapped)]];
    _option4StaticLabel.userInteractionEnabled = YES;
    
}

- (void) setupProfileDetails {
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetails"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    if ([responseData valueForKey:@"first_name"] && ![[responseData valueForKey:@"first_name"] isEqual:[NSNull null]]) {
        _firstNameTextField.text = [responseData valueForKey:@"first_name"];
    }
    else {
        _firstNameTextField.text = @"";
    }
    
    if ([responseData valueForKey:@"second_name"] && ![[responseData valueForKey:@"second_name"] isEqual:[NSNull null]]) {
        _lastNameTextField.text = [responseData valueForKey:@"second_name"];
    }
    else {
        _lastNameTextField.text = @"";
    }
    
    if ([responseData valueForKey:@"mobile_number"] && ![[responseData valueForKey:@"mobile_number"] isEqual:[NSNull null]]) {
        _phonetextField.text = [responseData valueForKey:@"mobile_number"];
    }
    else {
        _phonetextField.text = @"";
    }
    
    if ([responseData valueForKey:@"user_email"] && ![[responseData valueForKey:@"user_email"] isEqual:[NSNull null]]) {
        _emailTextField.text = [responseData valueForKey:@"user_email"];
    }
    else {
        _emailTextField.text = @"";
    }
    
    if ([responseData valueForKey:@"eircode"] && ![[responseData valueForKey:@"eircode"] isEqual:[NSNull null]]) {
        _eirCodeTextField.text = [responseData valueForKey:@"eircode"];
    }
    else {
        _eirCodeTextField.text = @"";
    }
    
    if ([responseData valueForKey:@"address1"] && ![[responseData valueForKey:@"address1"] isEqual:[NSNull null]]) {
        _addressTextField.text = [responseData valueForKey:@"address1"];
    }
    else {
        _addressTextField.text = @"";
    }
    
    latLong = [NSString stringWithFormat:@"%@,%@",[responseData valueForKey:@"latitude"], [responseData valueForKey:@"longitude"]] ;
    
    if ([responseData valueForKey:@"promotions"] && ![[responseData valueForKey:@"promotions"] isEqual:[NSNull null]]) {
        if ([[responseData valueForKey:@"promotions"] isEqualToString:@"1"]) {
            _receiveEmailButton.selected = YES;
        }
        else {
            _receiveEmailButton.selected = NO;
        }
    }
    else {
        _receiveEmailButton.selected = NO;
    }
    
    if ([responseData valueForKey:@"sms"] && ![[responseData valueForKey:@"sms"] isEqual:[NSNull null]]) {
        if ([[responseData valueForKey:@"sms"] isEqualToString:@"1"]) {
            _receiveSMSButton.selected = YES;
        }
        else {
            _receiveSMSButton.selected = NO;
        }
    }
    else {
        _receiveSMSButton.selected = NO;
    }
    
    if ([responseData valueForKey:@"job_alerts"] && ![[responseData valueForKey:@"job_alerts"] isEqual:[NSNull null]]) {
        if ([[responseData valueForKey:@"job_alerts"] isEqualToString:@"1"]) {
            _mailNotifButton.selected = YES;
        }
        else {
            _mailNotifButton.selected = NO;
        }
    }
    else {
        _mailNotifButton.selected = NO;
    }
    
    
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

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}

- (IBAction)miscOptionButtonTapped:(id)sender {
    
    UIButton* tappedButton = (UIButton *)sender;
    tappedButton.selected = !tappedButton.isSelected;
    
}

- (void) option1StaticLabelTapped {
    
    _receiveEmailButton.selected = !_receiveEmailButton.isSelected;
    
}

- (void) option2StaticLabelTapped {
    
    _mailNotifButton.selected = !_mailNotifButton.isSelected;
    
}

- (void) option3StaticLabelTapped {
    
    _tncButton.selected = !_tncButton.isSelected;
    
}

- (void) option4StaticLabelTapped {
    
    _receiveSMSButton.selected = !_receiveSMSButton.isSelected;
    
}

- (IBAction)doneButtonTapped:(id)sender {
    
    if (!_tncButton.isSelected) {
        [SVProgressHUD showErrorWithStatus:@"Please accept Terms & Conditions to continue"];
        
    }
    else if (!latLong || [latLong isEqualToString:@""] || [_addressTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"Please enter a valid Eircode or Address"];
        
    }
    else if ([_phonetextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"Please enter a valid Phone Number"];
    }
    else {
       [self startUpdateProfileService];
    }
    
}

- (void) dismissKeyboard {
    
    [self.view endEditing:YES];
    _addressView.hidden = YES;
    
}

#pragma mark - API Helpers

- (void) startGetProfileDetailsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Profile Details"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetUserPersonalDetails;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetProfileDetails]];
    
}

- (void) startUpdateProfileService {
    
    [SVProgressHUD showWithStatus:@"Updating Profile Details"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = UpdateParentPersonalDetails;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForUpdateParentDetails]];
    
}

- (void) startGoogleMapsGeocodeAPIWithParam:(NSString *)params {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GoogleAPIGeocode;
    manager.delegate = self;
    [manager startGoogleAPIGeocodeWebService:params];
    
}

- (void) startGoogleMapsGeocodeAPIWithAddressParam:(NSString *)params {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GoogleAPIAddressGeocode;
    manager.delegate = self;
    [manager startGoogleAPIGeocodeWebService:params];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    
    if ([requestServiceKey isEqualToString:GetUserPersonalDetails]) {
        
        _firstNameTextField.text = [[[[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"full_name"] componentsSeparatedByString:@" "] firstObject];
        _lastNameTextField.text = [[[[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"full_name"] componentsSeparatedByString:@" "] lastObject];
        _phonetextField.text = [[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"tel"];
        _emailTextField.text = [[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"user_email"];
        _eirCodeTextField.text = @"";
        _addressTextField.text = [[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"address"];
        
    }
    
    if ([requestServiceKey isEqualToString:UpdateParentPersonalDetails]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Profile updated successfully"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProfileUpdated"];
        
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isEditProfileMenuButtonHidden"]) {
            [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
//        }
        
    }
    
    if ([requestServiceKey isEqualToString:GoogleAPIGeocode]) {
        
        googleResponseArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"results"]];
        _addressView.hidden = YES;
        
        if (googleResponseArr.count > 0) {
            _addressTextField.text = [[[[googleResponseArr objectAtIndex:0] valueForKey:@"address_components"] valueForKey:@"short_name"] componentsJoinedByString:@", "];
            latLong = [NSString stringWithFormat:@"%@,%@",[[[[googleResponseArr objectAtIndex:0] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"], [[[[googleResponseArr objectAtIndex:0] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"]] ;
        }
        else if (googleResponseArr.count == 0){
            _addressTextField.text = @"";
            latLong = [NSString stringWithFormat:@""];
        }
        
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

- (NSMutableDictionary *) prepareDictionaryForGetProfileDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForUpdateParentDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_firstNameTextField.text forKey:@"first_name"];
    [dict setObject:_lastNameTextField.text forKey:@"second_name"];
    [dict setObject:_phonetextField.text forKey:@"mobile_number"];
    [dict setObject:_addressTextField.text forKey:@"location"];
    [dict setObject:[NSString stringWithFormat:@"%d",_receiveEmailButton.isSelected] forKey:@"promotions"];
    [dict setObject:[NSString stringWithFormat:@"%d",_mailNotifButton.isSelected] forKey:@"job_alerts"];
    [dict setObject:[NSString stringWithFormat:@"%d",_receiveSMSButton.isSelected] forKey:@"sms"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] firstObject] forKey:@"lati"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] lastObject] forKey:@"longi"];
    [dict setObject:_emailTextField.text forKey:@"email"];
    
    if (_eirCodeTextField.text && ![_eirCodeTextField.text isEqualToString:@""]) {
        [dict setObject:_addressTextField.text forKey:@"eircode_address"];
        [dict setObject:_eirCodeTextField.text forKey:@"eircode"];
    }
    else {
        [dict setObject:@"" forKey:@"eircode_address"];
        [dict setObject:@"" forKey:@"eircode"];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"profileDetails"];
    
    [self convertAndUpdateUserDetails];
    
    return dict;
    
}

- (void) convertAndUpdateUserDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_firstNameTextField.text forKey:@"first_name"];
    [dict setObject:_lastNameTextField.text forKey:@"second_name"];
    [dict setObject:_phonetextField.text forKey:@"mobile_number"];
    [dict setObject:_addressTextField.text forKey:@"address1"];
    [dict setObject:[NSString stringWithFormat:@"%d",_receiveEmailButton.isSelected] forKey:@"promotions"];
    [dict setObject:[NSString stringWithFormat:@"%d",_mailNotifButton.isSelected] forKey:@"job_alerts"];
    [dict setObject:[NSString stringWithFormat:@"%d",_receiveSMSButton.isSelected] forKey:@"sms"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] firstObject] forKey:@"latitude"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] lastObject] forKey:@"longitude"];
    [dict setObject:_emailTextField.text forKey:@"user_email"];
    [dict setObject:@"0" forKey:@"birth_day"];
    [dict setObject:@"0" forKey:@"birth_month"];
    [dict setObject:@"0" forKey:@"birth_year"];
    [dict setObject:@"0" forKey:@"age"];
    
    if (_eirCodeTextField.text && ![_eirCodeTextField.text isEqualToString:@""]) {
        [dict setObject:_addressTextField.text forKey:@"eircode_address"];
        [dict setObject:_eirCodeTextField.text forKey:@"eircode"];
    }
    else {
        [dict setObject:@"" forKey:@"eircode_address"];
        [dict setObject:@"" forKey:@"eircode"];
    }
    
    [dict setObject:@"1" forKey:@"gender"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"profileDetails"];
    
}

#pragma mark - UITextField Delegate 

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField == _eirCodeTextField) {
        [self startGoogleMapsGeocodeAPIWithParam:[_eirCodeTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField ==_addressTextField) {
        [self startGoogleMapsGeocodeAPIWithAddressParam:[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return YES;
    
}

#pragma mark - UITableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return googleResponseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     *   This is an important bit, it asks the table view if it has any available cells
     *   already created which it is not using (if they are offScreen), so that it can
     *   reuse them (saving the time of alloc/init/load from xib a new cell ).
     *   The identifier is there to differentiate between different types of cells
     *   (you can display different types of cells in the same table view)
     */
    
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
    
    
    /* Now that the cell is configured we return it to the table view so that it can display it */
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _addressTextField.text = [[[[googleResponseArr objectAtIndex:indexPath.row] valueForKey:@"address_components"] valueForKey:@"short_name"] componentsJoinedByString:@", "];
    latLong = [NSString stringWithFormat:@"%@,%@",[[[[googleResponseArr objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"], [[[[googleResponseArr objectAtIndex:indexPath.row] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"]] ;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

@end
