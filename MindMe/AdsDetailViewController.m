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
    [self startCheckLikeDislikeService];
    
}

- (void) setupInitialUI {
    
    _contactButton.layer.cornerRadius = 20.0;
    _contactButton.layer.masksToBounds = NO;
    
    _profileImgView.layer.cornerRadius = (50./375)*[UIScreen mainScreen].bounds.size.width;
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
        _footerContactButton.hidden = YES;
        [_doneButton setTitle:@"" forState:UIControlStateNormal];
        [_cancelButton setTitle:@"" forState:UIControlStateNormal];
        [_doneButton setBackgroundColor:[UIColor clearColor]];
        [_cancelButton setBackgroundColor:[UIColor clearColor]];
        [_doneButton setBackgroundImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"review_btn"] forState:UIControlStateNormal];
        _doneButtonHeightConstraint.constant = (([UIScreen mainScreen].bounds.size.width - 84)/2.) * (47./180.);
        [self startIncrementAdvertsViewService];
    }
    else {
        
        _footerContactButton.hidden = YES;
        _doneButton.hidden = YES;
        _cancelButton.hidden = YES;
        _carerLikeButton.hidden = NO;
        _doneButtonHeightConstraint.constant = (([UIScreen mainScreen].bounds.size.width - 84)/2.) * (47./180.);
        _yearsExperienceLabel.text = @"Years of Experience needed :";

    
    }
    
    
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
    _locationLabel.text = [_advertDict valueForKey:@"address1"];
    _careTypeLabel.text = [_advertDict valueForKey:@"care_type"];
    _experienceValueLabel.text = [NSString stringWithFormat:@"%@ years",[_advertDict valueForKey:@"experience"]];
    _aboutTextView.text = [_advertDict valueForKey:@"about_you"];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _jobActiveViewsLabel.hidden = YES;
    }
    else {
        _jobActiveViewsLabel.hidden = NO;
        _jobActiveViewsLabel.text = [NSString stringWithFormat:@"Job Active %@ views",[_advertDict valueForKey:@"viewed"]];
    }
    
    _rateLabel.text = [_advertDict valueForKey:@"pay"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter* dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateStyle:NSDateFormatterMediumStyle];
    
    _lastLoginLabel.text = [dateFormatter1 stringFromDate:[dateFormatter dateFromString:[_advertDict valueForKey:@"posted"]]];
    _memberSinceLabel.text = [dateFormatter1 stringFromDate:[dateFormatter dateFromString:[_advertDict valueForKey:@"date"]]];
    
    if ([[_advertDict valueForKey:@"additionals"] containsString:_haveACaerLabel.text]) {
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
    
    if ([[_advertDict valueForKey:@"additionals"] containsString:_acceptOnlinePaymentLabel.text]) {
        _acceptOnlinePaymentImgView.image = [UIImage imageNamed:@"ic_green_correct"];
    }
    else {
        _acceptOnlinePaymentImgView.image = [UIImage imageNamed:@"ic_cross"];
    }
    
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
    
    
}

- (void) populateContentForSecondCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [secondCollectionViewArr objectAtIndex:indexPath.row];
    
    
}

- (void) populateContentForThirdCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [thirdCollectionViewArr objectAtIndex:indexPath.row];
    
}

- (void) populateContentForForthCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [fourthCollectionViewArr objectAtIndex:indexPath.row];
    
}

- (void) populateContentForFifthCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [fifthCollectionViewArr objectAtIndex:indexPath.row];
    
}

- (void) populateContentForSixthCollectionViewCell:(AdsDetailCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.detailsTextLabel.text = [sixthCollectionViewArr objectAtIndex:indexPath.row];
    
    
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
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
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
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*30 + (firstCollectionViewArr.count%2)*30;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*30 + (fourthCollectionViewArr.count%2)*30;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*30 + (fifthCollectionViewArr.count%2)*30;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
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
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*30 + (firstCollectionViewArr.count%2)*30;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*30 + (fourthCollectionViewArr.count%2)*30;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*30 + (fifthCollectionViewArr.count%2)*30;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
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
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*30 + (firstCollectionViewArr.count%2)*30;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*30 + (fourthCollectionViewArr.count%2)*30;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*30 + (fifthCollectionViewArr.count%2)*30;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    
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
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*30 + (firstCollectionViewArr.count%2)*30;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*30 + (fourthCollectionViewArr.count%2)*30;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*30 + (fifthCollectionViewArr.count%2)*30;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    
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
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*30 + (firstCollectionViewArr.count%2)*30;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*30 + (fourthCollectionViewArr.count%2)*30;
    
    fifthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    _fifthCollectionViewHeightConstraint.constant = (fifthCollectionViewArr.count/2)*30 + (fifthCollectionViewArr.count%2)*30;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    
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
    
    _secondCollectionViewTitleTopConstraint.constant = -44 - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
    
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
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;


    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    
    _secondCollectionViewTitleTopConstraint.constant = -44 - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*30 + (fourthCollectionViewArr.count%2)*30;
    
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -44 - _fifthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    
    _secondCollectionViewTitleTopConstraint.constant = -44 - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    
    _thirdCollectionViewTitleTopConstraint.constant = -108 - _secondCollectionViewHeightConstraint.constant - _firstCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    
    _secondCollectionViewTitleTopConstraint.constant = -44 - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    
    _thirdCollectionViewTitleTopConstraint.constant = -100 - _secondCollectionViewHeightConstraint.constant - _firstCollectionViewHeightConstraint.constant;
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -100 - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    
    _secondCollectionViewTitleTopConstraint.constant = -44 - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    
    _secondCollectionViewTitleTopConstraint.constant = -44 - _firstCollectionViewHeightConstraint.constant;
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"age_group"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    fourthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"additional_optional"] componentsSeparatedByString:@","]];
    _fourthCollectionViewHeightConstraint.constant = (fourthCollectionViewArr.count/2)*30 + (fourthCollectionViewArr.count%2)*30;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -44 - _fifthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
    _otherRelevantInfoStaticLabel.hidden = NO;
    _otherRelevantInfoTextView.hidden = NO;
    _otherRelevantInfoTextView.text = [_advertDict valueForKey:@"love_optional"];
    _daysRequiredLabelTopConstraint.constant = 108;
    
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
    _firstCollectionViewHeightConstraint.constant = (firstCollectionViewArr.count/2)*30 + (firstCollectionViewArr.count%2)*30;
    
    secondCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"love_optional"] componentsSeparatedByString:@","]];
    _secondCollectionViewHeightConstraint.constant = (secondCollectionViewArr.count/2)*30 + (secondCollectionViewArr.count%2)*30;
    
    thirdCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"require"] componentsSeparatedByString:@","]];
    _thirdCollectionViewHeightConstraint.constant = (thirdCollectionViewArr.count/2)*30 + (thirdCollectionViewArr.count%2)*30;
    
    _fourthCollectionViewTitle.hidden = YES;
    _fourthCollectionView.hidden = YES;
    _fourthCollectionViewSeparatorView.hidden = YES;
    
    _fifthCollectionViewTitle.hidden = YES;
    _fifthCollectionView.hidden = YES;
    _fifthCollectionViewSeparatorView.hidden = YES;
    
    _sixthCollectionViewTitleTopConstraint.constant = -108 - _fifthCollectionViewHeightConstraint.constant - _fourthCollectionViewHeightConstraint.constant;
    sixthCollectionViewArr = [[NSMutableArray alloc] initWithArray:[[_advertDict valueForKey:@"services"] componentsSeparatedByString:@","]];
    _sixthCollectionViewHeightConstraint.constant = (sixthCollectionViewArr.count/2)*30 + (sixthCollectionViewArr.count%2)*30;
    
}

- (void) refreshUIForLikeDislikeCTAFOrString:(NSString *)responseStr {
    
    if ([responseStr containsString:@"Not"]) {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            [_carerLikeButton setImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
        }
        else {
            [_doneButton setBackgroundImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
        }
    }
    else {
        if ([[SharedClass sharedInstance] isUserCarer]) {
            [_carerLikeButton setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
        }
        else {
            [_doneButton setBackgroundImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
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

@end
