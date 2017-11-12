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

@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupInitialUI];
    [self setupAvailibilityArr];
    
}

- (void) setupInitialUI {
    
    _applyButton.layer.cornerRadius = 15.;
    _applyButton.layer.masksToBounds = NO;
    
    [self.availabilityCollectionView registerNib:[UINib nibWithNibName:@"ProfileAvailabilityCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileAvailabilityCollectionViewCell"];
    
}

- (void) setupAvailibilityArr {
    
    availabilityArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<40; i++) {
        [availabilityArr addObject:[NSNumber numberWithInt:0]];
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
    
    return 40.;
    
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
                
            default:
                break;
        }
        
    }
    else {
        cell.availabilityLabel.hidden = YES;
        cell.availabilityButton.hidden = NO;
    }
    
    cell.availabilityLabel.textColor = [UIColor blackColor];
    
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
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
    
    switch (indexPath.row) {
        case 0:
            cell.miscLabel.text = @"Childcare Qualifications";
            break;
        case 1:
            cell.miscLabel.text = @"Special Needs Experience";
            break;
        case 2:
            cell.miscLabel.text = @"First Aid";
            break;
        case 3:
            cell.miscLabel.text = @"Garda Vetting";
            break;
        case 4:
            cell.miscLabel.text = @"Visa";
            break;
        case 5:
            cell.miscLabel.text = @"EU Passport";
            break;
        case 6:
            cell.miscLabel.text = @"Reference";
            break;
        case 7:
            cell.miscLabel.text = @"Driving License";
            break;
        case 8:
            cell.miscLabel.text = @"Fetac Childcare Certification";
            break;
        case 9:
            cell.miscLabel.text = @"Has Own Transport";
            break;
        
            
        default:
            break;
    }
    
}

@end
