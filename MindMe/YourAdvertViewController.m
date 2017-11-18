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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonTapped:(id)sender {
}

#pragma mark - CollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _firstCollectionView) {
        return 2;
    }
    else if (collectionView == _secondCollectionView) {
        return 2;
    }
    else if (collectionView == _thirdCollectionView) {
        return 6;
    }
    else if (collectionView == _forthCollectionView) {
        return 11;
    }
    else if (collectionView == _fifthCollectionView) {
        return 6;
    }
    else if (collectionView == _sixthCollectionView) {
        return 6;
    }
    else if (collectionView == _seventhCollectionView) {
        return 14;
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
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"Yes";
            break;
            
        case 1:
            cell.titleLabel.text = @"No";
            break;
            
        default:
            break;
    }
    
    
}

- (void) populateContentForSecondCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"Parent Home";
            break;
            
        case 1:
            cell.titleLabel.text = @"Carers Home";
            break;
            
        default:
            break;
    }
    
    
}

- (void) populateContentForThirdCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"New Born";
            break;
            
        case 1:
            cell.titleLabel.text = @"0 - 6 Months";
            break;
            
        case 2:
            cell.titleLabel.text = @"6 Months - 2 Years";
            break;
            
        case 3:
            cell.titleLabel.text = @"2 Years - 5 years";
            break;
            
        case 4:
            cell.titleLabel.text = @"5 Years +";
            break;
            
        case 5:
            cell.titleLabel.text = @"Teenagers";
            break;
            
        default:
            break;
    }
    
    
}

- (void) populateContentForForthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"Childcare";
            break;
            
        case 1:
            cell.titleLabel.text = @"Special Needs";
            break;
            
        case 2:
            cell.titleLabel.text = @"First Aid";
            break;
            
        case 3:
            cell.titleLabel.text = @"Garda Vetting";
            break;
            
        case 4:
            cell.titleLabel.text = @"Work Visa";
            break;
            
        case 5:
            cell.titleLabel.text = @"EU passport";
            break;
            
        case 6:
            cell.titleLabel.text = @"References";
            break;
            
        case 7:
            cell.titleLabel.text = @"Drivin License";
            break;
            
        case 8:
            cell.titleLabel.text = @"Fetac childcare";
            break;
            
        case 9:
            cell.titleLabel.text = @"Fetac Special Needs";
            break;
            
        case 10:
            cell.titleLabel.text = @"Tusla Registration";
            break;
            
        default:
            break;
    }
    
    
}

- (void) populateContentForFifthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"Light Housekeeping";
            break;
            
        case 1:
            cell.titleLabel.text = @"Meal Preparation";
            break;
            
        case 2:
            cell.titleLabel.text = @"Laundry";
            break;
            
        case 3:
            cell.titleLabel.text = @"Errand/Shopping";
            break;
            
        case 4:
            cell.titleLabel.text = @"Homework Help";
            break;
            
        case 5:
            cell.titleLabel.text = @"Willing to drive children";
            break;
            
        default:
            break;
    }
    
    
}

- (void) populateContentForSixthCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"Sports";
            break;
            
        case 1:
            cell.titleLabel.text = @"Arts & Crafts";
            break;
            
        case 2:
            cell.titleLabel.text = @"Outdoor Activity";
            break;
            
        case 3:
            cell.titleLabel.text = @"Music & Drama";
            break;
            
        case 4:
            cell.titleLabel.text = @"Games";
            break;
            
        case 5:
            cell.titleLabel.text = @"Reading";
            break;
            
        default:
            break;
    }
    
    
}

- (void) populateContentForSeventhCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
        case 0:
            cell.titleLabel.text = @"AU Pairs";
            break;
            
        case 1:
            cell.titleLabel.text = @"Childminders";
            break;
            
        case 2:
            cell.titleLabel.text = @"Cleaners";
            break;
            
        case 3:
            cell.titleLabel.text = @"Creche";
            break;
            
        case 4:
            cell.titleLabel.text = @"Dog Walkers";
            break;
            
        case 5:
            cell.titleLabel.text = @"Elderly Care";
            break;
            
        case 6:
            cell.titleLabel.text = @"House Keepers";
            break;
            
        case 7:
            cell.titleLabel.text = @"Maternity Nurse";
            break;
            
        case 8:
            cell.titleLabel.text = @"Nanny";
            break;
            
        case 9:
            cell.titleLabel.text = @"Pet Minders";
            break;
            
        case 10:
            cell.titleLabel.text = @"Private Midwife";
            break;
            
        case 11:
            cell.titleLabel.text = @"School Run";
            break;
            
        case 12:
            cell.titleLabel.text = @"Special Needs Care";
            break;
            
        case 13:
            cell.titleLabel.text = @"Tutor";
            break;
            
        default:
            break;
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
