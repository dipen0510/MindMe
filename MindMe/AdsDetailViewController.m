//
//  AdsDetailViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 09/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AdsDetailViewController.h"
#import "ProfileAvailabilityCollectionViewCell.h"

@interface AdsDetailViewController ()

@end

@implementation AdsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupAvailibilityArr];
    [self setupValueLayoutForAdvert];
    
}

- (void) setupInitialUI {
    
    _contactButton.layer.cornerRadius = 20.0;
    _contactButton.layer.masksToBounds = NO;
    
    _profileImgView.layer.cornerRadius = (50./375)*[UIScreen mainScreen].bounds.size.width;
    _profileImgView.layer.masksToBounds = YES;
    
    _locationPinLeadingConstraint.constant = (130./375.) * [UIScreen mainScreen].bounds.size.width;
    _yearsOfExpLeadingConstraint.constant = (130./375.) * [UIScreen mainScreen].bounds.size.width;
    
    [self.daysRequiredCollectionView registerNib:[UINib nibWithNibName:@"ProfileAvailabilityCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileAvailabilityCollectionViewCell"];
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        _footerContactButton.hidden = YES;
        [_doneButton setTitle:@"" forState:UIControlStateNormal];
        [_cancelButton setTitle:@"" forState:UIControlStateNormal];
        [_doneButton setBackgroundColor:[UIColor clearColor]];
        [_cancelButton setBackgroundColor:[UIColor clearColor]];
        [_doneButton setBackgroundImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"review_btn"] forState:UIControlStateNormal];
        _doneButtonHeightConstraint.constant = (([UIScreen mainScreen].bounds.size.width - 84)/2.) * (47./180.);
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

- (IBAction)doneButtonTapped:(id)sender {
    
    if ([[SharedClass sharedInstance] isGuestUser]) {
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self performSegueWithIdentifier:@"showLikedSegue" sender:nil];
    
}

#pragma mark - CollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 48.;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
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


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row%8 == 0) {
        return CGSizeMake(75.,collectionView.frame.size.height/6.);
    }
        
    return CGSizeMake((((345./375.)*[UIScreen mainScreen].bounds.size.width) - 75.)/7.,collectionView.frame.size.height/6.);

    
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

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"showContactSegue"] && [[SharedClass sharedInstance] isGuestUser]) {
        
        [self.sideMenuController.navigationController popViewControllerAnimated:YES];
        return NO;
        
    }
    
    return YES;
    
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

@end
