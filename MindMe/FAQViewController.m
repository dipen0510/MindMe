//
//  FAQViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 17/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FAQViewController.h"
#import "FAQSectionView.h"
#import "FAQTableViewCell.h"

@interface FAQViewController ()<STCollapseTableViewDelegate> {
    int sectionHeight;
}


@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    if ([UIScreen mainScreen].bounds.size.height<667) {
        sectionHeight = 60;
    }
    else {
        sectionHeight = 70;
    }
    
    lastOpenedIndex = -1;
    menuItemsArray=[[NSArray alloc]initWithObjects:@"GENERAL", @"JOBS", @"USING THE SITE", nil];
    sectionArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<menuItemsArray.count; i++) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FAQSectionView" owner:self options:nil];
        FAQSectionView *header = [topLevelObjects objectAtIndex:0];
        header.backgroundColor = [UIColor whiteColor];
        header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, sectionHeight);
        header.menuTitle.text = [menuItemsArray objectAtIndex:i];
        [sectionArr addObject:header];
        
    }
    
    _faqTableView.delegate1 = self;
    
    faqArr = [[NSMutableArray alloc] init];
    
    [self prepareDataSourceForGeneralFAQ];
    [self prepareDataSourceForJobsFAQ];
    [self prepareDataSourceForAccountFAQ];
    
}

- (void) prepareDataSourceForGeneralFAQ {
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:@"How do I upgrade to a Silver or Gold Membership?" forKey:@"ques"];
    [tmpDict setObject:@"You've browsed the available carers, you've received responses to your job advert, and now you're ready to start communicating and finding the perfect fit for your family!'UPGARDE NOW' button below and you will be brought to the 'SUBSCRIPTION MEMBERSHIP PAGE' Select the subscription option that best suits your need, you can then enter your credit or debit card details through our secure payment system." forKey:@"ans"];
    [tmpArr addObject:tmpDict];
    
    NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
    [tmpDict1 setObject:@"How do I edit my personal information? (Address, Password, etc.)" forKey:@"ques"];
    [tmpDict1 setObject:@"It is important to keep your personal information up to date. To edit your personal details Click on 'MY ACCOUNT' in the menu bar and select 'PERSONAL DETAILS' You can update your name, town, , phone number, etc. Please note that changes to your personal information may take up to 24 hours to be approved. If you need further help updating this information please email support@mindme.ie with detailed instructions as to your required changes." forKey:@"ans"];
    [tmpArr addObject:tmpDict1];
    
    NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
    [tmpDict2 setObject:@"Do people see my personal information?" forKey:@"ques"];
    [tmpDict2 setObject:@"Your contact information is kept private until you voluntarily share it with providers through private messaging. You also will notice that everyone on MindMe.ie appears as first name and initial of last name only." forKey:@"ans"];
    [tmpArr addObject:tmpDict2];
    
    NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
    [tmpDict3 setObject:@"How do I reset my password?" forKey:@"ques"];
    [tmpDict3 setObject:@"If you have forgotten your password, just follow this link and follow the instructions on how to reset your password." forKey:@"ans"];
    [tmpArr addObject:tmpDict3];
    
    NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
    [tmpDict4 setObject:@"How do I unsubscribe from emails?" forKey:@"ques"];
    [tmpDict4 setObject:@"We do our best to only send you emails that are useful, but if you'd like to stop receiving some (or all) promotional emails from us, just contact support or click the unsubscribe button at the bottom of the mail." forKey:@"ans"];
    [tmpArr addObject:tmpDict4];
    
    NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
    [tmpDict5 setObject:@"How do I cancel my subscription?" forKey:@"ques"];
    [tmpDict5 setObject:@"Login to your account and Click the ‘MY ACCOUNT’ tab in the menu bar and scroll down to ‘HELP ON MEMBERSHIP’ and follow the simple instructions" forKey:@"ans"];
    [tmpArr addObject:tmpDict5];
    
    NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
    [tmpDict6 setObject:@"How do I delete my account?" forKey:@"ques"];
    [tmpDict6 setObject:@"Login to your account and first cancel your subscription. The DELETE button will only show when your subscription has ended. To DELETE click the 'MY ACCOUNT' option in the menu bar and then click 'HELP ON MEMBERSHIP' Scroll down to the bottom of the page and click on DELETE." forKey:@"ans"];
    [tmpArr addObject:tmpDict6];
    
    [faqArr addObject:tmpArr];
    
}


- (void) prepareDataSourceForJobsFAQ {
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:@"How do I post a Job?" forKey:@"ques"];
    [tmpDict setObject:@"Posting a job is one of the most effective ways of accumulating quality, targeted applicants for your specific needs. Click on 'MY ACCOUNT' in the menu bar and scroll down to Create/Edit advert and follow the simple instructions." forKey:@"ans"];
    [tmpArr addObject:tmpDict];
    
    NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
    [tmpDict1 setObject:@"How do I edit my Job Post?" forKey:@"ques"];
    [tmpDict1 setObject:@"You can always edit, update or close your Job Post directly from your 'MY ACCOUNT' page. Click the 'MY ACCOUNT' button on the menu bar and scroll down to Create/Edit advert and follow the simple instructions." forKey:@"ans"];
    [tmpArr addObject:tmpDict1];
    
    NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
    [tmpDict2 setObject:@"How do I turn ON/OFF my advert?" forKey:@"ques"];
    [tmpDict2 setObject:@"Login to your account and scroll down the landing page (MY ACCOUNT DETAILS) - you will see your advert with ON/OFF next to it - Just click on the ON and it will turn to OFF or visa versa." forKey:@"ans"];
    [tmpArr addObject:tmpDict2];
    
    NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
    [tmpDict3 setObject:@"How do I find my old job postings?" forKey:@"ques"];
    [tmpDict3 setObject:@"If you'd like to find the jobs you've posted in the past and view the list of applicants who applied to the job, just go to your MY JOBS page. On this page, you will initially see the current list of open job posts you have. You'll see a tab on the page that says 'Closed'. Click on this tab and you'll be able to view the details of your old job posts and the list of applicants who previously applied to your job." forKey:@"ans"];
    [tmpArr addObject:tmpDict3];
    
    NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
    [tmpDict4 setObject:@"Why was my Job Post not approved?" forKey:@"ques"];
    [tmpDict4 setObject:@"You will receive an email from us when your job post is not approved, and the email will indicate the most common reasons why a certain part of your posting was not approved. The following list comprises the most common reasons as to why a job post may not be approved:\n1) Job posts are visible to all. Please use your discretion when including information specific to medical conditions, special requirements and other sensitive information.\n\n2) Be sure that you do not include your phone number or email address, any last names or children's names. Posts are visible to all, and we want to save your personal information for private communications.\n\n3) No specific locations or addresses. For safety purposes, we encourage sticking to the details of the job, not the precise location.\n\n4) PLEASE DO NOT WRITE IN ALL UPPER CASE LETTERS! It rather feels like we're being shouted at.\n\n5) Be sure to include enough detail about the position so that your message is clear and can be understood by a broad audience. Try to avoid abbreviations, and if you're adding a lot of content, separate into paragraphs for easier reading.\n\n6) Be sure that you have posted in the correct category, and make sure that all information is relevant to the position description.\n\n7) Your subject line should be unique and specific. Instead of just writing \"Dog Walker\", try using keywords to help your post stand out, like \"Searching for a Full-time, M-F Dog Walker\"\n\n8) Bullet Points are nice, but don't go overboard. Carers and Service Providers appreciate hearing your voice in the description, so please use complete sentences.\n\n9) Be sure that your Account Information (full name, email, phone number, etc.) is accurate. Incomplete or false information will not be approved.\n\n10) Businesses, companies, agencies, and organisations cannot use MindMe.ie to hire employees.\n\n11) Please check your spelling and grammar. Use the spell check on your web browser for assistance." forKey:@"ans"];
    [tmpArr addObject:tmpDict4];
    
    NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
    [tmpDict5 setObject:@"Why can't I reply to a job applicant's message?" forKey:@"ques"];
    [tmpDict5 setObject:@"If you find yourself unable to respond to your job applicants, you may want to check these two things first: You must be a Silver or Gold member to contact other members on MindMe.ie. Be sure that you are logged into your account! Check the top right-hand corner and it should say 'Logout' to indicate that you are logged in. If you are unsure, log out completely and log back in to ensure that you are logged in correctly. If you continue to have trouble responding to a message, it may also be that the carer you are trying to contact is not available or has deactivated their account." forKey:@"ans"];
    [tmpArr addObject:tmpDict5];
    
    NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
    [tmpDict6 setObject:@"How do I block a carer from seeing my job post?" forKey:@"ques"];
    [tmpDict6 setObject:@"Job posts are searchable for all, and it is not possible to keep any one person from finding them on the website." forKey:@"ans"];
    [tmpArr addObject:tmpDict6];
    
    [faqArr addObject:tmpArr];
    
}

- (void) prepareDataSourceForAccountFAQ {
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:@"How do I search for carers or service providers?" forKey:@"ques"];
    [tmpDict setObject:@"Whether you've chosen to post a job to advertise your care needs, or opted not to, you can still browse and get in touch with local carers and service providers directly. Near the top of most of the pages on MindMe.ie you'll notice a search bar where you can enter your search area. You can choose the type of carer you are looking for. When you're ready, click search!" forKey:@"ans"];
    [tmpArr addObject:tmpDict];
    
    NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
    [tmpDict1 setObject:@"How do I sort and refine my search results?" forKey:@"ques"];
    [tmpDict1 setObject:@"Once you've run your search, the next page will list the results based on your chosen options. You will see that the left side of the page offers a variety of refinement options with particular skills and qualifications. At the top of the list there is also a menu that allows you to sort the way you view the results by Distance" forKey:@"ans"];
    [tmpArr addObject:tmpDict1];
    
    NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
    [tmpDict2 setObject:@"Are all of the carers and service providers available?" forKey:@"ques"];
    [tmpDict2 setObject:@"Each of the profiles you view are managed by the carers and service providers that created them. Each profile indicates the specified availability of the provider in an easily accessible checklist located on their profile. We encourage carers to keep their availability up to date and manage their accounts regularly to indicate if they have found a job or are no longer available to work." forKey:@"ans"];
    [tmpArr addObject:tmpDict2];
    
    NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
    [tmpDict3 setObject:@"How do I contact carers I'm interested in?" forKey:@"ques"];
    [tmpDict3 setObject:@"You've browsed through profiles and now you want to contact your top candidates. On the carer's profile you will see a 'CONTACT ME' button to send a message to that particular carer. By clicking 'CONTACT ME, a message box will appear where you send a direct, private message through the website. After you've typed everything you'd like to say, just click the 'Send' button." forKey:@"ans"];
    [tmpArr addObject:tmpDict3];
    
    NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
    [tmpDict4 setObject:@"How do I view a carer's documents and certifications?" forKey:@"ques"];
    [tmpDict4 setObject:@"As a Silver or Gold member, families seeking care can view any documents or certificates that a carer or service provider has uploaded to their account. If a Carer has uploaded a CV or other documents you will be able to download the CV or Certificate." forKey:@"ans"];
    [tmpArr addObject:tmpDict4];
    
    NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
    [tmpDict5 setObject:@"How do I write a Review on a carer" forKey:@"ques"];
    [tmpDict5 setObject:@"Reviews are a good way of letting people know your experience with carers you have previously hired. Silver and gold members of MindMe.ie will have the ability to leave a one to five star rating. Just locate the carer's profile, scroll to the \"Reviews\" section, and click the \"Rate\" button. You can rate a carer with one to five stars" forKey:@"ans"];
    [tmpArr addObject:tmpDict5];
    
    NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
    [tmpDict6 setObject:@"How do I report a concern to MindMe.ie?" forKey:@"ques"];
    [tmpDict6 setObject:@"MindMe.ie takes the safety and standards of the website and our members very seriously. As much as we focus our energy on these efforts, the feedback we get from our members is a crucial part of improving the overall experience. If you would like to report a concern to MindMe.ie, let us know by sending an email to our support team at support@mindme.ie" forKey:@"ans"];
    [tmpArr addObject:tmpDict6];
    
    [faqArr addObject:tmpArr];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark TableView Datasource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return sectionArr.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSMutableArray *)[faqArr objectAtIndex:section]).count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:@"VisbyRoundCF-Regular" size:12.0]}
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
                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"VisbyRoundCF-Medium" size:15.0]}
                                            context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

@end
