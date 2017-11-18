//
//  YourInformationViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 18/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "YourInformationViewController.h"
#import "ProfileActivitiesCollectionViewCell.h"
#import "CreateAdvertsCollectionViewCell.h"
#import "SelectLanguageViewController.h"

@interface YourInformationViewController () {
    
    SelectLanguageViewController* selectLanguageController;
    
}

@end

@implementation YourInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.height/2.;
    _profileImgView.layer.masksToBounds = YES;
    
    _nextButton.layer.cornerRadius = 17.5;
    _nextButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 17.5;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    [self.languagesCollectionView registerNib:[UINib nibWithNibName:@"ProfileActivitiesCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileActivitiesCollectionViewCell"];
    [self.miscCollectionView registerNib:[UINib nibWithNibName:@"CreateAdvertsCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"CreateAdvertsCollectionViewCell"];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [_contentScrollView addGestureRecognizer:tapGesture];
    
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

- (IBAction)requiredOccassionalyButtonTapped:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)requiredRegulartlyButtonTapped:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addLanguagesButtonTapped:(id)sender {
    
    selectLanguageController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectLanguageViewController"];
    selectLanguageController.view.frame = self.view.bounds;
    [self.view addSubview:selectLanguageController.view];
    
}


#pragma mark - CollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _miscCollectionView) {
        return 4;
    }
    return 2.;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_miscCollectionView == collectionView) {
        static NSString *CellIdentifier = @"CreateAdvertsCollectionViewCell";
        CreateAdvertsCollectionViewCell *cell = (CreateAdvertsCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CreateAdvertsCollectionViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        [self populateContentForMiscCollectionViewCell:cell atIndexPath:indexPath];
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"ProfileActivitiesCollectionViewCell";
    ProfileActivitiesCollectionViewCell *cell = (ProfileActivitiesCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProfileActivitiesCollectionViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForCell:cell atIndexPath:indexPath];
    
    return cell;
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _miscCollectionView) {
        return CGSizeMake((collectionView.frame.size.width)/2., 30);
    }
    
    return CGSizeMake(100.,44.);
    
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
    
    
}


#pragma mark - Populate Content

- (void) populateContentForMiscCollectionViewCell:(CreateAdvertsCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.leadingConstraint.constant = 20;
            cell.trailingConstraint.constant = 0;
            cell.titleLabel.text = @"Accept online payments";
            break;
            
        case 1:
            cell.titleLabel.text = @"Non-smoker";
            cell.leadingConstraint.constant = 8;
            cell.trailingConstraint.constant = 16;
            break;
            
        case 2:
            cell.leadingConstraint.constant = 20;
            cell.trailingConstraint.constant = 0;
            cell.titleLabel.text = @"Have a car";
            break;
            
        case 3:
            cell.leadingConstraint.constant = 8;
            cell.trailingConstraint.constant = 16;
            cell.titleLabel.text = @"Comfortable with pets";
            break;
            
        default:
            break;
    }
    
    
}

- (void) populateContentForCell:(ProfileActivitiesCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            cell.activityLabel.text = @"English";
            break;
            
        case 1:
            cell.activityLabel.text = @"German";
            break;
            
        default:
            break;
    }

    
}

- (void) dismissKeyboard {
    
    [self.view endEditing:YES];
    
}
@end
