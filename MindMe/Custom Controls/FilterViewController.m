//
//  FilterViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 10/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FilterViewController.h"
#import "ProfileAvailabilityCollectionViewCell.h"
#import "FilterMiscTableViewCell.h"
#import "ActionSheetPicker.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

@synthesize availabilityArr,isRefineSearchEnabled,caretypeArr,servicesArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupInitialUI];
    [self setupAvailibilityArr];
    [self setupServicesArr];
    
}

- (void) setupInitialUI {
    
    _applyButton.layer.cornerRadius = 15.;
    _applyButton.layer.masksToBounds = NO;
    
    _primaryApplyButton.layer.cornerRadius = 15.;
    _primaryApplyButton.layer.masksToBounds = NO;
    _primaryApplyButton.hidden = YES;
    
//    NSNumberFormatter* numberFormat = [[NSNumberFormatter alloc] init];
//    numberFormat.numberStyle = NSNumberFormatterDecimalStyle;
//    numberFormat.maximumFractionDigits = 0;
//    numberFormat.generatesDecimalNumbers = NO;
//    
//    _experienceSlider.numberFormatterOverride = numberFormat;
//    _ageSlider.numberFormatterOverride = numberFormat;
                                       
    [self.availabilityCollectionView registerNib:[UINib nibWithNibName:@"ProfileAvailabilityCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileAvailabilityCollectionViewCell"];
    
    caretypeArr = [NSArray arrayWithObjects:@"Childcare Qualifications", @"Special Needs Experience", @"First Aid", @"Garda Vetting", @"Visa", @"Eu Passport", @"Reference", @"Driving Licence", @"Fetac Childcare Certification", @"Has Own Transport", nil];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _experienceStaticLabelTopConstraint.constant = -95;
        _carerAgeStaticLabel.hidden = YES;
        _ageSlider.hidden = YES;
    }
    
    _selectCareTypeStaticLabel.font = _distanceStaticLabel.font = _carerAgeStaticLabel.font = _availabilityStaticLabel.font = _yearsOfExStaticLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(15./667)*kScreenHeight];
    
    _careTypeTextField.font = _distanceTextField.font = [UIFont fontWithName:@"Montserrat-Light" size:(14./667)*kScreenHeight];
    
    _applyButton.titleLabel.font = _primaryApplyButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(15./667)*kScreenHeight];
    
    _filterLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(17./667)*kScreenHeight];
    
}

- (void) setupAvailibilityArr {
    
    availabilityArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<48; i++) {
        [availabilityArr addObject:[NSNumber numberWithInt:0]];
    }
    
}

- (void) setupServicesArr {
    
    servicesArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<caretypeArr.count; i++) {
        [servicesArr addObject:[NSNumber numberWithInt:0]];
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
    
    return CGSizeMake((((310./375.)*([UIScreen mainScreen].bounds.size.width - 40)) - 75.)/7.,collectionView.frame.size.height/6.);
    
    
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
        
//        int currentStatus = [[availabilityArr objectAtIndex:indexPath.row] intValue];
//        [availabilityArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:!currentStatus]];
//        [collectionView reloadData];
        
    }
    
    
}

- (void) didTapOnAvailabilityCell:(UITapGestureRecognizer *)gesture {
    
    long index = gesture.view.tag;
    
    if (index%8 != 0 && index>=8) {
        
        int currentStatus = [[availabilityArr objectAtIndex:index] intValue];
        [availabilityArr replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:!currentStatus]];
        [_availabilityCollectionView reloadData];
        
    }
    
}

- (void) didTapOnServicesCell:(UITapGestureRecognizer *)gesture {
    
    long index = gesture.view.tag;
  
        int currentStatus = [[servicesArr objectAtIndex:index] intValue];
        [servicesArr replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:!currentStatus]];
        [_miscTblView reloadData];

    
}

#pragma mark - Populate Content

- (void) populateContentForAvailabilityCell:(ProfileAvailabilityCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row%8 == 0 || indexPath.row<8) {
        
        cell.availabilityLabel.hidden = NO;
        cell.availabilityLabel.textAlignment = NSTextAlignmentCenter;
        cell.availabilityButton.hidden = YES;
        
        switch (indexPath.row) {
            case 0:
                cell.availabilityLabel.text = @"";
                break;
            case 1:
                cell.availabilityLabel.text = @"Mo";
                break;
            case 2:
                cell.availabilityLabel.text = @"Tu";
                break;
            case 3:
                cell.availabilityLabel.text = @"We";
                break;
            case 4:
                cell.availabilityLabel.text = @"Th";
                break;
            case 5:
                cell.availabilityLabel.text = @"Fr";
                break;
            case 6:
                cell.availabilityLabel.text = @"Sa";
                break;
            case 7:
                cell.availabilityLabel.text = @"Su";
                break;
            case 8:
                cell.availabilityLabel.textAlignment = NSTextAlignmentLeft;
                cell.availabilityLabel.text = @"Morning";
                break;
            case 16:
                cell.availabilityLabel.textAlignment = NSTextAlignmentLeft;
                cell.availabilityLabel.text = @"Afternoon";
                break;
            case 24:
                cell.availabilityLabel.textAlignment = NSTextAlignmentLeft;
                cell.availabilityLabel.text = @"Evening";
                break;
            case 32:
                cell.availabilityLabel.textAlignment = NSTextAlignmentLeft;
                cell.availabilityLabel.text = @"Night";
                break;
            case 40:
                cell.availabilityLabel.textAlignment = NSTextAlignmentLeft;
                cell.availabilityLabel.text = @"Overnight";
                break;
                
            default:
                break;
        }
        
    }
    else {
        cell.availabilityLabel.hidden = YES;
        cell.availabilityButton.hidden = NO;
        if ([[availabilityArr objectAtIndex:indexPath.row] intValue]) {
            cell.availabilityButton.selected = YES;
        }
        else {
            cell.availabilityButton.selected = NO;
        }
    }
    
    cell.availabilityLabel.textColor = [UIColor blackColor];
    
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnAvailabilityCell:)]];
    
    cell.availabilityButton.userInteractionEnabled = NO;
    
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return caretypeArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FilterMiscTableViewCell";
    FilterMiscTableViewCell *cell = (FilterMiscTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FilterMiscTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForSettingsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 25.;
    
}


- (void) populateContentForSettingsCell:(FilterMiscTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.miscLabel.text = [caretypeArr objectAtIndex:indexPath.row];
    
    if ([[servicesArr objectAtIndex:indexPath.row] intValue]) {
        cell.miscButton.selected = YES;
    }
    else {
        cell.miscButton.selected = NO;
    }
    
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnServicesCell:)]];
    
    cell.miscButton.userInteractionEnabled = NO;
    cell.miscLabel.userInteractionEnabled = NO;
    
}

- (IBAction)refineSearchButtonTapped:(id)sender {
    
    if (isRefineSearchEnabled) {
        
        _contentScrollView.contentSize = CGSizeMake(_contentScrollView.contentSize.width, _contentScrollView.contentSize.height + 510);
        _primaryApplyButton.hidden = YES;
        _availabilityStaticLabel.hidden = NO;
        _availabilitySeparatorView.hidden = NO;
        _availabilityCollectionView.hidden = NO;
        [_refineSearchButton setBackgroundImage:[UIImage imageNamed:@"refine_your_search2_btn"] forState:UIControlStateNormal];
        
    }
    else {
        
        _contentScrollView.contentSize = CGSizeMake(_contentScrollView.contentSize.width, _contentScrollView.contentSize.height - 510);
        _primaryApplyButton.hidden = NO;
        _availabilityStaticLabel.hidden = YES;
        _availabilitySeparatorView.hidden = YES;
        _availabilityCollectionView.hidden = YES;
        [_refineSearchButton setBackgroundImage:[UIImage imageNamed:@"refine_your_search_btn"] forState:UIControlStateNormal];
        
    }
    
    isRefineSearchEnabled = !isRefineSearchEnabled;
    
}


@end
