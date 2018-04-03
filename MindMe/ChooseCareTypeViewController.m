//
//  ChooseCareTypeViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "ChooseCareTypeViewController.h"
#import "ChooseCareTypeCollectionViewCell.h"
#import "YourInformationViewController.h"

@interface ChooseCareTypeViewController ()

@end

@implementation ChooseCareTypeViewController

@synthesize userAdvertsArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupDataSource];
    
}

- (void) setupInitialUI {
    
    _nextButton.layer.cornerRadius = 17.5;
    _nextButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 17.5;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    [self.firstCollectionView registerNib:[UINib nibWithNibName:@"ChooseCareTypeCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ChooseCareTypeCollectionViewCell"];
    [self.secondCollectionView registerNib:[UINib nibWithNibName:@"ChooseCareTypeCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ChooseCareTypeCollectionViewCell"];
    
    if (![[SharedClass sharedInstance] isUserCarer]) {
        
        _editSectionHeaderLabel.text = @"Edit your existing Advert";
        
    }
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    
    _editSectionHeaderLabel.font = _nSectionHeaderLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
    _nextButton.titleLabel.font = _cancelButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(17.5/667)*kScreenHeight];
    
}

- (void) setupDataSource {
    
    allAdvertsArr = [[NSMutableArray alloc] initWithObjects:@"Au Pair", @"Babysitters", @"Elderly Care", @"Childminders", @"Cleaners", @"Creche", @"Dog Walkers", @"House Keepers", @"Maternity Nurse", @"Nanny", @"Pet Minders", @"Private Midwife", @"School Run", @"Special Needs Care", @"Tutor", nil];
    existingAdvertsArr = [[NSMutableArray alloc] init];
    newAdvertsArr = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in userAdvertsArr) {
        [existingAdvertsArr addObject:[dict valueForKey:@"care_type"]];
    }
    
    for (NSString* str in allAdvertsArr) {
        
        if (![existingAdvertsArr containsObject:str]) {
            [newAdvertsArr addObject:str];
        }
        
    }
    
    _firstCollectionViewHeightConstraint.constant = (((40./667)*kScreenHeight) * (existingAdvertsArr.count%2)) + (((40./667)*kScreenHeight) * (existingAdvertsArr.count/2));
    _secondCollectionViewHeightConstraint.constant = (((40./667)*kScreenHeight) * (newAdvertsArr.count%2)) + (((40./667)*kScreenHeight) * (newAdvertsArr.count/2));
    
    if (existingAdvertsArr.count<=0) {
        _editSectionHeaderLabel.hidden = YES;
    }
    else {
        _editSectionHeaderLabel.hidden = NO;
    }
                                                                                           
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _firstCollectionView) {
        return existingAdvertsArr.count;
    }
    return newAdvertsArr.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ChooseCareTypeCollectionViewCell";
    ChooseCareTypeCollectionViewCell *cell = (ChooseCareTypeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ChooseCareTypeCollectionViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    if (collectionView == _firstCollectionView) {
        [self populateContentForFirstCollectionViewCell:cell atIndexPath:indexPath];
    }
    else {
        [self populateContentForSecondCollectionViewCell:cell atIndexPath:indexPath];
    }
    
    
    return cell;
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width)/2., (40./667)*kScreenHeight);
    
    
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
    
    if (collectionView == _firstCollectionView) {
        selectedCareType = [existingAdvertsArr objectAtIndex:indexPath.row];
        [_firstCollectionView reloadData];
        [_secondCollectionView reloadData];
    }
    else if (collectionView == _secondCollectionView) {
        selectedCareType = [newAdvertsArr objectAtIndex:indexPath.row];
        [_firstCollectionView reloadData];
        [_secondCollectionView reloadData];
    }
    
    
}


#pragma mark - Populate Content

- (void) populateContentForFirstCollectionViewCell:(ChooseCareTypeCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [existingAdvertsArr objectAtIndex:indexPath.row];
    
    if ([[existingAdvertsArr objectAtIndex:indexPath.row] isEqualToString:selectedCareType]) {
        cell.toggleButton.selected = YES;
    }
    else {
        cell.toggleButton.selected = NO;
    }
    
}

- (void) populateContentForSecondCollectionViewCell:(ChooseCareTypeCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [newAdvertsArr objectAtIndex:indexPath.row];
    
    if ([[newAdvertsArr objectAtIndex:indexPath.row] isEqualToString:selectedCareType]) {
        cell.toggleButton.selected = YES;
    }
    else {
        cell.toggleButton.selected = NO;
    }
    
}


#pragma mark - Navigation

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"showYourInfoSegue"]) {
        
        if (!selectedCareType) {
            [SVProgressHUD showErrorWithStatus:@"Select at least one care type to proceed"];
            return NO;
        }
        
    }
    
    return YES;
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showYourInfoSegue"]) {
        
        YourInformationViewController* controller = (YourInformationViewController*)[segue destinationViewController];
        controller.selectedCareType = selectedCareType;
        
        if ([existingAdvertsArr containsObject:selectedCareType]) {
            controller.advertDictToBeEdited = [userAdvertsArr objectAtIndex:[existingAdvertsArr indexOfObject:selectedCareType]];
        }
        else {
            controller.advertDictToBeEdited = nil;
        }
        
        
    }
    
}


- (IBAction)backButtonTapped:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
