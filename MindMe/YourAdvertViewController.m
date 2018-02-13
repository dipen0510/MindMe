//
//  YourAdvertViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "YourAdvertViewController.h"
#import "ProfileAvailabilityCollectionViewCell.h"
#import "CreateAdvertsCollectionViewCell.h"
#import "AdvertPDFCollectionViewCell.h"
#import "ActionSheetPicker.h"
#import "AdvertsViewController.h"

@interface YourAdvertViewController ()

@end

@implementation YourAdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupAvailibilityArr];
    [self setupUIForForms];
    
}

- (void) setupInitialUI {

    _nextButton.layer.cornerRadius = 17.5;
    _nextButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 17.5;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    _otherRelevantInfoTextView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.].CGColor;
    _otherRelevantInfoTextView.layer.borderWidth = 1.;
    _otherRelevantInfoTextView.layer.cornerRadius = 5.0;
    _otherRelevantInfoTextView.text = @"";
    _otherRelevantInfoTextView.delegate = self;
    
    [self.daysRequiredCollectionView registerNib:[UINib nibWithNibName:@"ProfileAvailabilityCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileAvailabilityCollectionViewCell"];
    
    [self.firstCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.secondCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.thirdCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.forthCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.fifthCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.sixthCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.seventhCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.cvCollectionView registerNib:[UINib nibWithNibName:@"AdvertPDFCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdvertPDFCollectionViewCell"];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _weeklyHeaderLabel.text = @"What Days Are You Available To Work";
    }
    else {
        
        _weeklyHeaderLabel.text = @"Please indicate the days care is required";
        
        _uploadCVStaticLabel.hidden = YES;
        _uploadCVDescLabel.hidden = YES;
        _advertIsActiveLabelTopConstraint.constant = -76.;
        
    }
    
    _isAdvertActiveLabel.delegate = self;
    
    [_contentScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    _contentScrollView.exclusiveTouch = NO;
    
    if (_isAdvertInEditingMode) {
        isEMERType = [[_advertDetailsDict valueForKey:@"emer"] intValue];
    }
    if (_isAdvertInEditingMode) {
        if ([[_advertDetailsDict valueForKey:@"job_ad_active"] intValue]) {
            _isAdvertActiveLabel.text = @"Yes";
        }
        else {
            _isAdvertActiveLabel.text = @"No";
        }
    }
    
}

- (void) setupAvailibilityArr {
    
    availabilityArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<48; i++) {
        [availabilityArr addObject:[NSNumber numberWithInt:0]];
    }
    
}

- (void) setupUIForForms {
    
    NSString* careType = [_advertDetailsDict valueForKey:@"care_type"];
    
    if ([careType isEqualToString:@"Au Pair"]) {
        [self setupUIForAUPairForm];
    }
    else if ([careType isEqualToString:@"Babysitters"]) {
        [self setupUIForBabysittersForm];
    }
    else if ([careType isEqualToString:@"Childminders"]) {
        [self setupUIForChildmindersForm];
    }
    else if ([careType isEqualToString:@"Creche"]) {
        [self setupUIForCrecheForm];
    }
    else if ([careType isEqualToString:@"Nanny"]) {
        [self setupUIForNannyForm];
    }
    else if ([careType isEqualToString:@"Cleaners"]) {
        [self setupUIForCleanersForm];
    }
    else if ([careType isEqualToString:@"Dog Walkers"]) {
        [self setupUIForDayWalkersForm];
    }
    else if ([careType isEqualToString:@"Elderly Care"]) {
        [self setupUIForElderlyCareForm];
    }
    else if ([careType isEqualToString:@"House Keepers"]) {
        [self setupUIForHousekeepersForm];
    }
    else if ([careType isEqualToString:@"Maternity Nurse"]) {
        [self setupUIForMaternityNurseForm];
    }
    else if ([careType isEqualToString:@"Pet Minders"]) {
        [self setupUIForPetMindersForm];
    }
    else if ([careType isEqualToString:@"Private Midwife"]) {
        [self setupUIForPrivateMidwifeForm];
    }
    else if ([careType isEqualToString:@"School Run"]) {
        [self setupUIForSchoolRunForm];
    }
    else if ([careType isEqualToString:@"Special Needs Care"]) {
        [self setupUIForSpecialNeedsCareForm];
    }
    else if ([careType isEqualToString:@"Tutor"]) {
        [self setupUIForTutorForm];
    }
    
}

- (void) setupUIForAUPairForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Au Pair requires to live in or live out";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Au Pair required to live in or live out";
        _thirdCollectionViewTitle.text = @"Carer should have experience with";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Live In", @"Live Out", nil];
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        secondPreselectedArr = [[NSMutableArray alloc] initWithArray:[[[_advertDetailsDict valueForKey:@"aupair_live"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        fifthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        sixthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForBabysittersForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Carer should have experience with";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }

    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];

    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        secondPreselectedArr = [[NSMutableArray alloc] initWithArray:[[[_advertDetailsDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        fifthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        sixthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForChildmindersForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Carer should have experience with";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        secondPreselectedArr = [[NSMutableArray alloc] initWithArray:[[[_advertDetailsDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        fifthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        sixthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForCrecheForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Carer should have experience with";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        secondPreselectedArr = [[NSMutableArray alloc] initWithArray:[[[_advertDetailsDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        fifthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        sixthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForNannyForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Children minded in";
        _thirdCollectionViewTitle.text = @"Carer should have experience with";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _sixthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        secondPreselectedArr = [[NSMutableArray alloc] initWithArray:[[[_advertDetailsDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        fifthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        sixthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForCleanersForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Cleaning Services You Can Provide";
        _fourthCollectionViewTitle.text = @"Do You Have Documentation";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Cleaning Services required";
        _fourthCollectionViewTitle.text = @"Documentation Required";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Bathroom Cleaning", @"Dishes", @"Plant Care", @"Kitchen Cleaning", @"Oven Cleaning", @"Window Washing", @"Pet Cleanup", @"General Room Cleaning", @"Surface Polishing", @"Packing and Unpacking", @"Bed Changing", @"Carpet Cleaning", @"Attic Cleaning", @"Furniture Treatment", @"Basement Cleaning", @"Refrigerator Cleaning", @"Wall Washing", @"House Sitting", @"Cabinet Cleaning", @"Laundry", @"Organization", @"External Cleaning", nil];
    _thirdCollectionViewHeightConstraint.constant = 330;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Garda Vetting", @"Work Visa", @"References", @"Driving Licence", nil];
    _fourthCollectionViewHeightConstraint.constant = 60.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForDayWalkersForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Pets You Have Experience With";
        _fourthCollectionViewTitle.text = @"You Can Provide";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Type Of Pet Requiring Care";
        _fourthCollectionViewTitle.text = @"Carer should Provide";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Dogs", @"Cats", @"Birds", @"Fish", @"Amphibians", @"Mammals", @"Horses", @"Farm Animals", @"Exotic Pets", @"Other Pets", nil];
    _thirdCollectionViewHeightConstraint.constant = 150;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Play & Exercise", @"First Aid", @"Training", @"Boarding", @"Waste Cleanup", @"Overnight Care", @"Walking", @"Feeding", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForElderlyCareForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _fifthCollectionViewTitle.text = @"Additional Services You Can Provide";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Carer should have experience with";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _fifthCollectionViewTitle.text = @"Additional Services You Require";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"55 - 65 Years", @"65 to 75 Years", @"75 to 85 Years", @"85+ Years", nil];
    _thirdCollectionViewHeightConstraint.constant = 60.;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Special Needs Certification", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Companion Services", @"Home Nursing Care", @"Home Help Services", @"Transportation", @"Live-in Care", @"Homecare Services", @"Meal Preparation", @"Personal Care (e.g. Bathing, Grooming)", nil];
    _fifthCollectionViewHeightConstraint.constant = 120.;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -44 - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        fifthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForHousekeepersForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"House Keeping Services You Can Provide";
        _fourthCollectionViewTitle.text = @"Do You Have Documentation";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"House Keeping Services required";
        _fourthCollectionViewTitle.text = @"Documentation Required";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Bathroom Cleaning", @"Dishes", @"Plant Care", @"Kitchen Cleaning", @"Oven Cleaning", @"Window Washing", @"Pet Cleanup", @"General Room Cleaning", @"Surface Polishing", @"Packing and Unpacking", @"Bed Changing",@"Carpet Cleaning", @"Attic Cleaning", @"Furniture Treatment", @"Basement Cleaning", @"Refrigerator Cleaning", @"Wall Washing", @"House Sitting", @"Cabinet Cleaning", @"Laundry", @"Organization", @"External Cleaning", nil];
    _thirdCollectionViewHeightConstraint.constant = 330;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Garda Vetting", @"Work Visa", @"References", @"Driving Licence", nil];
    _fourthCollectionViewHeightConstraint.constant = 60.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForMaternityNurseForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitle.hidden = YES;
    _thirdCollectionView.hidden = YES;
    _thirdCollectionSeparatorView.hidden = YES;
    
    _fourthCollectionViewTitleTopConstraint.constant = -108 - _secondCollectionViewHeightConstraint.constant - _thirdCollectionViewHeightConstraint.constant;
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Special Needs Certification", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForPetMindersForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Pets You Have Experience With";
        _fourthCollectionViewTitle.text = @"You Can Provide";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Type Of Pet Requiring Care";
        _fourthCollectionViewTitle.text = @"Carer should Provide";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Dogs", @"Cats", @"Birds", @"Fish", @"Amphibians", @"Mammals", @"Horses", @"Farm Animals", @"Exotic Pets", @"Other Pets", nil];
    _thirdCollectionViewHeightConstraint.constant = 150;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Play & Exercise", @"First Aid", @"Training", @"Boarding", @"Waste Cleanup", @"Overnight Care", @"Walking", @"Feeding", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForPrivateMidwifeForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitle.hidden = YES;
    _thirdCollectionView.hidden = YES;
    _thirdCollectionSeparatorView.hidden = YES;
    
    _fourthCollectionViewTitleTopConstraint.constant = -108 - _secondCollectionViewHeightConstraint.constant - _thirdCollectionViewHeightConstraint.constant;
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Special Needs Certification", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForSchoolRunForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Provide Transport For";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Require Transport For";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Infants (0-1 year of age)", @"Toddlers (1-3 years of age)", @"Preschoolers (3-5 years of age)", @"Middle Childhood (6-12 years of age)", @"Teenagers (15-19 years of age)", @"Adult", @"Elderly", @"Special Needs (wheel chair access)", nil];
    _thirdCollectionViewHeightConstraint.constant = 120.;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Special Needs Certification", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"Special Needs Care", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForSpecialNeedsCareForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
        _fifthCollectionViewTitle.text = @"I Have Experience With";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _thirdCollectionViewTitle.text = @"Age Group Experience";
        _fourthCollectionViewTitle.text = @"Carer should have the following";
        _fifthCollectionViewTitle.text = @"Carer Should Have Experience With";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _advertIsActiveLabelTopConstraint.constant = _advertIsActiveLabelTopConstraint.constant + 120;
    _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 100;
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Infant (up to 12 months)", @"Youth (2-12 years)", @"Teen (13-19 years)", @"Adult (20-64 years)", @"Elderly Person (65+)", nil];
    _thirdCollectionViewHeightConstraint.constant = 90.;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Special Needs Certification", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"ADD", @"ADHD", @"Aspergers", @"Asthma", @"Autism", @"Autism Spectrum Disorder", @"Blindness/Visual Impairment", @"Cancer", @"Celiac", @"Central Auditory Disorder", @"Cerebral Palsy", @"Cognitive Disabilities", @"Cystic Fibrosis", @"Deafness", @"Developmental Delays", @"Diabetes", @"Down Syndrome", @"Dwarfism", @"Dyslexia", @"Epilepsy", @"Fetal Alcohol Syndrome", @"Food Allergies", @"Fragile X", @"Heart Defects", @"Hydrocephaly", @"Mental Illness", @"Mobility Challenges", @"Multiple Sclerosis", @"Muscular Dystrophy", @"Obesity", @"Pervasive Developmental Disorder", @"Polymicrogyria", @"Prader Willi", @"Rett Syndrome", @"Seizure Disorder", @"Sensory Integration Disorder", @"Speech Delay", @"Spinal Cord Injury", @"Thyroid Condition", @"Tourette Syndrome", nil];
    _fifthCollectionViewHeightConstraint.constant = 600;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -44 - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Tutor", nil];
    
    if (_isAdvertInEditingMode) {
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        fifthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}

- (void) setupUIForTutorForm {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Junior Cycle Subjects";
        _thirdCollectionViewTitle.text = @"Senior Cycle Subjects";
        _fourthCollectionViewTitle.text = @"Do You Have Documentation";
        _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Do you require Last Minute / Emergency Cover:";
        _secondCollectionViewTitle.text = @"Junior Cycle Subjects";
        _thirdCollectionViewTitle.text = @"Senior Cycle Subjects";
        _fourthCollectionViewTitle.text = @"Tutor should have the following";
        _seventhCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Ancient Greek", @"Art - Craft - Design", @"Business Studies", @"Civic - Social and Political Education", @"Classical Studies", @"English", @"Environmental and Social Studies (ESS)", @"French", @"Geography", @"German", @"Hebrew Studies", @"History", @"Home Economics", @"Irish", @"Italian", @"Latin", @"Materials Technology (Wood)", @"Mathematics", @"Metalwork", @"Music", @"Physical Education", @"Religious Education", @"Science", @"Social - Personal and Health Education", @"Spanish", @"Technical Graphics", @"Technology", @"Typewriting", nil];
    _secondCollectionViewHeightConstraint.constant = 420.;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Accounting", @"Agricultural Economics", @"Agricultural Science", @"Ancient Greek", @"Applied Mathematics", @"Arabic", @"Art", @"Biology", @"Business", @"Chemistry", @"Classical Studies", @"Construction Studies", @"Design and Communication Graphics", @"Economics", @"Engineering", @"English", @"French", @"Gaeilge", @"Geography", @"German", @"Hebrew Studies", @"History", @"Home Economics", @"Italian", @"Japanese", @"Latin", @"Mathematics", @"Music", @"Physics", @"Religious Education", @"Russian", @"Spanish", @"Technology", @"Chemistry", nil];
    _thirdCollectionViewHeightConstraint.constant = 510.;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Garda Vetting", @"Work Visa", @"References", @"Driving Licence", nil];
    _fourthCollectionViewHeightConstraint.constant = 60.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", nil];
    
    if (_isAdvertInEditingMode) {
        
        secondPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        
        thirdPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
        
        fourthPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        
        seventhPreselectedArr = [[NSMutableArray alloc] initWithArray:[[_advertDetailsDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"showUploadDocSegue" sender:nil];
}

- (IBAction)nextButtonTapped:(id)sender {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [self startAddCarerAdvertsService];
    }
    else {
        [self startAddParentAdvertsService];
    }
    
}

- (void) hideKeyboard {
    
    [self.view endEditing:YES];
    
}

#pragma mark - CollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _firstCollectionView) {
        return firstCollectionViewArr.count;
    }
    else if (collectionView == _secondCollectionView) {
        return secondCollectionViewArr.count;
    }
    else if (collectionView == _thirdCollectionView) {
        return thirdCollectionViewArr.count;
    }
    else if (collectionView == _forthCollectionView) {
        return fourthCollectionViewArr.count;
    }
    else if (collectionView == _fifthCollectionView) {
        return fifthCollectionViewArr.count;
    }
    else if (collectionView == _sixthCollectionView) {
        return sixthCollectionViewArr.count;
    }
    else if (collectionView == _seventhCollectionView) {
        return seventhCollectionViewArr.count;
    }
    else if (collectionView == _cvCollectionView) {
        return 1;
    }
    return 48.;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _daysRequiredCollectionView) {
        static NSString *CellIdentifier = @"ProfileAvailabilityCollectionViewCell";
        ProfileAvailabilityCollectionViewCell *cell = (ProfileAvailabilityCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProfileAvailabilityCollectionViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        [self populateContentForAvailabilityCell:cell atIndexPath:indexPath];
        
        return cell;
    }
    
    else if (collectionView == _cvCollectionView) {
        static NSString *CellIdentifier = @"AdvertPDFCollectionViewCell";
        AdvertPDFCollectionViewCell *cell = (AdvertPDFCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AdvertPDFCollectionViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        [self populateContentForCVCollectionViewCell:cell atIndexPath:indexPath];
        
        return cell;
    }
    
    
    static NSString *CellIdentifier = @"CreateAdvertsCollectionViewCell";
    CreateAdvertsCollectionViewCell *cell = (CreateAdvertsCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CreateAdvertsCollectionViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    if (collectionView == _firstCollectionView) {
        [self populateContentForFirstCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _secondCollectionView) {
        [self populateContentForSecondCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _thirdCollectionView) {
        [self populateContentForThirdCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _forthCollectionView) {
        [self populateContentForForthCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _fifthCollectionView) {
        [self populateContentForFifthCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _sixthCollectionView) {
        [self populateContentForSixthCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _seventhCollectionView) {
        [self populateContentForSeventhCollectionViewCell:cell atIndexPath:indexPath];
    }
    
    
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _daysRequiredCollectionView) {
        if (indexPath.row%8 == 0) {
            return CGSizeMake(75.,collectionView.frame.size.height/6.);
        }
        
        return CGSizeMake((((345./375.)*[UIScreen mainScreen].bounds.size.width) - 75.)/7.,collectionView.frame.size.height/6.);
    }
    else if (collectionView == _cvCollectionView) {
        return CGSizeMake(80, 44.);
    }
 
    return CGSizeMake((collectionView.frame.size.width)/2., 30);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

#pragma mark - CollectionView Delegates

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (collectionView == _daysRequiredCollectionView) {
        if (indexPath.row%8 != 0 && indexPath.row>=8) {
            
            int currentStatus = [[availabilityArr objectAtIndex:indexPath.row] intValue];
            [availabilityArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:!currentStatus]];
            [collectionView reloadData];
            
        }
    }
    
    
}


#pragma mark - Populate Content

- (void) populateContentForFirstCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [firstCollectionViewArr objectAtIndex:indexPath.row];

    UIView* cellTapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    cellTapView.userInteractionEnabled = YES;
    cellTapView.tag = indexPath.row;
    [cellTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnEMERCell:)]];
    [cell addSubview:cellTapView];
    
    if (isEMERType) {
        if (indexPath.row == 0) {
            cell.toggleButton.selected = YES;
        }
        else {
            cell.toggleButton.selected = NO;
        }
    }
    else {
        if (indexPath.row == 0) {
            cell.toggleButton.selected = NO;
        }
        else {
            cell.toggleButton.selected = YES;
        }
    }
    
}

- (void) populateContentForSecondCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [secondCollectionViewArr objectAtIndex:indexPath.row];
    cell.toggleButton.selected = NO;
    
    if ([secondPreselectedArr containsObject:cell.titleLabel.text]) {
        cell.toggleButton.selected = YES;
    }
    
}

- (void) populateContentForThirdCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [thirdCollectionViewArr objectAtIndex:indexPath.row];
    cell.toggleButton.selected = NO;
    
    if ([thirdPreselectedArr containsObject:cell.titleLabel.text]) {
        cell.toggleButton.selected = YES;
    }
    
}

- (void) populateContentForForthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [fourthCollectionViewArr objectAtIndex:indexPath.row];
    cell.toggleButton.selected = NO;
    
    if ([fourthPreselectedArr containsObject:cell.titleLabel.text]) {
        cell.toggleButton.selected = YES;
    }
    
}

- (void) populateContentForFifthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [fifthCollectionViewArr objectAtIndex:indexPath.row];
    cell.toggleButton.selected = NO;
    
    if ([fifthPreselectedArr containsObject:cell.titleLabel.text]) {
        cell.toggleButton.selected = YES;
    }
    
}

- (void) populateContentForSixthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [sixthCollectionViewArr objectAtIndex:indexPath.row];
    cell.toggleButton.selected = NO;
    
    if ([sixthPreselectedArr containsObject:cell.titleLabel.text]) {
        cell.toggleButton.selected = YES;
    }
    
    
}

- (void) populateContentForSeventhCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [seventhCollectionViewArr objectAtIndex:indexPath.row];
    cell.toggleButton.selected = NO;
    
    if ([seventhPreselectedArr containsObject:cell.titleLabel.text]) {
        cell.toggleButton.selected = YES;
    }
    
}

- (void) populateContentForAvailabilityCell:(ProfileAvailabilityCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row%8 == 0 || indexPath.row<8) {
        cell.backgroundColor = [UIColor colorWithRed:41./255 green:73./255. blue:97./255. alpha:1.0];
        cell.availabilityLabel.hidden = NO;
        
        switch (indexPath.row) {
            case 0:
                cell.availabilityLabel.text = @"Time Schedule";
                break;
            case 1:
                cell.availabilityLabel.text = @"MON";
                break;
            case 2:
                cell.availabilityLabel.text = @"TUE";
                break;
            case 3:
                cell.availabilityLabel.text = @"WED";
                break;
            case 4:
                cell.availabilityLabel.text = @"THU";
                break;
            case 5:
                cell.availabilityLabel.text = @"FRI";
                break;
            case 6:
                cell.availabilityLabel.text = @"SAT";
                break;
            case 7:
                cell.availabilityLabel.text = @"SUN";
                break;
            case 8:
                cell.availabilityLabel.text = @"Morning";
                break;
            case 16:
                cell.availabilityLabel.text = @"Afternoon";
                break;
            case 24:
                cell.availabilityLabel.text = @"Evening";
                break;
            case 32:
                cell.availabilityLabel.text = @"Night";
                break;
            case 40:
                cell.availabilityLabel.text = @"Overnight";
                break;
                
            default:
                break;
        }
        
    }
    else {
        if ([[availabilityArr objectAtIndex:indexPath.row] intValue]) {
            cell.backgroundColor = [UIColor colorWithRed:41./255 green:73./255. blue:97./255. alpha:1.0];
        }
        else {
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.availabilityLabel.hidden = YES;
    }
    
    cell.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    cell.layer.borderWidth = 0.5;
    
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnAvailabilityCell:)]];
    
}

- (void) populateContentForCVCollectionViewCell:(AdvertPDFCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void) didTapOnEMERCell:(UITapGestureRecognizer *)gesture {
    
    if (gesture.view.tag == 1) {
        isEMERType = NO;
    }
    else {
        isEMERType = YES;
    }
    
    [_firstCollectionView reloadData];
    
}

- (void) didTapOnAvailabilityCell:(UITapGestureRecognizer *)gesture {
    
    long index = gesture.view.tag;
    
    if (index%8 != 0 && index>=8) {
        
        int currentStatus = [[availabilityArr objectAtIndex:index] intValue];
        [availabilityArr replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:!currentStatus]];
        [_daysRequiredCollectionView reloadData];
        
    }
    
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

#pragma mark - API Helpers

- (void) startAddCarerAdvertsService {
    
    [SVProgressHUD showWithStatus:@"Updating Profile"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = AddCarerAdvert;
    manager.delegate = self;
    
    NSMutableDictionary* postDict = [[NSMutableDictionary alloc] init];
    
    if ([[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Tutor"]) {
        postDict = [self prepareDictionaryForTutorPostingAdvert];
    }
    else {
        postDict = [self prepareDictionaryForPostingAdvert];
    }
    
    [manager startPOSTingAdverDetails:postDict];
    
}

- (void) startAddParentAdvertsService {
    
    [SVProgressHUD showWithStatus:@"Updating Advert"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = AddParentAdvert;
    manager.delegate = self;
    
    NSMutableDictionary* postDict = [[NSMutableDictionary alloc] init];
    
    if ([[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Tutor"]) {
        postDict = [self prepareDictionaryForTutorPostingAdvert];
    }
    else {
        postDict = [self prepareDictionaryForPostingAdvert];
    }
    
    [manager startPOSTingAdverDetails:postDict];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:AddCarerAdvert]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Profile posted successfully"];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEditProfileMenuButtonHidden"];
        
    }
    
    if ([requestServiceKey isEqualToString:AddParentAdvert]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Advert posted successfully"];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEditProfileMenuButtonHidden"];
        
    }
    
    [self goBackToAdvertControlViewController];
    
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

- (NSMutableDictionary *) prepareDictionaryForPostingAdvert {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:_advertDetailsDict];
    
    NSString* booking = @"";
    
    for (int i = 0; i<availabilityArr.count; i++) {

        if ([[availabilityArr objectAtIndex:i] intValue]) {
            if ([booking isEqualToString:@""]) {
                booking = [NSString stringWithFormat:@"%@ %@", [self fullNameForWeekdayAvailabilityIndex:i], [self fullNameForAvailabilityIndex:i]];
            }
            else {
                booking = [NSString stringWithFormat:@"%@,%@ %@",booking,[self fullNameForWeekdayAvailabilityIndex:i],[self fullNameForAvailabilityIndex:i]];
            }
        }
        
    }
    [dict setObject:booking forKey:@"booking"];
    
    CreateAdvertsCollectionViewCell* emerCell = (CreateAdvertsCollectionViewCell*)[_firstCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (emerCell.toggleButton.isSelected) {
        [dict setObject:@"1" forKey:@"emer"];
    }
    else {
        [dict setObject:@"0" forKey:@"emer"];
    }
    
    NSString* mindLOC = @"";
    if (!_secondCollectionView.hidden) {
        for (int i = 0; i<secondCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_secondCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([mindLOC isEqualToString:@""]) {
                    mindLOC = [NSString stringWithFormat:@"%@", [tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"Parent" withString:@"Their"]];
                }
                else {
                    mindLOC = [NSString stringWithFormat:@"%@,%@",mindLOC,[tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"Parent" withString:@"Their"]];
                }
            }
        }
    }
    [dict setObject:mindLOC forKey:@"mind_loc"];
    
    
    NSString* ageGroup = @"";
    if (!_thirdCollectionView.hidden) {
        for (int i = 0; i<thirdCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_thirdCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([ageGroup isEqualToString:@""]) {
                    ageGroup = [NSString stringWithFormat:@"%@", [tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@"to"]];
                }
                else {
                    ageGroup = [NSString stringWithFormat:@"%@,%@",ageGroup,[tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@"to"]];
                }
            }
        }
    }
    
    if ([[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Cleaners"] || [[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"House Keepers"] || [[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Dog Walkers"] || [[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Pet Minders"]) {
        [dict setObject:ageGroup forKey:@"additional_optional"];
        [dict setObject:@"" forKey:@"age_group"];
    }
    else {
        [dict setObject:ageGroup forKey:@"age_group"];
    }
    
    
    
    NSString* require = @"";
    if (!_forthCollectionView.hidden) {
        for (int i = 0; i<fourthCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_forthCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([require isEqualToString:@""]) {
                    require = [NSString stringWithFormat:@"%@", tmpCell.titleLabel.text];
                }
                else {
                    require = [NSString stringWithFormat:@"%@,%@",require,tmpCell.titleLabel.text];
                }
            }
        }
    }
    [dict setObject:require forKey:@"require"];
    
    
    NSString* additional_optional = @"";
    if (!_fifthCollectionView.hidden) {
        for (int i = 0; i<fifthCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_fifthCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([additional_optional isEqualToString:@""]) {
                    additional_optional = [NSString stringWithFormat:@"%@", tmpCell.titleLabel.text];
                }
                else {
                    additional_optional = [NSString stringWithFormat:@"%@,%@",additional_optional,tmpCell.titleLabel.text];
                }
            }
        }
    }
    if (![[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Cleaners"] && ![[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"House Keepers"] && ![[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Dog Walkers"] && ![[_advertDetailsDict valueForKey:@"care_type"] isEqualToString:@"Pet Minders"]) {
        [dict setObject:additional_optional forKey:@"additional_optional"];
    }
    
    
    
    NSString* love_optional = @"";
    if (!_sixthCollectionView.hidden) {
        for (int i = 0; i<sixthCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_sixthCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([love_optional isEqualToString:@""]) {
                    love_optional = [NSString stringWithFormat:@"%@", tmpCell.titleLabel.text];
                }
                else {
                    love_optional = [NSString stringWithFormat:@"%@,%@",love_optional,tmpCell.titleLabel.text];
                }
            }
        }
    }
    [dict setObject:love_optional forKey:@"love_optional"];
    
    if ([[dict valueForKey:@"love_optional"] isEqualToString:@""] && !_otherRelevantInfoTextView.hidden) {
        [dict setObject:_otherRelevantInfoTextView.text forKey:@"love_optional"];
    }
    
    
    NSString* services = @"";
    if (!_seventhCollectionView.hidden) {
        for (int i = 0; i<seventhCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_seventhCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([services isEqualToString:@""]) {
                    services = [NSString stringWithFormat:@"%@", tmpCell.titleLabel.text];
                }
                else {
                    services = [NSString stringWithFormat:@"%@,%@",services,tmpCell.titleLabel.text];
                }
            }
        }
    }
    [dict setObject:services forKey:@"services"];
    
    if ([_isAdvertActiveLabel.text isEqualToString:@"No"]) {
        [dict setObject:@"0" forKey:@"job_ad_active"];
    }
    else {
        [dict setObject:@"1" forKey:@"job_ad_active"];
    }
    
    
    return dict;
    
}


- (NSMutableDictionary *) prepareDictionaryForTutorPostingAdvert {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:_advertDetailsDict];
    
    NSString* booking = @"";
    
    for (int i = 0; i<availabilityArr.count; i++) {
        
        if ([[availabilityArr objectAtIndex:i] intValue]) {
            if ([booking isEqualToString:@""]) {
                booking = [NSString stringWithFormat:@"%@ %@", [self fullNameForWeekdayAvailabilityIndex:i], [self fullNameForAvailabilityIndex:i]];
            }
            else {
                booking = [NSString stringWithFormat:@"%@,%@ %@",booking,[self fullNameForWeekdayAvailabilityIndex:i],[self fullNameForAvailabilityIndex:i]];
            }
        }
        
    }
    [dict setObject:booking forKey:@"booking"];
    
    CreateAdvertsCollectionViewCell* emerCell = (CreateAdvertsCollectionViewCell*)[_firstCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (emerCell.toggleButton.isSelected) {
        [dict setObject:@"1" forKey:@"emer"];
    }
    else {
        [dict setObject:@"0" forKey:@"emer"];
    }
    
    NSString* mindLOC = @"";
    if (!_secondCollectionView.hidden) {
        for (int i = 0; i<secondCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_secondCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([mindLOC isEqualToString:@""]) {
                    mindLOC = [NSString stringWithFormat:@"%@", [tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"Parent" withString:@"Their"]];
                }
                else {
                    mindLOC = [NSString stringWithFormat:@"%@,%@",mindLOC,[tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"Parent" withString:@"Their"]];
                }
            }
        }
    }
    [dict setObject:mindLOC forKey:@"additional_optional"];
    
    
    NSString* ageGroup = @"";
    if (!_thirdCollectionView.hidden) {
        for (int i = 0; i<thirdCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_thirdCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([ageGroup isEqualToString:@""]) {
                    ageGroup = [NSString stringWithFormat:@"%@", [tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@"to"]];
                }
                else {
                    ageGroup = [NSString stringWithFormat:@"%@,%@",ageGroup,[tmpCell.titleLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@"to"]];
                }
            }
        }
    }
    
    [dict setObject:ageGroup forKey:@"love_optional"];
    
    
    
    NSString* require = @"";
    if (!_forthCollectionView.hidden) {
        for (int i = 0; i<fourthCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_forthCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([require isEqualToString:@""]) {
                    require = [NSString stringWithFormat:@"%@", tmpCell.titleLabel.text];
                }
                else {
                    require = [NSString stringWithFormat:@"%@,%@",require,tmpCell.titleLabel.text];
                }
            }
        }
    }
    [dict setObject:require forKey:@"require"];

    
    NSString* services = @"";
    if (!_seventhCollectionView.hidden) {
        for (int i = 0; i<seventhCollectionViewArr.count; i++) {
            CreateAdvertsCollectionViewCell* tmpCell = (CreateAdvertsCollectionViewCell*)[_seventhCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (tmpCell.toggleButton.isSelected) {
                if ([services isEqualToString:@""]) {
                    services = [NSString stringWithFormat:@"%@", tmpCell.titleLabel.text];
                }
                else {
                    services = [NSString stringWithFormat:@"%@,%@",services,tmpCell.titleLabel.text];
                }
            }
        }
    }
    [dict setObject:services forKey:@"services"];
    
    if ([_isAdvertActiveLabel.text isEqualToString:@"No"]) {
        [dict setObject:@"0" forKey:@"job_ad_active"];
    }
    else {
        [dict setObject:@"1" forKey:@"job_ad_active"];
    }
    
    [dict setObject:@"" forKey:@"mind_loc"];
    [dict setObject:@"" forKey:@"age_group"];
    
    
    return dict;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _isAdvertActiveLabel) {
        [self advertActiveTextFieldTapped];
        return NO;
    }
    
    return YES;
    
}

- (void) advertActiveTextFieldTapped {
    
    [ActionSheetStringPicker showPickerWithTitle:@"" rows:[NSArray arrayWithObjects:@"Yes", @"No", nil] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        _isAdvertActiveLabel.text = selectedValue;
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (textView == _otherRelevantInfoTextView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView == _otherRelevantInfoTextView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}

- (void) goBackToAdvertControlViewController{
    
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[AdvertsViewController class]])
        {
            //Do not forget to import AnOldViewController.h
            
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }
}

@end
