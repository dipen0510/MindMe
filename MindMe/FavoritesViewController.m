//
//  FavoritesViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 15/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FavoritesViewController.h"
#import "AdsHomeTableViewCell.h"
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
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    
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
    
    if ([segue.identifier isEqualToString:@"showAdsDetailSegue"] || [segue.identifier isEqualToString:@"showParentAdsDetailSegue"]) {
        
        AdsDetailViewController* controller = (AdsDetailViewController *)[segue destinationViewController];
        controller.advertDict = selectedAdvertDict;
        controller.isOpenedFromFavorites = YES;
        
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
    
    static NSString *CellIdentifier = @"AdsHomeTableViewCell";
    AdsHomeTableViewCell *cell = (AdsHomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AdsHomeTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedAdvertDict = [[NSMutableDictionary alloc] initWithDictionary:[favoritesArr objectAtIndex:indexPath.row]];
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [self performSegueWithIdentifier:@"showAdsDetailSegue" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"showParentAdsDetailSegue" sender:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self height:[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"address1"]] > 23) {
        return (260./568)*kScreenHeight;
    }
    else {
        return (230./568)*kScreenHeight;
    }
    
}


- (void) populateContentForAdsCell:(AdsHomeTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.profileImgView.layer.cornerRadius = (36.5/568.)*kScreenHeight;
    cell.profileImgView.layer.masksToBounds = YES;
    
    if ([[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"first_name"] isEqual:[NSNull null]] && [[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"second_name"] isEqual:[NSNull null]]) {
        cell.nameLabel.text = @".";
    }
    else {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@.",[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"second_name"] substringToIndex:1]];
    }
    
    
    cell.locationLabel.text = [NSString stringWithFormat:@"%d km Away",[[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"distance"] intValue]];
    cell.addressLabel.text = [[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"address1"];
    
    if ([self height:cell.addressLabel.text] <= 23) {
        cell.profileImgView.layer.cornerRadius = (30.75/568.)*kScreenHeight;
    }
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        cell.careTypeLabel.text = [NSString stringWithFormat:@"%@ Required",[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"care_type"]];
        cell.ageLabel.hidden = YES;
        cell.ageImgView.hidden = YES;
        cell.ageImgViewTopConstraint.constant = -13.5;
        cell.descTopConstraint.constant = -12;
    }
    else {
        cell.careTypeLabel.text = [[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"care_type"];
        cell.ageLabel.text = [NSString stringWithFormat:@"%ld Years Old",[self ageFromYear:[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"birth_year"] Month:[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"birth_month"] day:[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"birth_day"]]];
        cell.ageLabel.hidden = NO;
        cell.ageImgView.hidden = NO;
        cell.ageImgViewTopConstraint.constant = 12.;
    }
    
    if (![[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"about_you"] isEqual:[NSNull null]]) {
        cell.descLabel.text = [[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"about_you"];
    }
    else {
        cell.descLabel.text = @"";
    }
    
    cell.experienceValueLabel.text = [NSString stringWithFormat:@"%@ Years of Experience",[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"experience"]];
    
    
    if ([[SharedClass sharedInstance] isFeaturedFilterApplied] || [[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"Sub_active"] intValue] == 1 || [[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"featured_advert"] intValue] == 1) {
        cell.featuredLabel.hidden = NO;
        cell.featuredImgView.hidden = NO;
        cell.gradientView.hidden = NO;
        [self addFeaturedGradientToView:cell.gradientView];
        if ([[SharedClass sharedInstance] isUserCarer]) {
            cell.descTopConstraint.constant = 0;
        }
    }
    else {
        cell.featuredLabel.hidden = YES;
        cell.featuredImgView.hidden = YES;
        cell.gradientView.hidden = YES;
    }
    
    if (![[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"image_path"] isEqualToString:@""]) {
        __weak UIImageView* weakImageView = cell.profileImgView;
        [cell.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",WebServiceImageURL,[[favoritesArr objectAtIndex:indexPath.row] valueForKey:@"image_path"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    
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
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetails"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    [dict setObject:[responseData valueForKey:@"latitude"] forKey:@"lat"];
    [dict setObject:[responseData valueForKey:@"longitude"] forKey:@"long"];
    [dict setObject:[responseData valueForKey:@"address1"] forKey:@"address"];
    
    return dict;
    
}

- (NSInteger)ageFromYear:(NSString *)year Month:(NSString *)month day:(NSString *)day {
    
    NSString* dobStr = [NSString stringWithFormat:@"%@/%@/%@",day,month,year];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSDate* userDoB = [dateFormatter dateFromString:dobStr];
    
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:userDoB
                                       toDate:today
                                       options:0];
    return ageComponents.year;
}

- (void) addFeaturedGradientToView:(UIView *)view {
    
    CAGradientLayer* gradient = [CAGradientLayer new];
    gradient.colors = @[(id)[UIColor colorWithRed:0.9765 green:0.8745 blue:0.7451 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.9882 green:0.9373 blue:0.8706 alpha:1.0].CGColor, (id)[UIColor whiteColor].CGColor];
    gradient.frame = view.bounds;
    gradient.locations = @[@0.0, @0.6, @1.0];
    [view.layer insertSublayer:gradient atIndex:0];
    
}

-(float)height :(NSString*)string
{
    /*
     NSString *stringToSize = [NSString stringWithFormat:@"%@", string];
     // CGSize constraint = CGSizeMake(LABEL_WIDTH - (LABEL_MARGIN *2), 2000.f);
     CGSize maxSize = CGSizeMake(280, MAXFLOAT);//set max height //set the constant width, hear MAXFLOAT gives the maximum height
     
     CGSize size = [stringToSize sizeWithFont:[UIFont systemFontOfSize:20.0f] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
     return size.height; //finally u get the correct height
     */
    //commenting the above code because "sizeWithFont: constrainedToSize:maxSize: lineBreakMode: " has been deprecated to avoid above code use below
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string
                                                                         attributes:@
                                          {
                                          NSFontAttributeName: [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight]
                                          }];
    
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){kScreenWidth - 60, MAXFLOAT}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];//you need to specify the some width, height will be calculated
    CGSize requiredSize = rect.size;
    return (requiredSize.height); //finally u return your height
}

@end
