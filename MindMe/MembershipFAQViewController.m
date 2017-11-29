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
    
    if ([UIScreen mainScreen].bounds.size.height<667) {
        sectionHeight = 60;
    }
    else {
        sectionHeight = 70;
    }
    
    lastOpenedIndex = -1;
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        menuItemsArray=[[NSArray alloc]initWithObjects:@"MindMe.ie Help", @"PARENT LAYER", @"PARENT LAYER", nil];
    }
    else {
        menuItemsArray=[[NSArray alloc]initWithObjects:@"Getting started with MindMe.ie is easy", @"PARENT LAYER", @"PARENT LAYER", nil];
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
    
    _faqTableView.delegate1 = self;
    
    faqArr = [[NSMutableArray alloc] init];
    
    [self prepareDataSourceForGeneralFAQ];
    [self prepareDataSourceForJobsFAQ];
    [self prepareDataSourceForAccountFAQ];
    
}

- (void) prepareDataSourceForGeneralFAQ {
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        
        NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
        NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
        [tmpDict setObject:@"Your Personal Details & Profile" forKey:@"ques"];
        [tmpDict setObject:@"Before you start that all important job search make sure you have filled in your 'Personal Details' and 'Created a Profile'.\nMindMe.ie is a great resource for finding that ideal job. So how do you stand out from the crowd?\nWe know the job search can take time. So get noticed and hired with a great profile and a great photo." forKey:@"ans"];
        [tmpArr addObject:tmpDict];
        
        NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
        [tmpDict1 setObject:@"First" forKey:@"ques"];
        [tmpDict1 setObject:@"Sign up for text or email job alerts and respond to new job postings ASAP. Families tend to look at the first applicants rather than the last." forKey:@"ans"];
        [tmpArr addObject:tmpDict1];
        
        NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
        [tmpDict2 setObject:@"Persistent" forKey:@"ques"];
        [tmpDict2 setObject:@"Follow up once you've sent an application. In the \"My Messages\" section, look in \"Sent Items\" and you can see all the messages you've sent. If it's a job you're keenly interested in, send a follow up message to see if they've hired anyone. Re-state why you're a very good fit. You may just have gotten lost in the shuffle and this additional new message now puts you at the top of their inbox again." forKey:@"ans"];
        [tmpArr addObject:tmpDict2];
        
        NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
        [tmpDict3 setObject:@"Social" forKey:@"ques"];
        [tmpDict3 setObject:@"Advertise your services beyond MindMe.ie. With thousands of members, you never know who's on the site or who's looking for help. Tweet your profile link on Twitter or mention on your Facebook profile that you're looking for a job, with a link to your MindMe.ie profile." forKey:@"ans"];
        [tmpArr addObject:tmpDict3];
        
        NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
        [tmpDict4 setObject:@"Detailed" forKey:@"ques"];
        [tmpDict4 setObject:@"For example, mention if you have first aid training, provide after school care or have your own car. Using the right words and details can help more families find you when they search for specific traits." forKey:@"ans"];
        [tmpArr addObject:tmpDict4];
        
        NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
        [tmpDict5 setObject:@"Personal" forKey:@"ques"];
        [tmpDict5 setObject:@"Don't copy and paste the same message to all families. Your response to a job post is your babysitter or nanny introductory cover letter. So it is important that you personalize it for the specific job. Say why you're a good fit for what they need, and provide details that illustrate why they would be lucky to have you." forKey:@"ans"];
        [tmpArr addObject:tmpDict5];
        
        NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
        [tmpDict6 setObject:@"Featured" forKey:@"ques"];
        [tmpDict6 setObject:@"If you're actively looking for a job, it may be a good time to Get Featured. There are lots of perks to being featured, so you may want to upgrade to find a job. You get job alerts before anyone else and a highlighted profile, giving you more exposure and a better chance of being hired." forKey:@"ans"];
        [tmpArr addObject:tmpDict6];
        
        [faqArr addObject:tmpArr];
        
    }
    else {
        
        NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
        NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
        [tmpDict setObject:@"CREATE AN ADVERT" forKey:@"ques"];
        [tmpDict setObject:@"Create a detailed job description that explains exactly what you're looking for, think about what you want and then put that into words. Share a little information about your family and its needs. Also include qualities that you value, like organization. This way, the best applicants will respond.\nBe clear about the \"must-haves\" (non-smoker, has a car, etc.) and the \"nice-to-haves\" (speaks Spanish, enjoys reading, etc.).\nDon't ignore your schedule, either. You may find the perfect nanny, childcare or senior carer but if she or he can't provide care when you need it, then they are not a good fit. If you have changed your work schedule to fit around classes, you may need to look elsewhere. Stay firm on the times you need; the right person will come along.\nTry to respond to everyone who has applied to your job. It may take time, but no one likes to be left in the dark. By letting providers know that you are not interested, they can apply to other jobs." forKey:@"ans"];
        [tmpArr addObject:tmpDict];
        
        NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
        [tmpDict1 setObject:@"Job Title" forKey:@"ques"];
        [tmpDict1 setObject:@"Make sure you are using the right job title. Do you think of your after-school childcare support as simply a babysitter? If you're looking for someone on a regular basis, with set hours you can always rely on, who can challenge, teach and plan activities with your children; try posting an ad for a part-time nanny instead of a babysitter." forKey:@"ans"];
        [tmpArr addObject:tmpDict1];
        
        NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
        [tmpDict2 setObject:@"Neglecting References, Interviews and Reviews" forKey:@"ques"];
        [tmpDict2 setObject:@"Do your homework. Remember, when setting up an interview, choose a neutral location. A library, a coffee shop are good places to conduct an in-person chat.\nMake sure you conduct a thorough interview with the caregiver before hiring them. This is the time to ask important questions to see if they are the best fit.\nRequest references. Call past employers and dig for more information. Ask about strengths as well as weaknesses. Ask if the referee would hire her again" forKey:@"ans"];
        [tmpArr addObject:tmpDict2];
        
        NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
        [tmpDict3 setObject:@"UPDATE ADVERT" forKey:@"ques"];
        [tmpDict3 setObject:@"If you moved to another town, update your profile and job description so you get responses from nannies / childcarers who are nearby. After you find the perfect match for your family on MindMe.ie, be sure to \"close\" your job. Our carers are very persistent and if they see an open job, they'll apply. By closing the job, they won't be applying to a position that has already been filled." forKey:@"ans"];
        [tmpArr addObject:tmpDict3];
        
        NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
        [tmpDict4 setObject:@"Include a Picture" forKey:@"ques"];
        [tmpDict4 setObject:@"A picture is worth a thousand words -- and it helps your profile come alive.\nBy having a picture of your family next to your job description, this allows providers to put a face to a name. It reassures the provider that an actual family is receiving their application. It also helps a provider know who you are when they are meeting you for an interview at a local coffee shop! " forKey:@"ans"];
        [tmpArr addObject:tmpDict4];
        
        [faqArr addObject:tmpArr];
        
        
    }
    
    
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
