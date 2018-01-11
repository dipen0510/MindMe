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
    [self registerForKeyboardNotifications];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self startGetProfileDetailsService];
    
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
    
    _addressView.hidden = YES;
    _menuButton.hidden = [[SharedClass sharedInstance] isEditProfileMenuButtonHidden];
    
    _dobTextField.delegate = self;
    
    activeField = [[UITextField alloc] init];
    
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
    else {
        [self startUpdateProfileService];
    }

    
}

- (void) dobTextFieldTapped {
    
    [ActionSheetDatePicker showPickerWithTitle:@"Select DOB" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
        
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
    
    if ([requestServiceKey isEqualToString:UpdateParentPersonalDetails]) {
        
        [[SharedClass sharedInstance] setIsEditProfileMenuButtonHidden:NO];
        _menuButton.hidden = NO;
        
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
    [dict setObject:latLong forKey:@"location"];
    [dict setObject:[NSString stringWithFormat:@"%d",_emailPromotionsButton.isSelected] forKey:@"promotions"];
    [dict setObject:[NSString stringWithFormat:@"%d",_receiveEmailsButton.isSelected] forKey:@"job_alerts"];
    [dict setObject:[NSString stringWithFormat:@"1"] forKey:@"sms"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] firstObject] forKey:@"lati"];
    [dict setObject:[[latLong componentsSeparatedByString:@","] lastObject] forKey:@"longi"];
    [dict setObject:_emailTextField.text forKey:@"email"];
    [dict setObject:@"0" forKey:@"bday"];
    [dict setObject:@"0" forKey:@"bmonth"];
    [dict setObject:@"0" forKey:@"byear"];
    [dict setObject:@"0" forKey:@"age"];
    [dict setObject:_addressTextField.text forKey:@"eircode_address"];
    [dict setObject:_eirCodeTextField.text forKey:@"eircode"];
    
    
    return dict;
    
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
