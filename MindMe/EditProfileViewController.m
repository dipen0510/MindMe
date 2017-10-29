//
//  EditProfileViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 22/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ProfileActivitiesCollectionViewCell.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _doneButton.layer.cornerRadius = 22.5;
    _doneButton.layer.masksToBounds = NO;
    
    _cancelButton.layer.cornerRadius = 22.5;
    _cancelButton.layer.masksToBounds = NO;
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = _cancelButton.titleLabel.textColor.CGColor;
    
    [self.activitiesCollectionView registerNib:[UINib nibWithNibName:@"ProfileActivitiesCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileActivitiesCollectionViewCell"];
    [self.servicesCollectionView registerNib:[UINib nibWithNibName:@"ProfileActivitiesCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ProfileActivitiesCollectionViewCell"];
    
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

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}

#pragma mark - CollectionView Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    return CGSizeMake(100.,44.);
    
}

#pragma mark - CollectionView Delegates

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


#pragma mark - Populate Content

- (void) populateContentForCell:(ProfileActivitiesCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
