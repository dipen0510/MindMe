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
//        _doneButton.layer.cornerRadius = 22.5;
//        _doneButton.layer.masksToBounds = NO;
//        
//        _footerContactButton.layer.cornerRadius = 22.5;
//        _footerContactButton.layer.masksToBounds = NO;
//        
//        _cancelButton.layer.cornerRadius = 22.5;
//        _cancelButton.layer.masksToBounds = NO;
//        _cancelButton.layer.borderWidth = 1.0;
//        _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
        
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
    
    for (int i = 0; i<48; i++) {
        [availabilityArr addObject:[NSNumber numberWithInt:0]];
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
    
    
        if (indexPath.row%8 != 0 && indexPath.row>=8) {
            
            int currentStatus = [[availabilityArr objectAtIndex:indexPath.row] intValue];
            [availabilityArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:!currentStatus]];
            [collectionView reloadData];
            
        }

    
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

@end
