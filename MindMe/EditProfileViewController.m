//
//  EditProfileViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 22/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ProfileActivitiesCollectionViewCell.h"
#import "ProfileAvailabilityCollectionViewCell.h"
#import "ActionSheetPicker.h"

@interface EditProfileViewController ()<UITextFieldDelegate> {
    NSString* latLong;
    NSMutableArray* googleResponseArr;
}


@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupProfileDetails];
    [self registerForKeyboardNotifications];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    [self startGetProfileDetailsService];
    
}

- (void) setupInitialUI {
    
    _doneButton.layer.cornerRadius = 22.5;
    _doneButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 22.5;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [_contentScrollView addGestureRecognizer:tapGesture];
    
    googleResponseArr = [[NSMutableArray alloc] init];
    
    _eirCodeTextField.delegate = self;
    _addressTextField.delegate = self;
    
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _addressView.hidden = YES;
    _menuButton.hidden = [[SharedClass sharedInstance] isEditProfileMenuButtonHidden];
    
    if (![[SharedClass sharedInstance] isEditProfileMenuButtonHidden]) {
        _tncButton.selected = YES;
    }
    
    _dobTextField.delegate = self;
    
    activeField = [[UITextField alloc] init];
    
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
        _phoneTextField.text = [responseData valueForKey:@"mobile_number"];
    }
    else {
        _phoneTextField.text = @"";
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
    
//    _lastNameTextField.text = [responseData valueForKey:@"second_name"];
//    _phoneTextField.text = [responseData valueForKey:@"mobile_number"];
//    _emailTextField.text = [responseData valueForKey:@"user_email"];
//    _eirCodeTextField.text = [responseData valueForKey:@"eircode"];
//    _addressTextField.text = [responseData valueForKey:@"address1"];
    _dobTextField.text = [NSString stringWithFormat:@"%@-%@-%@",[responseData valueForKey:@"birth_day"],[responseData valueForKey:@"birth_month"],[responseData valueForKey:@"birth_year"]];
    
    latLong = [NSString stringWithFormat:@"%@,%@",[responseData valueForKey:@"latitude"], [responseData valueForKey:@"longitude"]] ;
    
    if ([responseData valueForKey:@"gender"] && ![[responseData valueForKey:@"gender"] isEqual:[NSNull null]]) {
        if ([[responseData valueForKey:@"gender"] isEqualToString:@"1"]) {
            _maleButton.selected = YES;
            _femaleButton.selected = NO;
        }
        else {
            _maleButton.selected = NO;
            _femaleButton.selected = YES;
        }
    }
    else {
        _maleButton.selected = NO;
        _femaleButton.selected = NO;
    }
    
    if ([responseData valueForKey:@"promotions"] && ![[responseData valueForKey:@"promotions"] isEqual:[NSNull null]]) {
        if ([[responseData valueForKey:@"promotions"] isEqualToString:@"1"]) {
            _emailPromotionsButton.selected = YES;
        }
        else {
            _emailPromotionsButton.selected = NO;
        }
    }
    else {
        _emailPromotionsButton.selected = NO;
    }
    
    if ([responseData valueForKey:@"job_alerts"] && ![[responseData valueForKey:@"job_alerts"] isEqual:[NSNull null]]) {
        if ([[responseData valueForKey:@"job_alerts"] isEqualToString:@"1"]) {
            _receiveEmailsButton.selected = YES;
        }
        else {
            _receiveEmailsButton.selected = NO;
        }
    }
    else {
        _receiveEmailsButton.selected = NO;
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

- (IBAction)maleButtonTapped:(id)sender {
    _maleButton.selected = YES;
    _femaleButton.selected = NO;
}

- (IBAction)femaleButtonTapped:(id)sender {
    _maleButton.selected = NO;
    _femaleButton.selected = YES;
}

- (IBAction)miscOptionButtonTapped:(id)sender {
    
    UIButton* tappedButton = (UIButton *)sender;
    tappedButton.selected = !tappedButton.isSelected;
    
}

- (IBAction)doneButtonTapped:(id)sender {
    
    if (!_tncButton.isSelected) {
        [SVProgressHUD showErrorWithStatus:@"Please accept Terms & Conditions to continue"];
        
    }
    else if (!latLong || [latLong isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"Please enter a valid address or Eircode to continue"];
        
    }
    else if ([self calculateAgeFromDateString:_dobTextField.text] < 16) {
        [SVProgressHUD showErrorWithStatus:@"You should be more than 16 years to continue"];
        
    }
    else {
        [self startUpdateProfileService];
    }

    
}

- (void) dobTextFieldTapped {
    
    [ActionSheetDatePicker showPickerWithTitle:@"Select DOB" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        _dobTextField.text = [dateFormatter stringFromDate:selectedDate];
        
        
    }cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
    
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
    manager.serviceKey = UpdateCarerPersonalDetails;
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
        _phoneTextField.text = [[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"tel"];
        _emailTextField.text = [[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"user_email"];
        _eirCodeTextField.text = @"";
        _addressTextField.text = [[[responseData valueForKey:@"message"] objectAtIndex:0] valueForKey:@"address"];
        
    }
    
    if ([requestServiceKey isEqualToString:UpdateCarerPersonalDetails]) {
        
        [[SharedClass sharedInstance] setIsEditProfileMenuButtonHidden:NO];
        _menuButton.hidden = NO;
        
        [SVProgressHUD showSuccessWithStatus:@"Profile updated successfully"];
        
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
    [dict setObject:_phoneTextField.text forKey:@"mobile_number"];
    [dict setObject:_addressTextField.text forKey:@"location"];
    [dict setObject:[NSString stringWithFormat:@"%d",_emailPromotionsButton.isSelected] forKey:@"promotions"];
    [dict setObject:[NSString stringWithFormat:@"%d",_receiveEmailsButton.isSelected] forKey:@"job_alerts"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"sms"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] firstObject] forKey:@"lati"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] lastObject] forKey:@"longi"];
    [dict setObject:_emailTextField.text forKey:@"email"];
    [dict setObject:[[_dobTextField.text componentsSeparatedByString:@"-"] firstObject] forKey:@"bday"];
    [dict setObject:[[_dobTextField.text componentsSeparatedByString:@"-"] objectAtIndex:1] forKey:@"bmonth"];
    [dict setObject:[[_dobTextField.text componentsSeparatedByString:@"-"] lastObject] forKey:@"byear"];
    [dict setObject:[NSString stringWithFormat:@"%d",[self calculateAgeFromDateString:_dobTextField.text]] forKey:@"age"];
    
    if (_eirCodeTextField.text && ![_eirCodeTextField.text isEqualToString:@""]) {
        [dict setObject:_addressTextField.text forKey:@"eircode_address"];
        [dict setObject:_eirCodeTextField.text forKey:@"eircode"];
    }
    else {
        [dict setObject:@"" forKey:@"eircode_address"];
        [dict setObject:@"" forKey:@"eircode"];
    }
    
    [self convertAndUpdateUserDetails];
    
    return dict;
    
}

- (void) convertAndUpdateUserDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_firstNameTextField.text forKey:@"first_name"];
    [dict setObject:_lastNameTextField.text forKey:@"second_name"];
    [dict setObject:_phoneTextField.text forKey:@"mobile_number"];
    [dict setObject:_addressTextField.text forKey:@"address1"];
    [dict setObject:[NSString stringWithFormat:@"%d",_emailPromotionsButton.isSelected] forKey:@"promotions"];
    [dict setObject:[NSString stringWithFormat:@"%d",_receiveEmailsButton.isSelected] forKey:@"job_alerts"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"sms"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] firstObject] forKey:@"latitude"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] lastObject] forKey:@"longitude"];
    [dict setObject:_emailTextField.text forKey:@"user_email"];
    [dict setObject:[[_dobTextField.text componentsSeparatedByString:@"-"] firstObject] forKey:@"birth_day"];
    [dict setObject:[[_dobTextField.text componentsSeparatedByString:@"-"] objectAtIndex:1] forKey:@"birth_month"];
    [dict setObject:[[_dobTextField.text componentsSeparatedByString:@"-"] lastObject] forKey:@"birth_year"];
    [dict setObject:[NSString stringWithFormat:@"%d",[self calculateAgeFromDateString:_dobTextField.text]] forKey:@"age"];
    
    if (_eirCodeTextField.text && ![_eirCodeTextField.text isEqualToString:@""]) {
        [dict setObject:_addressTextField.text forKey:@"eircode_address"];
        [dict setObject:_eirCodeTextField.text forKey:@"eircode"];
    }
    else {
        [dict setObject:@"" forKey:@"eircode_address"];
        [dict setObject:@"" forKey:@"eircode"];
    }
    
    if (_maleButton.selected) {
        [dict setObject:@"1" forKey:@"gender"];
    }
    else {
       [dict setObject:@"2" forKey:@"gender"];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"profileDetails"];

}

- (int) calculateAgeFromDateString:(NSString *)dateStr {
    
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:dateStr]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    
    return years;
    
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _dobTextField) {
        [self dobTextFieldTapped];
        return NO;
    }
    
    return YES;
    
}

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
    
    [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressCellTapped:)]];
    cell.tag = indexPath.row;
    
    
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

- (void) addressCellTapped:(UITapGestureRecognizer *)gesture {
    
    int index = (int)gesture.view.tag;
    
    _addressTextField.text = [[[[googleResponseArr objectAtIndex:index] valueForKey:@"address_components"] valueForKey:@"short_name"] componentsJoinedByString:@", "];
    latLong = [NSString stringWithFormat:@"%@,%@",[[[[googleResponseArr objectAtIndex:index] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"], [[[[googleResponseArr objectAtIndex:index] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"]] ;
    
    [self dismissKeyboard];
    
}

#pragma mark - Form scroll for Keyboard Show/Hide


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.contentScrollView.contentInset = contentInsets;
    self.contentScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [self.contentScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.contentScrollView.contentInset = contentInsets;
    self.contentScrollView.scrollIndicatorInsets = contentInsets;
}

@end
