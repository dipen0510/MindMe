//
//  AdsDetailViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 09/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AdsDetailViewController.h"
#import "ProfileAvailabilityCollectionViewCell.h"
#import "AdsDetailCollectionViewCell.h"
#import "AddReviewViewController.h"
#import "ReviewsTableViewCell.h"
#import "ChatStartViewController.h"

@interface AdsDetailViewController ()

@end

@implementation AdsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupAvailibilityArr];
    [self setupValueLayoutForAdvert];
    [self setupUIForForms];
    [self setupPixelPerfectUI];
    
    if (![[SharedClass sharedInstance] isGuestUser]) {
        [self startCheckLikeDislikeService];
        [self startGetAllReviewService];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.view layoutIfNeeded];
    
    self.firstCollectionViewHeightConstraint.constant = self.firstCollectionView.contentSize.height;
    self.secondCollectionViewHeightConstraint.constant = self.secondCollectionView.contentSize.height;
    self.thirdCollectionViewHeightConstraint.constant = self.thirdCollectionView.contentSize.height;
    self.fourthCollectionViewHeightConstraint.constant = self.fourthCollectionView.contentSize.height;
    self.fifthCollectionViewHeightConstraint.constant = self.fifthCollectionView.contentSize.height;
    self.sixthCollectionViewHeightConstraint.constant = self.sixthCollectionView.contentSize.height;
    
    _aboutTextViewHeightConstraint.constant = self.aboutTextView.contentSize.height;
//    _otherRelevantInfoHeightConstraint.constant = self.otherRelevantInfoTextView.contentSize.height;
    
}

- (void) setupInitialUI {
    
    _contactButton.layer.cornerRadius = 20.0;
    _contactButton.layer.masksToBounds = NO;
    
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.height/2.;
    _profileImgView.layer.masksToBounds = YES;
    
    _locationPinLeadingConstraint.constant = (130./375.) * [UIScreen mainScreen].bounds.size.width;
    _yearsOfExpLeadingConstraint.constant = (130./375.) * [UIScreen mainScreen].bounds.size.width;
    
    [self.daysRequiredCollectionView registerNib:[UINib nibWithNibName:@"ProfileAvailabilityCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileAvailabilityCollectionViewCell"];
    
    [self.firstCollectionView registerNib:[UINib nibWithNibName:@"AdsDetailCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdsDetailCollectionViewCell"];
    [self.secondCollectionView registerNib:[UINib nibWithNibName:@"AdsDetailCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdsDetailCollectionViewCell"];
    [self.thirdCollectionView registerNib:[UINib nibWithNibName:@"AdsDetailCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdsDetailCollectionViewCell"];
    [self.fourthCollectionView registerNib:[UINib nibWithNibName:@"AdsDetailCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdsDetailCollectionViewCell"];
    [self.fifthCollectionView registerNib:[UINib nibWithNibName:@"AdsDetailCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdsDetailCollectionViewCell"];
    [self.sixthCollectionView registerNib:[UINib nibWithNibName:@"AdsDetailCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"AdsDetailCollectionViewCell"];
    
    _firstCollectionView.dataSource = self;
    _firstCollectionView.delegate = self;
    
    _secondCollectionView.dataSource = self;
    _secondCollectionView.delegate = self;
    
    _thirdCollectionView.dataSource = self;
    _thirdCollectionView.delegate = self;
    
    _fourthCollectionView.dataSource = self;
    _fourthCollectionView.delegate = self;
    
    _fifthCollectionView.dataSource = self;
    _fifthCollectionView.delegate = self;
    
    _sixthCollectionView.dataSource = self;
    _sixthCollectionView.delegate = self;
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _footerContactButton.hidden = NO;
        [_doneButton setTitle:@"" forState:UIControlStateNormal];
        [_cancelButton setTitle:@"" forState:UIControlStateNormal];
        [_doneButton setBackgroundColor:[UIColor clearColor]];
        [_cancelButton setBackgroundColor:[UIColor clearColor]];
        [_doneButton setBackgroundImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"review_btn"] forState:UIControlStateNormal];
        _doneButtonHeightConstraint.constant = (([UIScreen mainScreen].bounds.size.width - 84)/2.) * (47./180.);
        
        _ageLabel.text = [NSString stringWithFormat:@"%ld Years Old",[self ageFromYear:[_advertDict valueForKey:@"birth_year"] Month:[_advertDict valueForKey:@"birth_month"] day:[_advertDict valueForKey:@"birth_day"]]];
        
        [self startIncrementAdvertsViewService];
    }
    else {
        
        _footerContactButton.hidden = NO;
        _doneButton.hidden = YES;
        _cancelButton.hidden = YES;
        _carerLikeButton.hidden = NO;
        _doneButtonHeightConstraint.constant = (([UIScreen mainScreen].bounds.size.width - 84)/2.) * (47./180.);
        _yearsExperienceLabel.text = @"Years of Experience needed :";

        _reviewStaticLabel.hidden = YES;
        _reviewTblView.hidden = YES;
        _noReviewsLabel.hidden = YES;
        _cancelButtonTopConstraint.constant = -35;
        
        _mobileValueLabel.hidden = YES;
        _mobileStaticLabel.hidden = YES;
        _mobileStaticLabel2.hidden = YES;
        _mobileSeparatorView.hidden = YES;
        _carImgViewTopConstraint.constant = -120;
        
        _cvStaticLabel.hidden = YES;
        _cvValueLabel.hidden = YES;
        
        _genderStaticLabel.hidden = YES;
        _genderValueLabel.hidden = YES;
        
        _genderSeparatorViewTopConstraint.constant = -50.;
        
        _ageLabel.hidden = YES;
        _locationTopConstraint.constant = -15;
    
    }
    
    reviewArr = [[NSMutableArray alloc] init];
    _reviewTblViewHeightConstraint.constant = 0;
    
    [_footerContactButton addTarget:self action:@selector(contactMeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self.mobileValueLabel action:@selector(tapDetected)];
    [self.view addGestureRecognizer:tgr];
    
}

- (void) setupPixelPerfectUI {
    
    _nameLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    _careTypeLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    _ageLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    _locationLabel.font = _addressLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    _experienceValueLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    _rateLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    _rateStaticLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
    _memberSinceLabel.font = _memberSinceStaticLabel.font = _lastLoginLabel.font = _lastLoginStaticLabel.font = _genderValueLabel.font = _genderStaticLabel.font = _cvValueLabel.font = _cvStaticLabel.font = _haveACaerLabel.font = _comfortableWithpetsLabel.font = _shortNoticeLabel.font = _nonSmokerLabel.font = _languagesValueLabel.font = _eduLevelLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
     _aboutStaticLabel.font =  _mobileStaticLabel.font = _firstCollectionViewTitle.font = _secondCollectionViewTitle.font = _thirdCollectionViewTitle.font = _fourthCollectionViewTitle.font = _fifthCollectionViewTitle.font = _sixthCollectionViewTitle.font = _availabilityStaicLabel.font = _reviewStaticLabel.font = _otherRelevantInfoStaticLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(17.5/667)*kScreenHeight];
    
    _aboutTextView.font = _mobileValueLabel.font = _mobileStaticLabel2.font = _noReviewsLabel.font = _otherRelevantInfoTextView.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _footerContactButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(17.5/667)*kScreenHeight];
    
}

- (void) setupAvailibilityArr {
    
    availabilityArr = [[NSMutableArray alloc] init];
    
    NSMutableArray* bookingArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"booking"] componentsSeparatedByString:@","]];
    NSMutableArray* indexArr = [[NSMutableArray alloc] init];
    
    for (NSString* str in bookingArr) {
        int i = [self fullNameForAvailabilityIndex:[[str componentsSeparatedByString:@" "] lastObject]]*8 + [self fullNameForWeekdayAvailabilityIndex:[[str componentsSeparatedByString:@" "] firstObject]];
        [indexArr addObject:[NSNumber numberWithInt:i]];
    }
    
    for (int i = 0; i<48; i++) {
        
        if ([indexArr containsObject:[NSNumber numberWithInt:i]]) {
            [availabilityArr addObject:[NSNumber numberWithInt:1]];
        }
        else {
            [availabilityArr addObject:[NSNumber numberWithInt:0]];
        }
        
    }
    
}

- (void) setupValueLayoutForAdvert {
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@.",[_advertDict valueForKey:@"first_name"],[[_advertDict valueForKey:@"second_name"] substringToIndex:1]];
    _locationLabel.text = [NSString stringWithFormat:@"%0.2f km Away",[[_advertDict valueForKey:@"distance"] floatValue]];
    _addressLabel.text = [[SharedClass sharedInstance] filterNumbersAndPostCodeFromAddressString:[_advertDict valueForKey:@"address1"]];
    
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _experienceValueLabel.text = [NSString stringWithFormat:@"Experience Required : %@ years",[_advertDict valueForKey:@"experience"]];
        _careTypeLabel.text = [NSString stringWithFormat:@"%@ Required",[_advertDict valueForKey:@"care_type"]];
    }
    else {
        _experienceValueLabel.text = [NSString stringWithFormat:@"%@ years Experience",[_advertDict valueForKey:@"experience"]];
        _careTypeLabel.text = [_advertDict valueForKey:@"care_type"];
    }
    
    [[SharedClass sharedInstance] removePluralsFromCareTypeLabel:_careTypeLabel];
    
    _aboutTextView.text = [_advertDict valueForKey:@"about_you"];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _jobActiveViewsLabel.hidden = YES;
    }
    else {
        _jobActiveViewsLabel.hidden = NO;
        _jobActiveViewsLabel.text = [NSString stringWithFormat:@"Job Active %@ views",[_advertDict valueForKey:@"viewed"]];
    }
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    if ([[responseData valueForKey:@"Sub_active"] intValue] == 1) {
        _mobileValueLabel.text = [_advertDict valueForKey:@"mobile_number"];
    }
    else {
        _mobileValueLabel.text = @"xxxxxxxxxx";
    }
    
    _rateLabel.text = [_advertDict valueForKey:@"pay"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter* dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateStyle:NSDateFormatterMediumStyle];
    
    _lastLoginLabel.text = [self getStringFromMillisecondsDate:[[_advertDict valueForKey:@"ctime"] doubleValue]];
    _memberSinceLabel.text = [dateFormatter1 stringFromDate:[dateFormatter dateFromString:[_advertDict valueForKey:@"date"]]];
    
    if ([[_advertDict valueForKey:@"additionals"] containsString:@"Have a car"]) {
        _haveACarImgView.image = [UIImage imageNamed:@"ic_green_correct"];
    }
    else {
        _haveACarImgView.image = [UIImage imageNamed:@"ic_cross"];
    }
    
    if ([[_advertDict valueForKey:@"additionals"] containsString:_comfortableWithpetsLabel.text]) {
        _comfortableWithPetsImgView.image = [UIImage imageNamed:@"ic_green_correct"];
    }
    else {
        _comfortableWithPetsImgView.image = [UIImage imageNamed:@"ic_cross"];
    }
    
//    if ([[_advertDict valueForKey:@"additionals"] containsString:_acceptOnlinePaymentLabel.text]) {
//        _acceptOnlinePaymentImgView.image = [UIImage imageNamed:@"ic_green_correct"];
//    }
//    else {
//        _acceptOnlinePaymentImgView.image = [UIImage imageNamed:@"ic_cross"];
//    }
    
    if ([[_advertDict valueForKey:@"additionals"] containsString:_nonSmokerLabel.text]) {
        _nonSmokerImgView.image = [UIImage imageNamed:@"ic_green_correct"];
    }
    else {
        _nonSmokerImgView.image = [UIImage imageNamed:@"ic_cross"];
    }
    
    if ([[_advertDict valueForKey:@"emer"] intValue] == 1) {
        _shortNoticeImgView.image = [UIImage imageNamed:@"ic_green_correct"];
    }
    else {
        _shortNoticeImgView.image = [UIImage imageNamed:@"ic_cross"];
    }
    
    _languagesValueLabel.text = [NSString stringWithFormat:@"Languages: %@",[_advertDict valueForKey:@"languages"]];
    
    if (![[_advertDict valueForKey:@"image_path"] isEqualToString:@""]) {
        __weak UIImageView* weakImageView = _profileImgView;
        [_profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceURL,[_advertDict valueForKey:@"image_path"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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
        _profileImgView.image = [UIImage imageNamed:@"profile_icon"];
    }
    
}

- (void) setupUIForForms {
    
    NSString* careType = [_advertDict valueForKey:@"care_type"];
    
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
    
    [self hideSectionsIfNoContent];
    
}

- (void) hideSectionsIfNoContent {
    
    if (firstCollectionViewArr.count == 0 && !_firstCollectionView.hidden) {
        _firstCollectionViewTitle.hidden = YES;
        _firstCollectionView.hidden = YES;
        _firstCollectionViewSeparatorView.hidden = YES;
        _secondCollectionViewTitleTopConstraint.constant = _secondCollectionViewTitleTopConstraint.constant - 80;
    }
    if (secondCollectionViewArr.count == 0 && !_secondCollectionView.hidden) {
        _secondCollectionViewTitle.hidden = YES;
        _secondCollectionView.hidden = YES;
        _secondCollectionViewSeparatorView.hidden = YES;
        _thirdCollectionViewTitleTopConstraint.constant = _thirdCollectionViewTitleTopConstraint.constant - 80;
    }
    if (thirdCollectionViewArr.count == 0 && !_thirdCollectionView.hidden) {
        _thirdCollectionViewTitle.hidden = YES;
        _thirdCollectionView.hidden = YES;
        _thirdCollectionViewSeparatorView.hidden = YES;
        _fourthCollectionViewTitleTopConstraint.constant = _fourthCollectionViewTitleTopConstraint.constant - 80;
    }
    if (fourthCollectionViewArr.count == 0 && !_fourthCollectionView.hidden) {
        _fourthCollectionViewTitle.hidden = YES;
        _fourthCollectionView.hidden = YES;
        _fourthCollectionViewSeparatorView.hidden = YES;
        _fifthCollectionViewTitleTopConstraint.constant = _fifthCollectionViewTitleTopConstraint.constant - 80;
    }
    if (fifthCollectionViewArr.count == 0 && !_fifthCollectionView.hidden) {
        _fifthCollectionViewTitle.hidden = YES;
        _fifthCollectionView.hidden = YES;
        _fifthCollectionViewSeparatorView.hidden = YES;
        _sixthCollectionViewTitleTopConstraint.constant = _sixthCollectionViewTitleTopConstraint.constant - 80;
    }
    if (sixthCollectionViewArr.count == 0 && !_sixthCollectionView.hidden) {
        _sixthCollectionViewTitle.hidden = YES;
        _sixthCollectionView.hidden = YES;
        _sixthCollectionViewSeparatorView.hidden = YES;
        
        if (!_otherRelevantInfoTextView.hidden) {
            _otherRelevantInfoTopConstraint.constant = _otherRelevantInfoTopConstraint.constant - 80;
        }
        
        _daysRequiredLabelTopConstraint.constant = _daysRequiredLabelTopConstraint.constant - 80;
        
        
    }
    
    
}


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"showContactSegue"] && [[SharedClass sharedInstance] isGuestUser]) {
        
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
        return NO;
        
    }
    if ([identifier isEqualToString:@"showReviewSegue"]) {
        
        if ([[SharedClass sharedInstance] isGuestUser]) {
            [self.sideMenuController.navigationController popViewControllerAnimated:YES];
            return NO;
        }
    }
    
    return YES;
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showReviewSegue"]) {
        
        AddReviewViewController* controller = (AddReviewViewController *)[segue destinationViewController];
        controller.advertDict = _advertDict;
        
    }
    if ([segue.identifier isEqualToString:@"showChatStartSegue"]) {
        
        ChatStartViewController* controller = (ChatStartViewController *)[segue destinationViewController];
        controller.advertDict = _advertDict;
        controller.isOpenedFromFavorites = _isOpenedFromFavorites;
        
    }
    
}


- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonTapped:(id)sender {
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self startLikeDislikeService];
    
}

- (IBAction)shareButtonTapped:(id)sender {
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
        return;
        
    }
    
    NSString* sharingText = [NSString stringWithFormat:@"Hi My name is %@ and I am looking for a position as a %@ in %@. Check out My Profile on www.MindMe.ie for more information.\nhttps://www.mindme.ie/profile_details.php?hid=%@&&a_id=%@",[_advertDict valueForKey:@"first_name"],[_advertDict valueForKey:@"care_type"],[_advertDict valueForKey:@"address1"],[_advertDict valueForKey:@"md5_id"],[_advertDict valueForKey:@"Userid"]];
    
    UIActivityViewController *activityVC=[[UIActivityViewController alloc]initWithActivityItems:[[NSMutableArray alloc]initWithObjects:sharingText, nil] applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}

- (void) contactMeButtonTapped {
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
        return;
        
    }
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    if (![[SharedClass sharedInstance] isUserCarer] && [[responseData valueForKey:@"Sub_active"] intValue] != 1) {
        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"BuyPlansForParentsViewController" forSideMenuController:self.sideMenuController];
    }
    else {
        [self performSegueWithIdentifier:@"showChatStartSegue" sender:nil];
    }

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
    else if (collectionView == _fourthCollectionView) {
        return fourthCollectionViewArr.count;
    }
    else if (collectionView == _fifthCollectionView) {
        return fifthCollectionViewArr.count;
    }
    else if (collectionView == _sixthCollectionView) {
        return sixthCollectionViewArr.count;
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
    
    static NSString *CellIdentifier = @"AdsDetailCollectionViewCell";
    AdsDetailCollectionViewCell *cell = (AdsDetailCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AdsDetailCollectionViewCell" owner:self options:nil];
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
    else if (collectionView == _fourthCollectionView) {
        [self populateContentForForthCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _fifthCollectionView) {
        [self populateContentForFifthCollectionViewCell:cell atIndexPath:indexPath];
    }
    else if (collectionView == _sixthCollectionView) {
        [self populateContentForSixthCollectionViewCell:cell atIndexPath:indexPath];
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
    
    if (collectionView == _firstCollectionView) {
        NSString* str = [firstCollectionViewArr objectAtIndex:indexPath.row];
        return CGSizeMake((collectionView.frame.size.width)/2., [self height:str] /*(40./568.)*kScreenHeight*/);
    }
    
    else if (collectionView == _secondCollectionView) {
        NSString* str = [secondCollectionViewArr objectAtIndex:indexPath.row];
        return CGSizeMake((collectionView.frame.size.width)/2., [self height:str] /*(40./568.)*kScreenHeight*/);
    }
    
    else if (collectionView == _thirdCollectionView) {
        NSString* str = [thirdCollectionViewArr objectAtIndex:indexPath.row];
        return CGSizeMake((collectionView.frame.size.width)/2., [self height:str] /*(40./568.)*kScreenHeight*/);
    }
    
    else if (collectionView == _fourthCollectionView) {
        NSString* str = [fourthCollectionViewArr objectAtIndex:indexPath.row];
        return CGSizeMake((collectionView.frame.size.width)/2., [self height:str] /*(40./568.)*kScreenHeight*/);
    }
    
    else if (collectionView == _fifthCollectionView) {
        NSString* str = [fifthCollectionViewArr objectAtIndex:indexPath.row];
        return CGSizeMake((collectionView.frame.size.width)/2., [self height:str] /*(40./568.)*kScreenHeight*/);
    }
    
    else {
        NSString* str = [sixthCollectionViewArr objectAtIndex:indexPath.row];
        return CGSizeMake((collectionView.frame.size.width)/2., [self height:str] /*(40./568.)*kScreenHeight*/);
    }
    
    
    
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
    
    
//        if (indexPath.row%8 != 0 && indexPath.row>=8) {
//            
//            int currentStatus = [[availabilityArr objectAtIndex:indexPath.row] intValue];
//            [availabilityArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:!currentStatus]];
//            [collectionView reloadData];
//            
//        }

    
}


#pragma mark - Populate Content

- (void) populateContentForFirstCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [firstCollectionViewArr objectAtIndex:indexPath.row];
    cell.detailsTextLabel.textColor = _aboutTextView.textColor;
//    cell.detailsTextLabel.font = _careTypeLabel.font;
    
    cell.detailsTickImgView.hidden = NO;
//    cell.detailsTextLabelLeadingConstraint.constant = 31.;
    
}

- (void) populateContentForSecondCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [secondCollectionViewArr objectAtIndex:indexPath.row];
    cell.detailsTextLabel.textColor = _aboutTextView.textColor;
//    cell.detailsTextLabel.font = _careTypeLabel.font;
    
    cell.detailsTickImgView.hidden = NO;
//    cell.detailsTextLabelLeadingConstraint.constant = 31.;
    
}

- (void) populateContentForThirdCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [thirdCollectionViewArr objectAtIndex:indexPath.row];
    cell.detailsTextLabel.textColor = _aboutTextView.textColor;
//    cell.detailsTextLabel.font = _careTypeLabel.font;
    
    cell.detailsTickImgView.hidden = NO;
//    cell.detailsTextLabelLeadingConstraint.constant = 31.;
    
}

- (void) populateContentForForthCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [fourthCollectionViewArr objectAtIndex:indexPath.row];
    cell.detailsTextLabel.textColor = _aboutTextView.textColor;
//    cell.detailsTextLabel.font = _careTypeLabel.font;
    
    cell.detailsTickImgView.hidden = NO;
//    cell.detailsTextLabelLeadingConstraint.constant = 31.;
    
}

- (void) populateContentForFifthCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [fifthCollectionViewArr objectAtIndex:indexPath.row];
    cell.detailsTextLabel.textColor = _aboutTextView.textColor;
//    cell.detailsTextLabel.font = _careTypeLabel.font;
    
    cell.detailsTickImgView.hidden = NO;
//    cell.detailsTextLabelLeadingConstraint.constant = 31.;
    
}

- (void) populateContentForSixthCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [sixthCollectionViewArr objectAtIndex:indexPath.row];
    cell.detailsTextLabel.textColor = _aboutTextView.textColor;
//    cell.detailsTextLabel.font = _careTypeLabel.font;
    
    cell.detailsTickImgView.hidden = NO;
//    cell.detailsTextLabelLeadingConstraint.constant = 31.;
    
}

- (void) populateContentForAvailabilityCell:(ProfileAvailabilityCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row%8 == 0 || indexPath.row<8) {
        cell.backgroundColor = [UIColor colorWithRed:41./255 green:73./255. blue:97./255. alpha:1.0];
        cell.availabilityLabel.hidden = NO;
        cell.availabilityLabel.numberOfLines = 1;
        cell.availabilityImgView.hidden = YES;
        
        switch (indexPath.row) {
            case 0:
                cell.availabilityLabel.text = @"Time Schedule";
                cell.availabilityLabel.numberOfLines = 2;
                break;
            case 1:
                cell.availabilityLabel.text = @"Mon";
                break;
            case 2:
                cell.availabilityLabel.text = @"Tue";
                break;
            case 3:
                cell.availabilityLabel.text = @"Wed";
                break;
            case 4:
                cell.availabilityLabel.text = @"Thu";
                break;
            case 5:
                cell.availabilityLabel.text = @"Fri";
                break;
            case 6:
                cell.availabilityLabel.text = @"Sat";
                break;
            case 7:
                cell.availabilityLabel.text = @"Sun";
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
            cell.availabilityImgView.hidden = NO;
        }
        else {
            cell.availabilityImgView.hidden = YES;
        }
        cell.availabilityLabel.hidden = YES;
    }
    
    cell.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    cell.layer.borderWidth = 0.5;
    
}


- (int) fullNameForAvailabilityIndex:(NSString *)str {
    
    if ([str isEqualToString:@"Morning"]) {
        return 1;
    }
    else if ([str isEqualToString:@"Afternoon"]) {
        return 2;
    }
    else if ([str isEqualToString:@"Evening"]) {
        return 3;
    }
    else if ([str isEqualToString:@"Night"]) {
        return 4;
    }
    
    return 5;
    
}

- (int) fullNameForWeekdayAvailabilityIndex:(NSString *)str {
    
    if ([str isEqualToString:@"Monday"]) {
        return 1;
    }
    else if ([str isEqualToString:@"Tuesday"]) {
        return 2;
    }
    else if ([str isEqualToString:@"Wednesday"]) {
        return 3;
    }
    else if ([str isEqualToString:@"Thursday"]) {
        return 4;
    }
    else if ([str isEqualToString:@"Friday"]) {
        return 5;
    }
    else if ([str isEqualToString:@"Saturday"]) {
        return 6;
    }
    
    return 7;
    
}


- (void) setupUIForAUPairForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Au Pair requires to live in or live out";
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Au Pair required to live in or live out";
        _secondCollectionViewTitle.text = @"Carer should have experience with";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[[_advertDict valueForKey:@"aupair_live"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (firstCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fourthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fifthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
}

- (void) setupUIForBabysittersForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Carer should have experience with";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[[_advertDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
        if ([[firstCollectionViewArr lastObject] isEqualToString:@""]) {
            [firstCollectionViewArr removeLastObject];
        }
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (firstCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
        if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
            [secondCollectionViewArr removeLastObject];
        }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
        if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
            [thirdCollectionViewArr removeLastObject];
        }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
        if ([[fourthCollectionViewArr lastObject] isEqualToString:@""]) {
            [fourthCollectionViewArr removeLastObject];
        }
    
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fourthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
        if ([[fifthCollectionViewArr lastObject] isEqualToString:@""]) {
            [fifthCollectionViewArr removeLastObject];
        }
    
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fifthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
        if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
            [sixthCollectionViewArr removeLastObject];
        }
    
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
}

- (void) setupUIForChildmindersForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Carer should have experience with";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[[_advertDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
    if ([[firstCollectionViewArr lastObject] isEqualToString:@""]) {
        [firstCollectionViewArr removeLastObject];
    }
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (firstCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[fourthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fourthCollectionViewArr removeLastObject];
    }
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fourthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    if ([[fifthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fifthCollectionViewArr removeLastObject];
    }
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fifthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    
}

- (void) setupUIForCrecheForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Carer should have experience with";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[[_advertDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
    if ([[firstCollectionViewArr lastObject] isEqualToString:@""]) {
        [firstCollectionViewArr removeLastObject];
    }
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (firstCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[fourthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fourthCollectionViewArr removeLastObject];
    }
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fourthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    if ([[fifthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fifthCollectionViewArr removeLastObject];
    }
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fifthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    
}

- (void) setupUIForNannyForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"I Like To Do : (select up to 3)";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Children minded in";
        _secondCollectionViewTitle.text = @"Carer should have experience with";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _fourthCollectionViewTitle.text = @"Additional Requirements: (optional)";
        _fifthCollectionViewTitle.text = @"Activities I would like my carer to provide";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[[_advertDict valueForKey:@"mind_loc"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
    if ([[firstCollectionViewArr lastObject] isEqualToString:@""]) {
        [firstCollectionViewArr removeLastObject];
    }
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (firstCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[fourthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fourthCollectionViewArr removeLastObject];
    }
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fourthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    if ([[fifthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fifthCollectionViewArr removeLastObject];
    }
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fifthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    
}

- (void) setupUIForCleanersForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _secondCollectionViewTitle.text = @"Cleaning Services You Can Provide";
        _thirdCollectionViewTitle.text = @"Do You Have Documentation";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _secondCollectionViewTitle.text = @"Cleaning Services required";
        _thirdCollectionViewTitle.text = @"Documentation Required";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _secondCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = (-80/568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
    
}

- (void) setupUIForDayWalkersForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _secondCollectionViewTitle.text = @"Pets You Have Experience With";
        _thirdCollectionViewTitle.text = @"You Can Provide";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _secondCollectionViewTitle.text = @"Type Of Pet Requiring Care";
        _thirdCollectionViewTitle.text = @"Carer should Provide";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _secondCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -(80./568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;


    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForElderlyCareForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _fourthCollectionViewTitle.text = @"Additional Services You Can Provide";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _secondCollectionViewTitle.text = @"Carer should have experience with";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _fourthCollectionViewTitle.text = @"Additional Services You Require";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _secondCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[fourthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fourthCollectionViewArr removeLastObject];
    }
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fourthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForHousekeepersForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _secondCollectionViewTitle.text = @"House Keeping Services You Can Provide";
        _thirdCollectionViewTitle.text = @"Do You Have Documentation";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _secondCollectionViewTitle.text = @"House Keeping Services required";
        _thirdCollectionViewTitle.text = @"Documentation Required";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _secondCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -(80./568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForMaternityNurseForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionViewSeparatorView.hidden = YES;
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -(40./568.)*kScreenHeight - _secondCollectionViewHeightConstraint.constant - _firstCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -(80./568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForPetMindersForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _secondCollectionViewTitle.text = @"Pets You Have Experience With";
        _thirdCollectionViewTitle.text = @"You Can Provide";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _secondCollectionViewTitle.text = @"Type Of Pet Requiring Care";
        _thirdCollectionViewTitle.text = @"Carer should Provide";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _secondCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -(80./568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForPrivateMidwifeForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _secondCollectionViewTitle.hidden = YES;
    _secondCollectionView.hidden = YES;
    _secondCollectionViewSeparatorView.hidden = YES;
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _thirdCollectionViewTitleTopConstraint.constant = -(40./568.)*kScreenHeight - _secondCollectionViewHeightConstraint.constant - _firstCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -(80./568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForSchoolRunForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _secondCollectionViewTitle.text = @"Provide Transport For";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _secondCollectionViewTitle.text = @"Require Transport For";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _secondCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -(80./568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForSpecialNeedsCareForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Do You Have Qualifications";
        _fourthCollectionViewTitle.text = @"I Have Experience With";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _secondCollectionViewTitle.text = @"Age Group Experience";
        _thirdCollectionViewTitle.text = @"Carer should have the following";
        _fourthCollectionViewTitle.text = @"Carer Should Have Experience With";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    _firstCollectionViewTitle.hidden = YES;
    _firstCollectionView.hidden = YES;
    _firstCollectionViewSeparatorView.hidden = YES;
    
    _secondCollectionViewTitleTopConstraint.constant = (-10/568.)*kScreenHeight - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    if ([[fourthCollectionViewArr lastObject] isEqualToString:@""]) {
        [fourthCollectionViewArr removeLastObject];
    }
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (fourthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = (-30/568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = (140./568.)*kScreenHeight;
    
}

- (void) setupUIForTutorForm {
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _firstCollectionViewTitle.text = @"Junior Cycle Subjects";
        _secondCollectionViewTitle.text = @"Senior Cycle Subjects";
        _thirdCollectionViewTitle.text = @"Do You Have Documentation";
        _sixthCollectionViewTitle.text = @"Other Services I Can Offer";
    }
    else {
        _firstCollectionViewTitle.text = @"Junior Cycle Subjects";
        _secondCollectionViewTitle.text = @"Senior Cycle Subjects";
        _thirdCollectionViewTitle.text = @"Tutor should have the following";
        _sixthCollectionViewTitle.text = @"Other Services I May Require";
    }
    
    firstCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[[_advertDict valueForKey:@"additional_optional"] stringByReplacingOccurrencesOfString:@"Their" withString:@"Parent"] componentsSeparatedByString:@","]];
    if ([[firstCollectionViewArr lastObject] isEqualToString:@""]) {
        [firstCollectionViewArr removeLastObject];
    }
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (firstCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    if ([[secondCollectionViewArr lastObject] isEqualToString:@""]) {
        [secondCollectionViewArr removeLastObject];
    }
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (secondCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    if ([[thirdCollectionViewArr lastObject] isEqualToString:@""]) {
        [thirdCollectionViewArr removeLastObject];
    }
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (thirdCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -(80./568.)*kScreenHeight - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    if ([[sixthCollectionViewArr lastObject] isEqualToString:@""]) {
        [sixthCollectionViewArr removeLastObject];
    }
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*(40./568.)*kScreenHeight + (sixthCollectionViewArr.count%2)*(40./568.)*kScreenHeight;
    
}

- (void) refreshUIForLikeDislikeCTAFOrString:(NSString *)responseStr {
    
    if ([responseStr containsString:@"Not"]) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            [_carerLikeButton setImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
        }
        else {
            [_doneButton setImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
        }
    }
    else {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            [_carerLikeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
        }
        else {
            [_doneButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
        }
    }
    
}


#pragma mark - API Helpers

- (void) startIncrementAdvertsViewService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = IncrementAdvertViews;
    manager.delegate = nil;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForIncrementAdvertsView]];
    
}

- (void) startLikeDislikeService {
    
    [SVProgressHUD showWithStatus:@"Updating status"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = LikeDislikeAdvert;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForLikeDislike]];
    
}

- (void) startCheckLikeDislikeService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = CheckLikedDisliked;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForLikeDislike]];
    
}

- (void) startGetAllReviewService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetAllReviews;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetAllReviews]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:LikeDislikeAdvert]) {
        
//        [SVProgressHUD showWithStatus:@"Checking status"];
        [SVProgressHUD showSuccessWithStatus:@"Status updated successfully"];
        [self startCheckLikeDislikeService];
        
    }
    if ([requestServiceKey isEqualToString:CheckLikedDisliked]) {
        
//        [SVProgressHUD showSuccessWithStatus:@"Status updated successfully"];
        
        [self refreshUIForLikeDislikeCTAFOrString:[responseData valueForKey:@"message"]];
        
    }
    if ([requestServiceKey isEqualToString:GetAllReviews]) {
        
        reviewArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
        _reviewTblViewHeightConstraint.constant = (reviewArr.count*308.);
        
        if (reviewArr.count == 0 && ![[SharedClass sharedInstance] isUserCarer]) {
            _noReviewsLabel.hidden = NO;
        }
        else {
            _noReviewsLabel.hidden = YES;
        }
        
        [_reviewTblView reloadData];
        
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

- (NSMutableDictionary *) prepareDictionaryForIncrementAdvertsView {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    if (_isOpenedFromFavorites) {
        [dict setObject:[_advertDict valueForKey:@"advert_id"] forKey:@"advertid"];
    }
    else {
        [dict setObject:[_advertDict valueForKey:@"ID"] forKey:@"advertid"];
    }
    
    [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"parentid"];
    [dict setObject:[_advertDict valueForKey:@"Userid"] forKey:@"carerid"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForLikeDislike {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"carerid"];
        [dict setObject:[_advertDict valueForKey:@"Userid"] forKey:@"parentid"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"parentid"];
        [dict setObject:[_advertDict valueForKey:@"Userid"] forKey:@"carerid"];
    }
    
    if (_isOpenedFromFavorites) {
        [dict setObject:[_advertDict valueForKey:@"advert_id"] forKey:@"advertid"];
    }
    else {
        [dict setObject:[_advertDict valueForKey:@"ID"] forKey:@"advertid"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForGetAllReviews {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if (_isOpenedFromFavorites) {
        [dict setObject:[_advertDict valueForKey:@"advert_id"] forKey:@"advertid"];
    }
    else {
        [dict setObject:[_advertDict valueForKey:@"ID"] forKey:@"advertid"];
    }
    
    return dict;
    
}


#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return reviewArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ReviewsTableViewCell";
    ReviewsTableViewCell *cell = (ReviewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ReviewsTableViewCell" owner:self options:nil];
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
    
    return 308.;
    
}


- (void) populateContentForAdsCell:(ReviewsTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",[[reviewArr objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[reviewArr objectAtIndex:indexPath.row] valueForKey:@"second_name"]];
    cell.reviewTitleLabel.text = [[reviewArr objectAtIndex:indexPath.row] valueForKey:@"review_title"];
    cell.reviewDescriptionTextView.text = [[reviewArr objectAtIndex:indexPath.row] valueForKey:@"review_text"];
    
    cell.nameLabel.font = _nameLabel.font;
    cell.reviewTitleLabel.font = _aboutStaticLabel.font;
    cell.reviewDescriptionTextView.font = _aboutTextView.font;
    
    switch ([[[reviewArr objectAtIndex:indexPath.row] valueForKey:@"stars"] intValue]) {
        case 0:
            [cell.firstStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.secondStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.thirdStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.fourthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.fifthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            break;
        case 1:
            [cell.firstStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.secondStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.thirdStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.fourthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.fifthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            break;
        case 2:
            [cell.firstStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.secondStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.thirdStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.fourthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.fifthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            break;
        case 3:
            [cell.firstStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.secondStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.thirdStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.fourthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            [cell.fifthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            break;
        case 4:
            [cell.firstStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.secondStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.thirdStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.fourthStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.fifthStarButton setImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
            break;
        case 5:
            [cell.firstStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.secondStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.thirdStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.fourthStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            [cell.fifthStarButton setImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
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

-(NSString *)getStringFromMillisecondsDate:(double)interval
{
    if (interval == 0)
    {
        return @"";
    }
    double seconds = interval;
    NSTimeInterval timeInterval = (NSTimeInterval)seconds;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* df_utc = [[NSDateFormatter alloc] init];
    [df_utc setTimeZone:[NSTimeZone localTimeZone]];
    [df_utc setDateStyle:NSDateFormatterMediumStyle];
    NSString *Date=[df_utc stringFromDate:date];
    return Date;
}


-(float)height :(NSString*)string
{
    /*
     NSString *stringToSize = [NSString stringWithFormat:@"%@", string];
     // CGSize constraint = CGSizeMake(LABEL_WIDTH - (LABEL_MARGIN *2), 2000.f);
     CGSize maxSize = CGSizeMake(280, MAXFLOAT);//set max height //set the constant width, hear MAXFLOAT gives the maximum height
     
     CGSize size = [stringToSize sizeWithFont:[UIFont systemFontOfSize:20.0f] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
     return size.height; //finally u get the correct height
     */
    //commenting the above code because "sizeWithFont: constrainedToSize:maxSize: lineBreakMode: " has been deprecated to avoid above code use below
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string
                                                                         attributes:@
                                          {
                                          NSFontAttributeName: [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight]
                                          }];
    
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){((kScreenWidth - 32)/2.)-31, MAXFLOAT}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];//you need to specify the some width, height will be calculated
    CGSize requiredSize = rect.size;
    return (requiredSize.height + 10); //finally u return your height
}

@end
