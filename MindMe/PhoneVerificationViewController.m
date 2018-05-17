//
//  PhoneVerificationViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/05/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "PhoneVerificationViewController.h"
#import "ActionSheetPicker.h"

@interface PhoneVerificationViewController ()

@end

@implementation PhoneVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self prepareDatasourceForCountryCodes];
    [self prepareDataSourceForCountryShortCodes];
    
}

- (void) setupInitialUI {
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(18./667)*kScreenHeight];
    _subHeaderLabel.font = _codeSuccessLabel.font = _codeSuccessMobileLabel.font = _accountValidatedLabel.font = _accountValidatedSuccessfullyLabel.font =  [UIFont fontWithName:@"Montserrat-SemiBold" size:(17./667)*kScreenHeight];
    
    _isdCodesLabel.font = _mobileNumberTextField.font = _enterCodeTextField.font = [UIFont fontWithName:@"Montserrat-Regular" size:(14./667)*kScreenHeight];
    
    _enterCodeContentView.layer.cornerRadius = _enterMobileContentView.layer.cornerRadius = 22.5;
    _enterCodeContentView.layer.masksToBounds = _enterMobileContentView.layer.masksToBounds = YES;
    
    [_isdCodesLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isdCodeLabelTapped:)]];
    _isdCodesLabel.userInteractionEnabled = YES;
    
    _mobileNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    
    selectedPrefix = @"IE";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUIForCodeSent {
    
    _subHeaderLabel.hidden = YES;
    _enterMobileContentView.hidden = YES;
    _sendSmsButton.hidden = YES;
    
    _codeSuccessMobileLabel.hidden = NO;
    _codeSuccessLabel.hidden = NO;
    _codeSuccessImgView.hidden = NO;
    
    _codeSuccessLabel.text = [NSString stringWithFormat:@"Code sent to %@",selectedPrefix];
    _codeSuccessMobileLabel.text = _mobileNumberTextField.text;
    
}

- (void) updateUIForAccountValidated {
    
    _enterCodeContentView.hidden = YES;
    _validateAccountButton.hidden = YES;
    
    _accountValidatedSuccessfullyLabel.hidden = NO;
    _accountValidatedLabel.hidden = NO;
    _accountValidatedImgView.hidden = NO;
    
    [self performSelector:@selector(backButtonTapped:) withObject:nil afterDelay:3.0];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendSmsButtonTapped:(id)sender {
    
    if (![_mobileNumberTextField.text isEqualToString:@""]) {
        [self startSendOTPService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"Please enter a mobile number to continue"];
    }
    
}

- (IBAction)validateAccountButtonTapped:(id)sender {
    
    if (![_enterCodeTextField.text isEqualToString:@""]) {
        [self startCodeValidationService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"Please enter a code to continue"];
    }
    
}

- (void) isdCodeLabelTapped:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@""
                                            rows:phoneArr
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           _isdCodesLabel.text = selectedValue;
                                           selectedPrefix = [codeArr objectAtIndex:selectedIndex];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

#pragma mark - API Helpers

- (void) startSendOTPService {
    
    [SVProgressHUD showWithStatus:@"Sending OTP on your mobile number"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = SendOTP;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForSendMesssage]];
    
}

- (void) startCodeValidationService {
    
    [SVProgressHUD showWithStatus:@"Validating OTP"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = VerifyOTP;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForValidateOTP]];
    
}



#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:SendOTP]) {
        
        [SVProgressHUD showSuccessWithStatus:@"OTP sent successfully"];
        [self updateUIForCodeSent];
        
    }
    if ([requestServiceKey isEqualToString:VerifyOTP]) {
        
        if ([[responseData valueForKey:@"message"] containsString:@"The code entered is not correct."]) {
            [SVProgressHUD showErrorWithStatus:[responseData valueForKey:@"message"]];
        }
        else {
            [SVProgressHUD showSuccessWithStatus:@"OTP validated successfully"];
            
            AppDelegate *appDelegate=( AppDelegate* )[UIApplication sharedApplication].delegate;
            [appDelegate startGetProfileDetailsService];
            
            [self updateUIForAccountValidated];
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

- (NSMutableDictionary *) prepareDictionaryForSendMesssage {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    [dict setObject:_mobileNumberTextField.text forKey:@"mobile"];
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
    NSMutableDictionary *responseData = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData]];
    
    [dict setObject:[responseData valueForKey:@"user_email"] forKey:@"email"];
    [dict setObject:selectedPrefix forKey:@"prefix"];
    
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForValidateOTP {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    [dict setObject:_enterCodeTextField.text forKey:@"code"];
    
    
    return dict;
    
}


- (void) prepareDatasourceForCountryCodes {
    
    phoneArr = [[NSMutableArray alloc] init];
    
    [phoneArr addObject:@"Albania (+355)"];
    [phoneArr addObject:@"Algeria (+213)"];
    [phoneArr addObject:@"American Samoa (+1684)"];
    [phoneArr addObject:@"Andorra (+376)"];
    [phoneArr addObject:@"Angola (+244)"];
    [phoneArr addObject:@"Anguilla (+1264)"];
    [phoneArr addObject:@"Antarctica (+672)"];
    [phoneArr addObject:@"Antigua &amp; Barbuda (+1268)"];
    [phoneArr addObject:@"Argentina (+54)"];
    [phoneArr addObject:@"Armenia (+374)"];
    [phoneArr addObject:@"Aruba (+297)"];
    [phoneArr addObject:@"Australia (+61)"];
    [phoneArr addObject:@"Austria (+43)"];
    [phoneArr addObject:@"Azerbaijan (+994)"];
    [phoneArr addObject:@"Bahamas (+1242)"];
    [phoneArr addObject:@"Bahrain (+973)"];
    [phoneArr addObject:@"Bangladesh (+880)"];
    [phoneArr addObject:@"Barbados (+1246)"];
    [phoneArr addObject:@"Belarus (+375)"];
    [phoneArr addObject:@"Belgium (+32)"];
    [phoneArr addObject:@"Belize (+501)"];
    [phoneArr addObject:@"Benin (+229)"];
    [phoneArr addObject:@"Bermuda (+1441)"];
    [phoneArr addObject:@"Bhutan (+975)"];
    [phoneArr addObject:@"Bolivia (+591)"];
    [phoneArr addObject:@"Bosnia & Herzegovina (+387)"];
    [phoneArr addObject:@"Botswana (+267)"];
    [phoneArr addObject:@"Brazil (+55)"];
    [phoneArr addObject:@"British Virgin Islands (+1284)"];
    [phoneArr addObject:@"Brunei (+673)"];
    [phoneArr addObject:@"Bulgaria (+359)"];
    [phoneArr addObject:@"Burkina Faso (+226)"];
    [phoneArr addObject:@"Myanmar (Burma) (+95)"];
    [phoneArr addObject:@"Burundi (+257)"];
    [phoneArr addObject:@"Cambodia (+855)"];
    [phoneArr addObject:@"Cameroon (+237)"];
    [phoneArr addObject:@"Canada (+1)"];
    [phoneArr addObject:@"Cape Verde (+238)"];
    [phoneArr addObject:@"Cayman Islands (+1345)"];
    [phoneArr addObject:@"Central African Republic (+236)"];
    [phoneArr addObject:@"Chad (+235)"];
    [phoneArr addObject:@"Chile (+56)"];
    [phoneArr addObject:@"China (+86)"];
    [phoneArr addObject:@"Christmas Island (+61)"];
    [phoneArr addObject:@"Cocos (Keeling) Islands (+61)"];
    [phoneArr addObject:@"Colombia (+57)"];
    [phoneArr addObject:@"Comoros (+269)"];
    [phoneArr addObject:@"Cook Islands (+682)"];
    [phoneArr addObject:@"Costa Rica (+506)"];
    [phoneArr addObject:@"Croatia (+385)"];
    [phoneArr addObject:@"Cuba (+53)"];
    [phoneArr addObject:@"Cyprus (+357)"];
    [phoneArr addObject:@"Czechia (+420)"];
    [phoneArr addObject:@"Congo - Kinshasa (+243)"];
    [phoneArr addObject:@"Denmark (+45)"];
    [phoneArr addObject:@"Djibouti (+253)"];
    [phoneArr addObject:@"Dominica (+1767)"];
    [phoneArr addObject:@"Dominican Republic (+1809)"];
    [phoneArr addObject:@"Ecuador (+593)"];
    [phoneArr addObject:@"Egypt (+20)"];
    [phoneArr addObject:@"El Salvador (+503)"];
    [phoneArr addObject:@"Equatorial Guinea (+240)"];
    [phoneArr addObject:@"Eritrea (+291)"];
    [phoneArr addObject:@"Estonia (+372)"];
    [phoneArr addObject:@"Ethiopia (+251)"];
    [phoneArr addObject:@"Falkland Islands (+500)"];
    [phoneArr addObject:@"Faroe Islands (+298)"];
    [phoneArr addObject:@"Fiji (+679)"];
    [phoneArr addObject:@"Finland (+358)"];
    [phoneArr addObject:@"France (+33)"];
    [phoneArr addObject:@"French Polynesia (+689)"];
    [phoneArr addObject:@"Gabon (+241)"];
    [phoneArr addObject:@"Gambia (+220)"];
    [phoneArr addObject:@"Georgia (+995)"];
    [phoneArr addObject:@"Germany (+49)"];
    [phoneArr addObject:@"Ghana (+233)"];
    [phoneArr addObject:@"Gibraltar (+350)"];
    [phoneArr addObject:@"Greece (+30)"];
    [phoneArr addObject:@"Greenland (+299)"];
    [phoneArr addObject:@"Grenada (+1473)"];
    [phoneArr addObject:@"Guam (+1671)"];
    [phoneArr addObject:@"Guatemala (+502)"];
    [phoneArr addObject:@"Guinea (+224)"];
    [phoneArr addObject:@"Guinea-Bissau (+245)"];
    [phoneArr addObject:@"Guyana (+592)"];
    [phoneArr addObject:@"Haiti (+509)"];
    [phoneArr addObject:@"Vatican City (+39)"];
    [phoneArr addObject:@"Honduras (+504)"];
    [phoneArr addObject:@"Hong Kong SAR China (+852)"];
    [phoneArr addObject:@"Hungary (+36)"];
    [phoneArr addObject:@"Iceland (+354)"];
    [phoneArr addObject:@"India (+91)"];
    [phoneArr addObject:@"Indonesia (+62)"];
    [phoneArr addObject:@"Iran (+98)"];
    [phoneArr addObject:@"Iraq (+964)"];
    [phoneArr addObject:@"Ireland (+353)"];
    [phoneArr addObject:@"Isle of Man (+44)"];
    [phoneArr addObject:@"Israel (+972)"];
    [phoneArr addObject:@"Italy (+39)"];
    [phoneArr addObject:@"Cote d'Ivoire (+225)"];
    [phoneArr addObject:@"Jamaica (+1876)"];
    [phoneArr addObject:@"apan (+81)"];
    [phoneArr addObject:@"ordan (+962)"];
    [phoneArr addObject:@"Kazakhstan (+7)"];
    [phoneArr addObject:@"Kenya (+254)"];
    [phoneArr addObject:@"Kiribati (+686)"];
    [phoneArr addObject:@"Kuwait (+965)"];
    [phoneArr addObject:@"Kyrgyzstan (+996)"];
    [phoneArr addObject:@"Laos (+856)"];
    [phoneArr addObject:@"Latvia (+371)"];
    [phoneArr addObject:@"Lebanon (+961)"];
    [phoneArr addObject:@"Lesotho (+266)"];
    [phoneArr addObject:@"Liberia (+231)"];
    [phoneArr addObject:@"Libya (+218)"];
    [phoneArr addObject:@"Liechtenstein (+423)"];
    [phoneArr addObject:@"Lithuania (+370)"];
    [phoneArr addObject:@"Luxembourg (+352)"];
    [phoneArr addObject:@"Macau SAR China (+853)"];
    [phoneArr addObject:@"Macedonia (+389)"];
    [phoneArr addObject:@"Madagascar (+261)"];
    [phoneArr addObject:@"Malawi (+265)"];
    [phoneArr addObject:@"Malaysia (+60)"];
    [phoneArr addObject:@"Maldives (+960)"];
    [phoneArr addObject:@"Mali (+223)"];
    [phoneArr addObject:@"Malta (+356)"];
    [phoneArr addObject:@"Marshall Islands (+692)"];
    [phoneArr addObject:@"Mauritania (+222)"];
    [phoneArr addObject:@"Mauritius (+230)"];
    [phoneArr addObject:@"Mayotte (+262)"];
    [phoneArr addObject:@"Mexico (+52)"];
    [phoneArr addObject:@"Micronesia (+691)"];
    [phoneArr addObject:@"Moldova (+373)"];
    [phoneArr addObject:@"Monaco (+377)"];
    [phoneArr addObject:@"Mongolia (+976)"];
    [phoneArr addObject:@"Montenegro (+382)"];
    [phoneArr addObject:@"Montserrat (+1664)"];
    [phoneArr addObject:@"Morocco (+212)"];
    [phoneArr addObject:@"Mozambique (+258)"];
    [phoneArr addObject:@"Namibia (+264)"];
    [phoneArr addObject:@"Nauru (+674)"];
    [phoneArr addObject:@"Nepal (+977)"];
    [phoneArr addObject:@"Netherlands (+31)"];
    [phoneArr addObject:@"AN (+599)"];
    [phoneArr addObject:@"New Caledonia (+687)"];
    [phoneArr addObject:@"New Zealand (+64)"];
    [phoneArr addObject:@"Nicaragua (+505)"];
    [phoneArr addObject:@"Niger (+227)"];
    [phoneArr addObject:@"Nigeria (+234)"];
    [phoneArr addObject:@"Niue (+683)"];
    [phoneArr addObject:@"Northern Mariana Islands (+1670)"];
    [phoneArr addObject:@"Norway (+47)"];
    [phoneArr addObject:@"Oman (+968)"];
    [phoneArr addObject:@"Pakistan (+92)"];
    [phoneArr addObject:@"Palau (+680)"];
    [phoneArr addObject:@"Panama (+507)"];
    [phoneArr addObject:@"Papua New Guinea (+675)"];
    [phoneArr addObject:@"Paraguay (+595)"];
    [phoneArr addObject:@"Peru (+51)"];
    [phoneArr addObject:@"Philippines (+63)"];
    [phoneArr addObject:@"Poland (+48)"];
    [phoneArr addObject:@"Portugal (+351)"];
    [phoneArr addObject:@"Puerto Rico (+1)"];
    [phoneArr addObject:@"Qatar (+974)"];
    [phoneArr addObject:@"Romania (+40)"];
    [phoneArr addObject:@"Russia (+7)"];
    [phoneArr addObject:@"Rwanda (+250)"];
    [phoneArr addObject:@"St Helena (+290)"];
    [phoneArr addObject:@"St Kitts & Nevis (+1869)"];
    [phoneArr addObject:@"St Lucia (+1758)"];
    [phoneArr addObject:@"St Martin (+1599)"];
    [phoneArr addObject:@"St Pierre & Miquelon (+508)"];
    [phoneArr addObject:@"St Vincent & Grenadines (+1784)"];
    [phoneArr addObject:@"Samoa (+685)"];
    [phoneArr addObject:@"San Marino (+378)"];
    [phoneArr addObject:@"S_o Tom_ & Pr_ncipe (+239)"];
    [phoneArr addObject:@"Saudi Arabia (+966)"];
    [phoneArr addObject:@"Senegal (+221)"];
    [phoneArr addObject:@"Serbia (+381)"];
    [phoneArr addObject:@"Seychelles (+248)"];
    [phoneArr addObject:@"Sierra Leone (+232)"];
    [phoneArr addObject:@"Singapore (+65)"];
    [phoneArr addObject:@"Slovakia (+421)"];
    [phoneArr addObject:@"Slovenia (+386)"];
    [phoneArr addObject:@"Solomon Islands (+677)"];
    [phoneArr addObject:@"Somalia (+252)"];
    [phoneArr addObject:@"South Africa (+27)"];
    [phoneArr addObject:@"South Korea (+82)"];
    [phoneArr addObject:@"Spain (+34)"];
    [phoneArr addObject:@"Sri Lanka (+94)"];
    [phoneArr addObject:@"Sudan (+249)"];
    [phoneArr addObject:@"Suriname (+597)"];
    [phoneArr addObject:@"Swaziland (+268)"];
    [phoneArr addObject:@"Sweden (+46)"];
    [phoneArr addObject:@"Switzerland (+41)"];
    [phoneArr addObject:@"Syria (+963)"];
    [phoneArr addObject:@"Taiwan (+886)"];
    [phoneArr addObject:@"Tajikistan (+992)"];
    [phoneArr addObject:@"anzania (+255)"];
    [phoneArr addObject:@"Thailand (+66)"];
    [phoneArr addObject:@"Timor-Leste (+670)"];
    [phoneArr addObject:@"Togo (+228)"];
    [phoneArr addObject:@"Tokelau (+690)"];
    [phoneArr addObject:@"Tonga (+676)"];
    [phoneArr addObject:@"Trinidad & Tobago (+1868)"];
    [phoneArr addObject:@"Tunisia (+216)"];
    [phoneArr addObject:@"Turkey (+90)"];
    [phoneArr addObject:@"Turkmenistan (+993)"];
    [phoneArr addObject:@"Turks & Caicos Islands (+1649)"];
    [phoneArr addObject:@"Tuvalu (+688)"];
    [phoneArr addObject:@"Uganda (+256)"];
    [phoneArr addObject:@"Ukraine (+380)"];
    [phoneArr addObject:@"United Arab Emirates (+971)"];
    [phoneArr addObject:@"United Kingdom (+44)"];
    [phoneArr addObject:@"United States (+1)"];
    [phoneArr addObject:@"Uruguay (+598)"];
    [phoneArr addObject:@"US Virgin Islands (+1340)"];
    [phoneArr addObject:@"Uzbekistan (+998)"];
    [phoneArr addObject:@"Vanuatu (+678)"];
    [phoneArr addObject:@"Venezuela (+58)"];
    [phoneArr addObject:@"Vietnam (+84)"];
    [phoneArr addObject:@"Wallis & Futuna (+681)"];
    [phoneArr addObject:@"Yemen (+967)"];
    [phoneArr addObject:@"Zambia (+260)"];
    [phoneArr addObject:@"Zimbabwe (+263)"];
    
    
}

- (void) prepareDataSourceForCountryShortCodes {
    
    codeArr = [[NSMutableArray alloc] init];
    
    [codeArr addObject:@"AL"];
    [codeArr addObject:@"DZ"];
    [codeArr addObject:@"AS"];
    [codeArr addObject:@"AD"];
    [codeArr addObject:@"AO"];
    [codeArr addObject:@"AI"];
    [codeArr addObject:@"AQ"];
    [codeArr addObject:@"AG"];
    [codeArr addObject:@"AR"];
    [codeArr addObject:@"AM"];
    [codeArr addObject:@"AW"];
    [codeArr addObject:@"AU"];
    [codeArr addObject:@"AT"];
    [codeArr addObject:@"AZ"];
    [codeArr addObject:@"BS"];
    [codeArr addObject:@"BH"];
    [codeArr addObject:@"BD"];
    [codeArr addObject:@"BB"];
    [codeArr addObject:@"BY"];
    [codeArr addObject:@"BE"];
    [codeArr addObject:@"BZ"];
    [codeArr addObject:@"BJ"];
    [codeArr addObject:@"BM"];
    [codeArr addObject:@"BT"];
    [codeArr addObject:@"BO"];
    [codeArr addObject:@"BA"];
    [codeArr addObject:@"BW"];
    [codeArr addObject:@"BR"];
    [codeArr addObject:@"VG"];
    [codeArr addObject:@"BN"];
    [codeArr addObject:@"BG"];
    [codeArr addObject:@"BF"];
    [codeArr addObject:@"MM"];
    [codeArr addObject:@"BI"];
    [codeArr addObject:@"KH"];
    [codeArr addObject:@"CM"];
    [codeArr addObject:@"CA"];
    [codeArr addObject:@"CV"];
    [codeArr addObject:@"KY"];
    [codeArr addObject:@"CF"];
    [codeArr addObject:@"TD"];
    [codeArr addObject:@"CL"];
    [codeArr addObject:@"CN"];
    [codeArr addObject:@"CX"];
    [codeArr addObject:@"CC"];
    [codeArr addObject:@"CO"];
    [codeArr addObject:@"KM"];
    [codeArr addObject:@"CK"];
    [codeArr addObject:@"CR"];
    [codeArr addObject:@"HR"];
    [codeArr addObject:@"CU"];
    [codeArr addObject:@"CY"];
    [codeArr addObject:@"CZ"];
    [codeArr addObject:@"CD"];
    [codeArr addObject:@"DK"];
    [codeArr addObject:@"DJ"];
    [codeArr addObject:@"DM"];
    [codeArr addObject:@"DO"];
    [codeArr addObject:@"EC"];
    [codeArr addObject:@"EG"];
    [codeArr addObject:@"SV"];
    [codeArr addObject:@"GQ"];
    [codeArr addObject:@"ER"];
    [codeArr addObject:@"EE"];
    [codeArr addObject:@"ET"];
    [codeArr addObject:@"FK"];
    [codeArr addObject:@"FO"];
    [codeArr addObject:@"FJ"];
    [codeArr addObject:@"FI"];
    [codeArr addObject:@"FR"];
    [codeArr addObject:@"PF"];
    [codeArr addObject:@"GA"];
    [codeArr addObject:@"GM"];
    [codeArr addObject:@"GE"];
    [codeArr addObject:@"DE"];
    [codeArr addObject:@"GH"];
    [codeArr addObject:@"GI"];
    [codeArr addObject:@"GR"];
    [codeArr addObject:@"GL"];
    [codeArr addObject:@"GD"];
    [codeArr addObject:@"GU"];
    [codeArr addObject:@"GT"];
    [codeArr addObject:@"GN"];
    [codeArr addObject:@"GW"];
    [codeArr addObject:@"GY"];
    [codeArr addObject:@"HT"];
    [codeArr addObject:@"VA"];
    [codeArr addObject:@"HN"];
    [codeArr addObject:@"HK"];
    [codeArr addObject:@"HU"];
    [codeArr addObject:@"IS"];
    [codeArr addObject:@"IN"];
    [codeArr addObject:@"ID"];
    [codeArr addObject:@"IR"];
    [codeArr addObject:@"IQ"];
    [codeArr addObject:@"IE"];
    [codeArr addObject:@"IM"];
    [codeArr addObject:@"IL"];
    [codeArr addObject:@"IT"];
    [codeArr addObject:@"CI"];
    [codeArr addObject:@"JM"];
    [codeArr addObject:@"JP"];
    [codeArr addObject:@"JO"];
    [codeArr addObject:@"KZ"];
    [codeArr addObject:@"KE"];
    [codeArr addObject:@"KI"];
    [codeArr addObject:@"KW"];
    [codeArr addObject:@"KG"];
    [codeArr addObject:@"LA"];
    [codeArr addObject:@"LV"];
    [codeArr addObject:@"LB"];
    [codeArr addObject:@"LS"];
    [codeArr addObject:@"LR"];
    [codeArr addObject:@"LY"];
    [codeArr addObject:@"LI"];
    [codeArr addObject:@"LT"];
    [codeArr addObject:@"LU"];
    [codeArr addObject:@"MN"];
    [codeArr addObject:@"MK"];
    [codeArr addObject:@"MG"];
    [codeArr addObject:@"MW"];
    [codeArr addObject:@"MY"];
    [codeArr addObject:@"MV"];
    [codeArr addObject:@"ML"];
    [codeArr addObject:@"MT"];
    [codeArr addObject:@"MH"];
    [codeArr addObject:@"MR"];
    [codeArr addObject:@"MU"];
    [codeArr addObject:@"YT"];
    [codeArr addObject:@"MX"];
    [codeArr addObject:@"FM"];
    [codeArr addObject:@"MD"];
    [codeArr addObject:@"MC"];
    [codeArr addObject:@"MN"];
    [codeArr addObject:@"ME"];
    [codeArr addObject:@"MS"];
    [codeArr addObject:@"MA"];
    [codeArr addObject:@"MZ"];
    [codeArr addObject:@"NA"];
    [codeArr addObject:@"NR"];
    [codeArr addObject:@"NP"];
    [codeArr addObject:@"NL"];
    [codeArr addObject:@"144"];
    [codeArr addObject:@"NC"];
    [codeArr addObject:@"NZ"];
    [codeArr addObject:@"NI"];
    [codeArr addObject:@"NE"];
    [codeArr addObject:@"NG"];
    [codeArr addObject:@"NU"];
    [codeArr addObject:@"MP"];
    [codeArr addObject:@"NO"];
    [codeArr addObject:@"OM"];
    [codeArr addObject:@"PK"];
    [codeArr addObject:@"PW"];
    [codeArr addObject:@"PA"];
    [codeArr addObject:@"PG"];
    [codeArr addObject:@"PY"];
    [codeArr addObject:@"PE"];
    [codeArr addObject:@"PH"];
    [codeArr addObject:@"PL"];
    [codeArr addObject:@"PT"];
    [codeArr addObject:@"PR"];
    [codeArr addObject:@"QA"];
    [codeArr addObject:@"RO"];
    [codeArr addObject:@"RU"];
    [codeArr addObject:@"RW"];
    [codeArr addObject:@"SH"];
    [codeArr addObject:@"KN"];
    [codeArr addObject:@"LC"];
    [codeArr addObject:@"MF"];
    [codeArr addObject:@"PM"];
    [codeArr addObject:@"VC"];
    [codeArr addObject:@"WS"];
    [codeArr addObject:@"SM"];
    [codeArr addObject:@"ST"];
    [codeArr addObject:@"SA"];
    [codeArr addObject:@"SN"];
    [codeArr addObject:@"RS"];
    [codeArr addObject:@"SC"];
    [codeArr addObject:@"SL"];
    [codeArr addObject:@"SG"];
    [codeArr addObject:@"SK"];
    [codeArr addObject:@"SI"];
    [codeArr addObject:@"SB"];
    [codeArr addObject:@"SO"];
    [codeArr addObject:@"ZA"];
    [codeArr addObject:@"KR"];
    [codeArr addObject:@"ES"];
    [codeArr addObject:@"LK"];
    [codeArr addObject:@"SD"];
    [codeArr addObject:@"SR"];
    [codeArr addObject:@"SZ"];
    [codeArr addObject:@"SE"];
    [codeArr addObject:@"CH"];
    [codeArr addObject:@"SY"];
    [codeArr addObject:@"TW"];
    [codeArr addObject:@"TJ"];
    [codeArr addObject:@"TZ"];
    [codeArr addObject:@"TH"];
    [codeArr addObject:@"TL"];
    [codeArr addObject:@"TG"];
    [codeArr addObject:@"TK"];
    [codeArr addObject:@"TO"];
    [codeArr addObject:@"TT"];
    [codeArr addObject:@"TN"];
    [codeArr addObject:@"TR"];
    [codeArr addObject:@"TM"];
    [codeArr addObject:@"TC"];
    [codeArr addObject:@"TV"];
    [codeArr addObject:@"UG"];
    [codeArr addObject:@"UA"];
    [codeArr addObject:@"AE"];
    [codeArr addObject:@"UK"];
    [codeArr addObject:@"US"];
    [codeArr addObject:@"UY"];
    [codeArr addObject:@"VI"];
    [codeArr addObject:@"UZ"];
    [codeArr addObject:@"VU"];
    [codeArr addObject:@"VE"];
    [codeArr addObject:@"VN"];
    [codeArr addObject:@"WF"];
    [codeArr addObject:@"YE"];
    [codeArr addObject:@"ZM"];
    [codeArr addObject:@"ZW"];

    
}

@end
