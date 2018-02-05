//
//  FavoritesViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesTableViewCell.h"
#import "AdsDetailViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _headerLabel.text = @"LIKED ADVERTS";
    }
    
    [self startGetFavoritesService];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showAdsDetailSegue"]) {
        
        AdsDetailViewController* controller = (AdsDetailViewController *)[segue destinationViewController];
        controller.advertDict = selectedAdvertDict;
        
    }
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return favoritesArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FavoritesTableViewCell";
    FavoritesTableViewCell *cell = (FavoritesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FavoritesTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedAdvertDict = [[NSMutableDictionary alloc] initWithDictionary:[favoritesArr objectAtIndex:indexPath.row]];
    [self performSegueWithIdentifier:@"showAdsDetailSegue" sender:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200;
    
}


- (void) populateContentForAdsCell:(FavoritesTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.drivingLicenseImgView.hidden = YES;
    cell.euImgView.hidden = YES;
    cell.lastLoginLabel.hidden = YES;
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        cell.yearsExperienceStaticLabel.text = @"Years of Experience needed :";
        cell.featuredImgView.hidden = YES;
        cell.featuredLabel.hidden = YES;
    }
    else {
        cell.yearsExperienceStaticLabel.text = @"Years of Experience ";
        
        if ([[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"Sub_active"] && [[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"Sub_active"] intValue] == 1) {
            cell.featuredImgView.hidden = NO;
            cell.featuredLabel.hidden = NO;
        }
        else {
            cell.featuredImgView.hidden = YES;
            cell.featuredLabel.hidden = YES;
        }
        
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@.",[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"second_name"] substringToIndex:1]];
    cell.locationLabel.text = [[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"address1"];
    cell.careTypeLabel.text = [[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"care_type"];
    cell.experienceValueLabel.text = [NSString stringWithFormat:@"%@ years",[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"experience"]];
    cell.descLabel.text = [[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"about_you"];
    
    if (![[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"image_path"] isEqualToString:@""]) {
        __weak UIImageView* weakImageView = cell.profileImgView;
        [cell.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceURL,[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"image_path"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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
        cell.profileImgView.image = [UIImage imageNamed:@"profile_icon"];
    }

    
}

#pragma mark - API Helpers

- (void) startGetFavoritesService {
    
    [SVProgressHUD showWithStatus:@"Fetching Favorites"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetFavoriteAdverts;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetFavoritesService]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetFavoriteAdverts]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Favorites fetched successfully"];
        
        if ([[responseData valueForKey:@"message"] isKindOfClass:[NSArray class]]) {
            favoritesArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
        }
        
        [_favoritesTblView reloadData];
        
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

- (NSMutableDictionary *) prepareDictionaryForGetFavoritesService {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

@end
