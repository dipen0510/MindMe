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
    
    [self.daysRequiredCollectionView registerNib:[UINib nibWithNibName:@"ProfileAvailabilityCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileAvailabilityCollectionViewCell"];
    
    [self.firstCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.secondCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.thirdCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.forthCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.fifthCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.sixthCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.seventhCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    [self.cvCollectionView registerNib:[UINib nibWithNibName:@"AdvertPDFCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdvertPDFCollectionViewCell"];
    
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
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.text = @"Au Pair requires to live in or live out";
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Live In", @"Live Out", nil];
    
    _thirdCollectionViewTitle.text = @"Age Group Experience";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForBabysittersForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.text = @"Children minded in";
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    _thirdCollectionViewTitle.text = @"Age Group Experience";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForChildmindersForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.text = @"Children minded in";
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    _thirdCollectionViewTitle.text = @"Age Group Experience";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForCrecheForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.text = @"Children minded in";
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    _thirdCollectionViewTitle.text = @"Age Group Experience";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForNannyForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.text = @"Children minded in";
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Parent Home", @"Carers Home", nil];
    
    _thirdCollectionViewTitle.text = @"Age Group Experience";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"New Born", @"0 - 6 Months", @"6 Months - 2 years", @"2 years - 5 years", @"5 Years +", @"Teenagers", nil];
    
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Childcare Certification", @"Fetac Special Needs Certification", @"Tusla Registered", nil];
    
    _fifthCollectionViewTitle.text = @"Additional Requirements: (optional)";
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Light Housekeeping", @"Meal Preparation", @"Laundry", @"Errand / Shopping", @"Homework Help", @"Willing to Drive Children", nil];
    
    _sixthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Sports", @"Arts & crafts", @"Outdoor Activity", @"Music & Drama", @"Games", @"Reading", nil];
    
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForCleanersForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    _thirdCollectionViewTitle.text = @"Cleaning Services You Can Provide";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Bathroom Cleaning", @"Dishes", @"Plant Care", @"Kitchen Cleaning", @"Oven Cleaning", @"Window Washing", @"Pet Cleanup", @"General Room Cleaning", @"Surface Polishing", @"Packing and Unpacking", @"Bed Changing", @"Carpet Cleaning", @"Attic Cleaning", @"Furniture Treatment", @"Basement Cleaning", @"Refrigerator Cleaning", @"Wall Washing", @"House Sitting", @"Cabinet Cleaning", @"Laundry", @"Organization", @"External Cleaning", nil];
    _thirdCollectionViewHeightConstraint.constant = 330;
    
    _fourthCollectionViewTitle.text = @"Do You Have Documentation";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Garda Vetting", @"Work Visa", @"References", @"Driving Licence", nil];
    _fourthCollectionViewHeightConstraint.constant = 60.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Creche", @"Dog walkers", @"Elderly Care", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForDayWalkersForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    _thirdCollectionViewTitle.text = @"Pets You Have Experience With";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Dogs", @"Cats", @"Birds", @"Fish", @"Amphibians", @"Mammals", @"Horses", @"Farm Animals", @"Exotic Pets", @"Other Pets", nil];
    _thirdCollectionViewHeightConstraint.constant = 150;
    
    _fourthCollectionViewTitle.text = @"You Can Provide";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Play & Exercise", @"First Aid", @"Training", @"Boarding", @"Waste Cleanup", @"Overnight Care", @"Walking", @"Feeding", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForElderlyCareForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;    _thirdCollectionViewTitle.text = @"Age Group Experience";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"55 - 65 Years", @"65 to 75 Years", @"75 to 85 Years", @"85+ Years", nil];
    _thirdCollectionViewHeightConstraint.constant = 60.;
    
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Special Needs Certification", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.text = @"Additional Services You Can Provide";
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Companion Services", @"Home Nursing Care", @"Home Help Services", @"Transportation", @"Live-in Care", @"Homecare Services", @"Meal Preparation", @"Personal Care (e.g. Bathing, Grooming)", nil];
    _fifthCollectionViewHeightConstraint.constant = 120.;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -44 - _sixthCollectionViewHeightConstraint.constant;
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForHousekeepersForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    _thirdCollectionViewTitle.text = @"House Keeping Services You Can Provide";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Bathroom Cleaning", @"Dishes", @"Plant Care", @"Kitchen Cleaning", @"Oven Cleaning", @"Window Washing", @"Pet Cleanup", @"General Room Cleaning", @"Surface Polishing", @"Packing and Unpacking", @"Bed Changing",@"Carpet Cleaning", @"Attic Cleaning", @"Furniture Treatment", @"Basement Cleaning", @"Refrigerator Cleaning", @"Wall Washing", @"House Sitting", @"Cabinet Cleaning", @"Laundry", @"Organization", @"External Cleaning", nil];
    _thirdCollectionViewHeightConstraint.constant = 330;
    
    _fourthCollectionViewTitle.text = @"Do You Have Documentation";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Garda Vetting", @"Work Visa", @"References", @"Driving Licence", nil];
    _fourthCollectionViewHeightConstraint.constant = 60.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForMaternityNurseForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
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
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForPetMindersForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;
    _thirdCollectionViewTitle.text = @"Pets You Have Experience With";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Dogs", @"Cats", @"Birds", @"Fish", @"Amphibians", @"Mammals", @"Horses", @"Farm Animals", @"Exotic Pets", @"Other Pets", nil];
    _thirdCollectionViewHeightConstraint.constant = 150;
    
    _fourthCollectionViewTitle.text = @"You Can Provide";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Play & Exercise", @"First Aid", @"Training", @"Boarding", @"Waste Cleanup", @"Overnight Care", @"Walking", @"Feeding", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForPrivateMidwifeForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
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
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"School Run", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForSchoolRunForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;    _thirdCollectionViewTitle.text = @"Provide Transport For";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Infants (0-1 year of age)", @"Toddlers (1-3 years of age)", @"Preschoolers (3-5 years of age)", @"Middle Childhood (6-12 years of age)", @"Teenagers (15-19 years of age)", @"Adult", @"Elderly", @"Special Needs (wheel chair access)", nil];
    _thirdCollectionViewHeightConstraint.constant = 120.;
    
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
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"Special Needs Care", @"Tutor", nil];
    
}

- (void) setupUIForSpecialNeedsCareForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -44 - _secondCollectionViewHeightConstraint.constant;    _thirdCollectionViewTitle.text = @"Age Group Experience";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Infant (up to 12 months)", @"Youth (2-12 years)", @"Teen (13-19 years)", @"Adult (20-64 years)", @"Elderly Person (65+)", nil];
    _thirdCollectionViewHeightConstraint.constant = 90.;
    
    _fourthCollectionViewTitle.text = @"Do You Have Qualifications";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Work Visa", @"Eu Passport", @"References", @"Driving Licence", @"Fetac Special Needs Certification", nil];
    _fourthCollectionViewHeightConstraint.constant = 120.;
    
    _fifthCollectionViewTitle.text = @"I Have Experience With";
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"ADD", @"ADHD", @"Aspergers", @"Asthma", @"Autism", @"Autism Spectrum Disorder", @"Blindness/Visual Impairment", @"Cancer", @"Celiac", @"Central Auditory Disorder", @"Cerebral Palsy", @"Cognitive Disabilities", @"Cystic Fibrosis", @"Deafness", @"Developmental Delays", @"Diabetes", @"Down Syndrome", @"Dwarfism", @"Dyslexia", @"Epilepsy", @"Fetal Alcohol Syndrome", @"Food Allergies", @"Fragile X", @"Heart Defects", @"Hydrocephaly", @"Mental Illness", @"Mobility Challenges", @"Multiple Sclerosis", @"Muscular Dystrophy", @"Obesity", @"Pervasive Developmental Disorder", @"Polymicrogyria", @"Prader Willi", @"Rett Syndrome", @"Seizure Disorder", @"Sensory Integration Disorder", @"Speech Delay", @"Spinal Cord Injury", @"Thyroid Condition", @"Tourette Syndrome", nil];
    _fifthCollectionViewHeightConstraint.constant = 600;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -44 - _sixthCollectionViewHeightConstraint.constant;
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Tutor", nil];
    
}

- (void) setupUIForTutorForm {
    
    _firstCollectionViewTitle.text = @"Can you provide Last Minute / Emergency Cover:";
    firstCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
    
    _secondCollectionViewTitle.text = @"Junior Cycle Subjects";
    secondCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Ancient Greek", @"Art - Craft - Design", @"Business Studies", @"Civic - Social and Political Education", @"Classical Studies", @"English", @"Environmental and Social Studies (ESS)", @"French", @"Geography", @"German", @"Hebrew Studies", @"History", @"Home Economics", @"Irish", @"Italian", @"Latin", @"Materials Technology (Wood)", @"Mathematics", @"Metalwork", @"Music", @"Physical Education", @"Religious Education", @"Science", @"Social - Personal and Health Education", @"Spanish", @"Technical Graphics", @"Technology", @"Typewriting", nil];
    _secondCollectionViewHeightConstraint.constant = 420.;
    
    _thirdCollectionViewTitle.text = @"Senior Cycle Subjects";
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Accounting", @"Agricultural Economics", @"Agricultural Science", @"Ancient Greek", @"Applied Mathematics", @"Arabic", @"Art", @"Biology", @"Business", @"Chemistry", @"Classical Studies", @"Construction Studies", @"Design and Communication Graphics", @"Economics", @"Engineering", @"English", @"French", @"Gaeilge", @"Geography", @"German", @"Hebrew Studies", @"History", @"Home Economics", @"Italian", @"Japanese", @"Latin", @"Mathematics", @"Music", @"Physics", @"Religious Education", @"Russian", @"Spanish", @"Technology", @"Chemistry", nil];
    _thirdCollectionViewHeightConstraint.constant = 510.;
    
    _fourthCollectionViewTitle.text = @"Do You Have Documentation";
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Garda Vetting", @"Work Visa", @"References", @"Driving Licence", nil];
    _fourthCollectionViewHeightConstraint.constant = 60.;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitle.hidden = YES;
    _sixthCollectionView.hidden = YES;
    _sixthCollectionSeparatorView.hidden = YES;
    
    _seventhCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _sixthCollectionViewHeightConstraint.constant;
    _seventhCollectionViewTitle.text = @"Other Services I Can Offer";
    seventhCollectionViewArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", nil];
    
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
    
    
}

- (void) populateContentForSecondCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [secondCollectionViewArr objectAtIndex:indexPath.row];
    
    
}

- (void) populateContentForThirdCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [thirdCollectionViewArr objectAtIndex:indexPath.row];
    
}

- (void) populateContentForForthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [fourthCollectionViewArr objectAtIndex:indexPath.row];
    
}

- (void) populateContentForFifthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [fifthCollectionViewArr objectAtIndex:indexPath.row];
    
}

- (void) populateContentForSixthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [sixthCollectionViewArr objectAtIndex:indexPath.row];
    
    
}

- (void) populateContentForSeventhCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [seventhCollectionViewArr objectAtIndex:indexPath.row];
    
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
    
}

- (void) populateContentForCVCollectionViewCell:(AdvertPDFCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    
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
