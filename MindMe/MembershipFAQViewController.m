//
//  MembershipFAQViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "MembershipFAQViewController.h"
#import "FAQSectionView.h"
#import "FAQTableViewCell.h"
#import "MembershipDeleteAccountTableViewCell.h"

@interface MembershipFAQViewController ()<STCollapseTableViewDelegate> {
    int sectionHeight;
}

@end

@implementation MembershipFAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupInitialUI];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _faqTableView.delegate1 = nil;
    _faqTableView.delegate = nil;
    _faqTableView = nil;
    
}

- (void) setupInitialUI {
    
    faqArr = [[NSMutableArray alloc] init];
    _faqTableView.delegate1 = self;
    
    if ([UIScreen mainScreen].bounds.size.height<667) {
        sectionHeight = 70;
    }
    else {
        sectionHeight = 80;
    }
    
    lastOpenedIndex = -1;
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        menuItemsArray=[[NSArray alloc] initWithObjects:@"MindMe.ie Help.", nil];
        [self prepareDataSourceForMindMeHelp];
    }
    else {
    
        menuItemsArray=[[NSArray alloc] initWithObjects:@"Getting started with MindMe.ie is easy.", @"Paypal, Stripe & Go Cardless Secure Payment Systems.", @"Be Aware of Auto-Renewal.", @"Cancel", nil];
        [self prepareDataSourceForGettingStarted];
        [self prepareDataSourceForPaypal];
        [self prepareDataSourceForBeAwareofAutoRenewal];
        [self prepareDataSourceForCancel];
    }
    
    
    sectionArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<menuItemsArray.count; i++) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FAQSectionView" owner:self options:nil];
        FAQSectionView *header = [topLevelObjects objectAtIndex:0];
        header.backgroundColor = [UIColor whiteColor];
        header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
        header.menuTitle.text = [menuItemsArray objectAtIndex:i];
        [sectionArr addObject:header];
        
    }
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    if ([[responseData valueForKey:@"Sub_active"] intValue] == 1) {
        [self startDowngradeAccountService];
    }
    
    
    
}

- (void) prepareDataSourceForMindMeHelp {
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init]; NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init]; [tmpDict setObject:@"Your Personal Details & Profile" forKey:@"ques"]; [tmpDict setObject:@"Before you start that all important job search make sure you have filled in your 'Personal Details' and 'Created a Profile'.\nMindMe.ie is a great resource for finding that ideal job. So how do you stand out from the crowd?\nWe know the job search can take time. So get noticed and hired with a great profile and a great photo" forKey:@"ans"]; [tmpArr addObject:tmpDict];  NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init]; [tmpDict1 setObject:@"First" forKey:@"ques"]; [tmpDict1 setObject:@"Sign up for text or email job alerts and respond to new job postings ASAP. Families tend to look at the first applicants rather than the last." forKey:@"ans"]; [tmpArr addObject:tmpDict1];  NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init]; [tmpDict2 setObject:@"Persistent" forKey:@"ques"]; [tmpDict2 setObject:@"Follow up once you've sent an application. In the ‘My Messages’ section, look in ‘Sent Items’ and you can see all the messages you've sent. If it's a job you're keenly interested in, send a follow up message to see if they've hired anyone. Re-state why you're a very good fit. You may just have gotten lost in the shuffle and this additional new message now puts you at the top of their inbox again." forKey:@"ans"]; [tmpArr addObject:tmpDict2];  NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init]; [tmpDict3 setObject:@"Social" forKey:@"ques"]; [tmpDict3 setObject:@"Advertise your services beyond MindMe.ie. With thousands of members, you never know who's on the site or who's looking for help. Tweet your profile link on Twitter or mention on your Facebook profile that you're looking for a job, with a link to your MindMe.ie profile. " forKey:@"ans"]; [tmpArr addObject:tmpDict3];  NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init]; [tmpDict4 setObject:@"Detailed" forKey:@"ques"]; [tmpDict4 setObject:@"For example, mention if you have first aid training, provide after school care or have your own car. Using the right words and details can help more families find you when they search for specific traits." forKey:@"ans"]; [tmpArr addObject:tmpDict4];  NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init]; [tmpDict5 setObject:@"Personal" forKey:@"ques"]; [tmpDict5 setObject:@"Don't copy and paste the same message to all families. Your response to a job post is your babysitter or nanny introductory cover letter. So it is important that you personalize it for the specific job. Say why you're a good fit for what they need, and provide details that illustrate why they would be lucky to have you. " forKey:@"ans"]; [tmpArr addObject:tmpDict5];  NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init]; [tmpDict6 setObject:@"Featured" forKey:@"ques"]; [tmpDict6 setObject:@"If you're actively looking for a job, it may be a good time to Get Featured. There are lots of perks to being featured, so you may want to upgrade to find a job. You get job alerts before anyone else and a highlighted profile, giving you more exposure and a better chance of being hired." forKey:@"ans"]; [tmpArr addObject:tmpDict6];
    NSMutableDictionary* tmpDict7 = [[NSMutableDictionary alloc] init]; [tmpDict7 setObject:@"Active" forKey:@"ques"]; [tmpDict7 setObject:@"Log in daily and respond to emails immediately. No one wants to hire someone who was slow to respond and last logged into their account two weeks ago. By logging in daily, you show you're serious about finding a job. \n\nGood luck! " forKey:@"ans"]; [tmpArr addObject:tmpDict7];
    [faqArr addObject:tmpArr];

}

#pragma mark - Parent Membership

- (void) prepareDataSourceForGettingStarted {  NSMutableArray* tmpArr = [[NSMutableArray alloc] init]; NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init]; [tmpDict setObject:@" " forKey:@"ques"]; [tmpDict setObject:@"At MindMe.ie we know that the process of finding the perfect Babysitter, Nanny, Senior Carer or Housekeeper can seem a little daunting. As more and more people turn to MindMe.ie for help, we can assure you we are assisting you as much as we can." forKey:@"ans"]; [tmpArr addObject:tmpDict];  NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init]; [tmpDict1 setObject:@"CREATE AN ADVERT" forKey:@"ques"]; [tmpDict1 setObject:@"Create a detailed job description that explains exactly what you're looking for, think about what you want and then put that into words. Share a little information about your family and its needs. Also include qualities that you value, like organization. This way, the best applicants will respond. \nBe clear about the \"must-haves\" (non-smoker, has a car, etc.) and the \"nice-to-haves\" (speaks Spanish, enjoys reading, etc.). \nDon't ignore your schedule, either. You may find the perfect nanny, childcare or senior carer but if she or he can't provide care when you need it, then they are not a good fit. If you have changed your work schedule to fit around classes, you may need to look elsewhere. Stay firm on the times you need; the right person will come along.\nTry to respond to everyone who has applied to your job. It may take time, but no one likes to be left in the dark. By letting providers know that you are not interested, they can apply to other jobs." forKey:@"ans"]; [tmpArr addObject:tmpDict1];  NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init]; [tmpDict2 setObject:@"Job Title" forKey:@"ques"]; [tmpDict2 setObject:@"Make sure you are using the right job title. Do you think of your after-school childcare support as simply a babysitter? If you're looking for someone on a regular basis, with set hours you can always rely on, who can challenge, teach and plan activities with your children; try posting an ad for a part-time nanny instead of a babysitter." forKey:@"ans"]; [tmpArr addObject:tmpDict2];  NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init]; [tmpDict3 setObject:@"Neglecting References, Interviews and Reviews " forKey:@"ques"]; [tmpDict3 setObject:@"Do your homework. Remember, when setting up an interview, choose a neutral location. A library, a coffee shop are good places to conduct an in-person chat. \nMake sure you conduct a thorough interview with the caregiver before hiring them. This is the time to ask important questions to see if they are the best fit. \nRequest references. Call past employers and dig for more information. Ask about strengths as well as weaknesses. Ask if the referee would hire her again. " forKey:@"ans"]; [tmpArr addObject:tmpDict3];  NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init]; [tmpDict4 setObject:@"UPDATE ADVERT" forKey:@"ques"]; [tmpDict4 setObject:@"If you moved to another town, update your profile and job description so you get responses from nannies / childcarers who are nearby. After you find the perfect match for your family on MindMe.ie, be sure to \"close\" your job. Our carers are very persistent and if they see an open job, they'll apply. By closing the job, they won't be applying to a position that has already been filled." forKey:@"ans"]; [tmpArr addObject:tmpDict4];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init]; [tmpDict5 setObject:@"Include a Picture" forKey:@"ques"]; [tmpDict5 setObject:@"A picture is worth a thousand words -- and it helps your profile come alive.\n\nBy having a picture of your family next to your job description, this allows providers to put a face to a name. It reassures the provider that an actual family is receiving their application. It also helps a provider know who you are when they are meeting you for an interview at a local coffee shop! " forKey:@"ans"]; [tmpArr addObject:tmpDict5];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         [faqArr addObject:tmpArr]; }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         - (void) prepareDataSourceForPaypal {  NSMutableArray* tmpArr = [[NSMutableArray alloc] init]; NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init]; [tmpDict setObject:@" " forKey:@"ques"]; [tmpDict setObject:@"MindMe.ie can cost as little as 36 c a day giving you access to a range of caregivers. If you haven't already completed your MindMe.ie membership, make sure you have filled out your 'Personal Details' and 'Created an Advert'. To gain full access just click here and choose the subscription/payment option that suits you. Members of MindMe.ie have full access to all our Carergiver profiles. This will enable you to access the information detailed below and allow you to contact your preferred Babysitters, Childminders, Tutors, Nannies, Senior Carers etc. " forKey:@"ans"]; [tmpArr addObject:tmpDict];  NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init]; [tmpDict1 setObject:@"As a Member you will be able to view " forKey:@"ques"]; [tmpDict1 setObject:@"> The carers complete profile.\n> Their qualifications.\n> Their previous experience.\n> The languages they speak. Their references.\n> Any vetting they may have.\n\nSubscription payments are made via Stripe, PayPal or if you don’t have a credit or debit card by Go Cardless via bank transfer. \nYour payments are totally secure. MindMe.ie use 128-bit SSL encryption, the industry standard throughout the world for online payments. Subscribe Now and get access to thousands of care professionals" forKey:@"ans"]; [tmpArr addObject:tmpDict1]; 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             [faqArr addObject:tmpArr]; }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         - (void) prepareDataSourceForBeAwareofAutoRenewal {  NSMutableArray* tmpArr = [[NSMutableArray alloc] init]; NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init]; [tmpDict setObject:@" " forKey:@"ques"]; [tmpDict setObject:@"Just like any subscription, your MindMe.ie membership is automatically renewed. We highlight this on our billing page and on the Membership Plan page but realize that if you're focused on finding care or a new job, you may not always see it right away. Most of our members are aware of the auto-renewal policy, but some don't notice it. But there is a reason behind it. \n\nWe auto-renew our customers because we don't know what stage of the search process you are in. Everyone has different needs, and sometimes it takes time to find a perfect fit. If we stopped your one-month membership when it expired and you were still searching, you would lose access to the information you already gathered. By keeping your MindMe.ie account going, you can still perform multiple searches and contact additional care providers, all without interrupting your process.\n\nHowever -- if you find someone and are finished with your search, you can always downgrade your membership to a free, Basic account. You don't have to completely close your account to stop the subscription; just cancel your subscription and continue to be a free member." forKey:@"ans"]; [tmpArr addObject:tmpDict]; 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             [faqArr addObject:tmpArr]; }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         - (void) prepareDataSourceForCancel {  NSMutableArray* tmpArr = [[NSMutableArray alloc] init]; NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init]; [tmpDict setObject:@" " forKey:@"ques"]; [tmpDict setObject:@"If you no longer wish to be a member of MindMe.ie and would like to deactivate your account simply click the 'Delete Account' button below, However if you are a subscribed member you must first cancel your Stripe, Paypal or Go Cardless subscription by clicking the subscription button above and following the instructions." forKey:@"ans"]; [tmpArr addObject:tmpDict]; 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             [faqArr addObject:tmpArr]; }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return sectionArr.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == sectionArr.count-1) {
        return ((NSMutableArray *)[faqArr objectAtIndex:section]).count + 1;
    }
    
    return ((NSMutableArray *)[faqArr objectAtIndex:section]).count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == sectionArr.count-1) && (indexPath.row == ((NSMutableArray *)[faqArr objectAtIndex:indexPath.section]).count)) {
        
        static NSString *CellIdentifier = @"MembershipDeleteAccountTableViewCell";
        MembershipDeleteAccountTableViewCell *cell = (MembershipDeleteAccountTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MembershipDeleteAccountTableViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        
        NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
        NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
        
        if ([[responseData valueForKey:@"Sub_active"] intValue] == 1) {
            
            if (isSubscriptionCancelled) {
                cell.deactivateButton.hidden = YES;
                cell.subscriptionLabel.hidden = NO;
            }
            else {
                cell.deactivateButton.hidden = NO;
                cell.subscriptionLabel.hidden = YES;
            }
            
            [cell.deactivateButton addTarget:self action:@selector(deactivateSubscriptionButtonTapped) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else {
            
            [cell.deactivateButton setTitle:@"Delete Account" forState:UIControlStateNormal];
            cell.deactivateButton.hidden = NO;
            cell.subscriptionLabel.hidden = YES;
            
            [cell.deactivateButton addTarget:self action:@selector(deleteAccountButtonTapped) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        
        return cell;
        
    }
    
    static NSString *CellIdentifier = @"FAQTableViewCell";
    FAQTableViewCell *cell = (FAQTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FAQTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [self populateContentForAdsCell:cell forIndexPath:indexPath];
    
    return cell;
    
    
}

-(void)didTapOnSectionHeader:(NSInteger)section {
    
    FAQSectionView *header = [sectionArr objectAtIndex:section];
    
    if (lastOpenedIndex>-1 && lastOpenedIndex!=section) {
        FAQSectionView *openedHeader = [sectionArr objectAtIndex:lastOpenedIndex];
        [UIView animateWithDuration:0.3 animations:^{
            openedHeader.chevronImgView.transform = CGAffineTransformRotate(openedHeader.chevronImgView.transform, M_PI);
        }];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        header.chevronImgView.transform = CGAffineTransformRotate(header.chevronImgView.transform, M_PI);
    }];
    
    lastOpenedIndex = section;
    
}

-(void)willSectionOpen:(NSInteger)section {
    
    
    
}

- (void)willSectionClose:(NSInteger)section {
    
    lastOpenedIndex = -1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    if (indexPath.row == 0 && indexPath.section == 0) {
    //
    //        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"EditProfileViewController" forSideMenuController:self.sideMenuController];
    //
    //    }
    //    else if (indexPath.row == 1 && indexPath.section == 0) {
    //
    //        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdvertsViewController" forSideMenuController:self.sideMenuController];
    //
    //    }
    //    else if (indexPath.section == 1) {
    //
    //        [[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
    //
    //    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ((indexPath.section == sectionArr.count-1) && (indexPath.row == ((NSMutableArray *)[faqArr objectAtIndex:indexPath.section]).count)) {
        
        return 90;
        
    }
    
    return ([self getLabelHeight:[[[faqArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"ans"]] + [self getHeaderLabelHeight:[[[faqArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"ques"]] + 37.);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    FAQSectionView *header = [sectionArr objectAtIndex:section];
    header.chevronImgView.hidden = NO;
    
    return header;
}


- (void) populateContentForAdsCell:(FAQTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    cell.tag = (indexPath.section*100) + indexPath.row;
    
    cell.headerTitle.text = [[[faqArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"ques"];
    cell.bodyTitle.text = [[[faqArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"ans"];
    
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

- (CGFloat)getLabelHeight:(NSString*)text
{
    CGSize constraint = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [text boundingRectWithSize:constraint
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Montserrat-Light" size:(20./667)*kScreenHeight]}
                                            context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

- (CGFloat)getHeaderLabelHeight:(NSString*)text
{
    CGSize constraint = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [text boundingRectWithSize:constraint
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Montserrat-Regular" size:20.]}
                                            context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

- (void) deactivateSubscriptionButtonTapped {
    
    [self startGetStripeSubscriptionService];
    
}

- (void) deleteAccountButtonTapped {
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to deactivate this account?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    
}


#pragma mark - API Helpers

- (void) startDowngradeAccountService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = DowngradeAccount;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForDowngradeAccount]];
    
}

- (void) startDeleteAccountService {
    
    [SVProgressHUD showWithStatus:@"Deactivating account..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = DeleteAccount;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForDowngradeAccount]];
    
}

- (void) startGetStripeSubscriptionService {
    
    [SVProgressHUD showWithStatus:@"Deactivating subscription..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = StripeGetSubscriptionKey;
    manager.delegate = self;
    [manager startStripeAPIToFetchSubscriptionIdWithsData:[self prepareDictionaryForStripeSubscription]];
    
}

- (void) startDeleteSubscriptionServiceForKey:(NSString *)subKey {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = StripeSubscriptionKey;
    manager.delegate = self;
    [manager startStripeAPIToDeleteSubscriptionWithsData:[self prepareDictionaryForDeleteStripeSubscription:subKey]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:DowngradeAccount]) {
        
        NSMutableArray* tmpArr = (NSMutableArray *)[responseData valueForKey:@"message"];
        if (tmpArr.count == 0) {
            isSubscriptionCancelled = NO;
        }
        else {
            isSubscriptionCancelled = YES;
        }
        
        [_faqTableView reloadData];
        
    }
    if ([requestServiceKey isEqualToString:DeleteAccount]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Account deactivated successfully."];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Userid"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUserCarer"];
        [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
        [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
        [[SharedClass sharedInstance] setUserId:nil];
        [[SharedClass sharedInstance] setAuthorizationKey:nil];
        [[SharedClass sharedInstance] setIsUserCarer:NO];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEditProfileMenuButtonHidden"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isProfileUpdated"];
        
        [self.sideMenuController.navigationController popToRootViewControllerAnimated:YES];
        
    }
    if ([requestServiceKey isEqualToString:StripeGetSubscriptionKey]) {
        
        NSMutableArray* subArr = [[NSMutableArray alloc] initWithArray:[[responseData valueForKey:@"subscriptions"] valueForKey:@"data"]];
        
        if (subArr.count>0) {
            
            NSString* subscriptionId = [[subArr objectAtIndex:0] valueForKey:@"id"];
            [self startDeleteSubscriptionServiceForKey:subscriptionId];
            
        }
        else {
            
            [SVProgressHUD showErrorWithStatus:@"No active subscription"];
            
        }
        
        
    }
    
    if ([requestServiceKey isEqualToString:StripeSubscriptionKey]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Subscription deactivated successfully."];
        
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

- (NSMutableDictionary *) prepareDictionaryForDowngradeAccount {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForStripeSubscription {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
    NSDictionary *responseData = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    [dict setObject:[responseData valueForKey:@"sub_id"] forKey:@"customer"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForDeleteStripeSubscription:(NSString *)subKey {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:subKey forKey:@"subId"];
//    [dict setObject:@"true" forKey:@"at_period_end"];
    
    return dict;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self startDeleteAccountService];
    }
    
}

@end
