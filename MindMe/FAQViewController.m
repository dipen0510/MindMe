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
    menuItemsArray=[[NSArray alloc]initWithObjects:@"CARER FAQs", @"Hiring a Childcare :", @"Top Childminder Facts", @"Cost of Childcare", @"Elderly Care", @"Elderly Care Top Tips", @"Au Pairs", @"Pet Care", @"Housekeepers", @"Childcare Terms", nil];
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
    
    [self prepareDataSourceForCARERFAQs];
    [self prepareDataSourceForHiringaChildcare];
    [self prepareDataSourceForTopChildminderFacts];
    [self prepareDataSourceForCostofChildcare];
    [self prepareDataSourceForElderlyCare];
    [self prepareDataSourceForElderlyCareTopTips];
    [self prepareDataSourceForAuPairs];
    [self prepareDataSourceForPetCare];
    [self prepareDataSourceForHousekeepers];
    [self prepareDataSourceForChildcareTerms];
    
}

- (void) prepareDataSourceForCARERFAQs {
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:@"How do I search for jobs? " forKey:@"ques"];
    [tmpDict setObject:@"Now that you have created your profile, it is time to start browsing the job openings in your area. Near the top of most of the pages on MindMe.ie you will notice a search bar with a box where you can enter your area. You can choose the type of job (Child Care, Pet Care, etc.) and when you're ready, click search! On the next page, the search results will list all of the jobs that are nearest or in your area. Once you have found a few matching jobs, it's your turn to contact the person and let them know why you think you're perfect for the job! Click 'VIEW JOB' on the job you want to apply for and then click 'CONTACT ME'. Type a brief description about yourself and your experience and then click 'Send Mail' to send your application directly to the person that posted the job." forKey:@"ans"];
    [tmpArr addObject:tmpDict];
    
    NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
    [tmpDict1 setObject:@"How do I apply to jobs?" forKey:@"ques"];
    [tmpDict1 setObject:@"You have browsed through the job listings, and you see a position that might be right for you. To apply for the position, you can click the 'View Job' link and then click the 'CONTACT ME' tab. There are three things to look for if you find yourself having trouble applying to a specific job post:\n\n1. You must be a registered member of MindMe.ie\n2. You need to be logged into your account! Check the top right-hand corner - just because it says your name, it doesn't necessarily mean you are logged in! If you are logged in, the option you see will say 'logout'.\n3. You also need separate profiles in each individual service category to apply for jobs in that particular category. For example, you can have a child care profile to apply to child care jobs, but you also need a pet care profile if you want to apply to pet care jobs. If you don't currently have the correct profile created, we will prompt you to create one when you click the 'CONTACT ME' link.\n4. How do I write a good job application?\nTo increase your chances of finding a job and receiving more responses from families, it is important to write a good job application. Here are some important tips to keep in mind when writing your job application:\nPersonalize your application. Families will be more eager to respond to your application when they see that you've taken time to really read their job post and taken into consideration their needs and job qualifications. Describe why you are a good fit for what they need.\nStand out over other job seekers. Families receive many applications and browse through many profiles on the site. You have to write something in your application that will make you stand out. Provide unique details that show who you are.\nBe brief. You don't have to tell a family your whole life story. You don't want to overwhelm them. After writing a brief introduction and summary about yourself, suggest they check out your profile. You can always get to know each other during the interview process." forKey:@"ans"];
    [tmpArr addObject:tmpDict1];
    
    NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
    [tmpDict2 setObject:@"How do I make changes to my Profile?" forKey:@"ques"];
    [tmpDict2 setObject:@"You can make any edits or changes to profile by clicking 'MY ACCOUNT' in the menu bar and the clicking 'CREATE / EDIT PROFILE'. Make sure you hit 'Save' to ensure that your changes go through successfully." forKey:@"ans"];
    [tmpArr addObject:tmpDict2];
    
    NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
    [tmpDict3 setObject:@"How do I apply for jobs in multiple categories? " forKey:@"ques"];
    [tmpDict3 setObject:@"If you offer more than one service, feel free to apply to jobs in multiple categories. All you have to do is make sure that you have created the appropriate profile in each individual category." forKey:@"ans"];
    [tmpArr addObject:tmpDict3];
    
    NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
    [tmpDict4 setObject:@"Why can't I apply for this particular job?" forKey:@"ques"];
    [tmpDict4 setObject:@" There are three things to look for if you find yourself having trouble applying to a specific job post:\n\n1. You must be a registered member of MindMe.ie\n2. You need to be logged into your account! Check the top right-hand corner - just because it says your name, it doesn't necessarily mean you are logged in! If you are logged in, the option you see will say 'logout'.\n3. You also need separate profiles in each individual service category to apply for jobs in that category. For example, you can have a child care profile to apply to child care jobs, but you also need a pet care profile if you want to apply to pet care jobs" forKey:@"ans"];
    [tmpArr addObject:tmpDict4];
    
    NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
    [tmpDict5 setObject:@"How do I know if I'm being considered for a job? " forKey:@"ques"];
    [tmpDict5 setObject:@"Like any job you will ever apply to, it is good to keep in mind that you are not the only candidate. Your application and your profile should make you stand out, highlighting the best of your experience and your passion for what you do. You can apply to a variety of positions, focusing on the most recent jobs to be sure your application is among the first received. Being quick of the mark is a powerful indicator of how interested you are. When those people have a significant list of applicants, they will review and contact those that seem to be the best fit for the position. All communication on MindMe.ie works in a messaging format that is just like sending an email." forKey:@"ans"];
    [tmpArr addObject:tmpDict5];
    
    NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
    [tmpDict6 setObject:@"When can I expect a response to my application? " forKey:@"ques"];
    [tmpDict6 setObject:@"When applying for jobs, there is never a precise timeline. Most families will take some time browsing the list of applicants for their job posts before choosing whom to contact. When the right candidates emerge, contact begins by messaging through MindMe.ie. You can view your messages in your MAIL BOX page, and we will also send you a private email to notify you that you have received a response! While you are waiting for responses, keep a watchful eye on the current list of new jobs in your area as they change frequently. " forKey:@"ans"];
    [tmpArr addObject:tmpDict6];
    
    NSMutableDictionary* tmpDict7 = [[NSMutableDictionary alloc] init];
    [tmpDict7 setObject:@"When will MindMe.ie post more jobs?" forKey:@"ques"];
    [tmpDict7 setObject:@"Technically, MindMe.ie does not post the jobs. The families that are seeking help create and manage the job posts that you see on the site. This means that new jobs pop up often! Be sure to watch out for the emails we send you regarding new jobs in your area. This way, you will always be on top of new jobs available and be able to send your profile right away!" forKey:@"ans"];
    [tmpArr addObject:tmpDict7];
    
    NSMutableDictionary* tmpDict8 = [[NSMutableDictionary alloc] init];
    [tmpDict8 setObject:@"How do I edit my Job Post?" forKey:@"ques"];
    [tmpDict8 setObject:@"You can always edit, update or close your Job Post directly from your 'MY ACCOUNT' page. Click the 'MY ACCOUNT' button on the menu bar and scroll down to Create/Edit advert and follow the simple instructions." forKey:@"ans"];
    [tmpArr addObject:tmpDict8];
    
    NSMutableDictionary* tmpDict9 = [[NSMutableDictionary alloc] init];
    [tmpDict9 setObject:@"How do I update my personal account information?" forKey:@"ques"];
    [tmpDict9 setObject:@"Your account information is your personal information: your name, area, email, phone number, etc. You are required to keep this information up-to-date. If you need to edit or update this information for any reason, you can click 'MY ACCOUNT' in the menu bar and scroll down to 'PERSONAL DETAILS' Please note that changes to your personal information may take up to 24 hours to be approved." forKey:@"ans"];
    [tmpArr addObject:tmpDict9];
    
    NSMutableDictionary* tmpDict10 = [[NSMutableDictionary alloc] init];
    [tmpDict10 setObject:@"Do people see my personal information?" forKey:@"ques"];
    [tmpDict10 setObject:@"Generally, the only private information we make publicly visible on MindMe.ie is your first name, the first initial of your last name, the town and postal code you live in, your gender, and your age. If you have elected to share your phone number with potential employers, we will also make that available on our profile." forKey:@"ans"];
    [tmpArr addObject:tmpDict10];
    
    NSMutableDictionary* tmpDict11 = [[NSMutableDictionary alloc] init];
    [tmpDict11 setObject:@"How do I unsubscribe from emails?" forKey:@"ques"];
    [tmpDict11 setObject:@"We do our best to only send you emails that are useful, but if you'd like to stop receiving some (or all) promotional emails from just click the 'UNSUBSCRIBE' button at the bottom of the email or contact us at support@mindme.ie Please note that even if you opt-out of receiving marketing emails, we may continue to send you administrative emails regarding MindMe.ie, including, for example, notices of updates to our Privacy Policy, if we choose to provide such notices to you in this manner." forKey:@"ans"];
    [tmpArr addObject:tmpDict11];
    
    NSMutableDictionary* tmpDict12 = [[NSMutableDictionary alloc] init];
    [tmpDict12 setObject:@"How do I downgrade my account?" forKey:@"ques"];
    [tmpDict12 setObject:@"If you have found a great job and no longer need to be a FEATURED MEMBER? To Downgrade back to the Free Basic Membership, simply return to the Membership Information section of your MY ACCOUNT page and you will find the link to downgrade your membership which will no longer renew. At the end of your current subscription period the account will return to the Free Basic Membership, and you will no longer be charged." forKey:@"ans"];
    [tmpArr addObject:tmpDict12];
    
    NSMutableDictionary* tmpDict13 = [[NSMutableDictionary alloc] init];
    [tmpDict13 setObject:@"How do I close my account?" forKey:@"ques"];
    [tmpDict13 setObject:@"If you would like to deactivate your profile and save your information for later, you can deactivate one or all of your profiles at any time. When your profile is deactivated, you are not visible on the site, and you can activate your profile when you are ready to use the site again. For future reference, you can always deactivate or activate your profiles from your CREATE/EDIT PROFILE or by simply switching to OFF your advert under MY ACCOUNT SETTINGS If you would prefer to close your MindMe.ie account entirely, simply return to the Membership Information section of your My Account page, and from here you'll find the link to close your account. Please note that closing your account is a finite action and cannot be undone." forKey:@"ans"];
    [tmpArr addObject:tmpDict13];
    
    NSMutableDictionary* tmpDict14 = [[NSMutableDictionary alloc] init];
    [tmpDict14 setObject:@"How do I upgrade my account?" forKey:@"ques"];
    [tmpDict14 setObject:@"When you're ready for Featured membership, Click the MY ACCOUNT tab in the menu bar and from there you will find a link to GET FEATURED, and by clicking the link you will be able to choose the best membership plan for you. Please not that you may cancel your membership at any time." forKey:@"ans"];
    [tmpArr addObject:tmpDict14];
    
    NSMutableDictionary* tmpDict15 = [[NSMutableDictionary alloc] init];
    [tmpDict15 setObject:@"What is a Featured membership?" forKey:@"ques"];
    [tmpDict15 setObject:@" Please note that with the Free Basic membership you can still advertise your services and apply to jobs.\n\nThe Featured Membership comes with several extra benefits...\n\n1 Your profile will appear highlighted in the search results\n2 You will also be ranked higher in the search results.\n3 Receive priority email notification of new job listings: these emails arrive hours before Free Basic Members would receive them.\n4 The ability to connect with new families in your area searching for care" forKey:@"ans"];
    [tmpArr addObject:tmpDict15];
    
    NSMutableDictionary* tmpDict16 = [[NSMutableDictionary alloc] init];
    [tmpDict16 setObject:@"How do I contact carers I'm interested in?" forKey:@"ques"];
    [tmpDict16 setObject:@"You've browsed through profiles and now you want to contact your top candidates. On the carer's profile you will see a 'CONTACT ME' button to send a message to that particular carer. By clicking 'CONTACT ME, a message box will appear where you send a direct, private message through the website. After you've typed everything you'd like to say, just click the 'Send' button." forKey:@"ans"];
    [tmpArr addObject:tmpDict16];
    
    NSMutableDictionary* tmpDict17 = [[NSMutableDictionary alloc] init];
    [tmpDict17 setObject:@"How do I make a good profile?" forKey:@"ques"];
    [tmpDict17 setObject:@" The key to receiving more responses and landing the ideal job is making sure your profile reflects the best of you. You need to make a good impression. Here are some tips to ensure your profile is the best it can be:\n\n1. Include as much information as possible. Potential employers want to get to know you through your profile. You need to be specific about why you want a job in childcare, pet care etc, and go beyond just saying that you like children or pets. \nDescribe in detail what your experience is, what tasks you performed and how long you have worked in each position. If you don't have a lot of experience, explain why you chose to go into this field, describe the skills you have that will make you a good carer and any other relevant qualifications you may have.\n\n2. Highlight your skills. It's good to show off what you are good at. If you've taken classes such First Aid, if you speak another language, teach piano, or if you are studying to be a child psychologist, these are important skills that can enhance your profile.\n\n3. Show your personality. Add information to your profile that sets you apart from other candidates, such as new hobbies, volunteer or charity work, interesting child care books you may have read, or a race you participated in. Be creative. This additional information will give a family a more complete picture of whom you really are and why you might be perfect for them.\n\n4. Be professional. Your profile may have good information, but how it is presented and written, can make a difference. Use complete sentences, don't use inappropriate language, don't use all upper case letters, and be sure to check your spelling and grammar.\n\n5. Upload a photo. Photos add personality to your profile." forKey:@"ans"];
    [tmpArr addObject:tmpDict17];
    
    NSMutableDictionary* tmpDict18 = [[NSMutableDictionary alloc] init];
    [tmpDict18 setObject:@"Why was my profile not approved? " forKey:@"ques"];
    [tmpDict18 setObject:@"The following list comprises the most common reasons as to why a profile may not be approved:\n\n1. Telephone numbers, email addresses, last names and children's names should not be included in your profile description. Posts are visible to all, and we want to save your personal information for private communications.\n2. No specific locations or addresses can be included in your profile description.\n3. PLEASE DO NOT WRITE IN ALL UPPER CASE OR CAPITAL LETTERS!\n4. Add at least three complete sentences so that your profile is clear and can be understood by a broad audience. Try to avoid abbreviations, and if you're adding a lot of content, separate into paragraphs for easier reading.\n5. Please check your spelling and grammar. Use a spell check on your browser for assistance.\n6. Be sure you have posted in the correct category. Your child care profile should reflect your experience with child care, and the same goes for housekeeping, pet care, etc.\n7. Check that you have selected the correct type of account. For example, individual caregivers looking for a job should not post a job using a family account to advertise their services since family accounts are for those who want to hire a caregiver.\n8. Do not use bullet points. Complete sentences are preferred.\nPlease don't cut and paste a CV. We want your voice to be reflected in your profile, so feel free to talk about your experience, rather than listing it. You are also encouraged to share your CV/Resume in person when you meet the people you will be working with." forKey:@"ans"];
    [tmpArr addObject:tmpDict18];
    
    NSMutableDictionary* tmpDict19 = [[NSMutableDictionary alloc] init];
    [tmpDict19 setObject:@"Why was my photo not approved?" forKey:@"ques"];
    [tmpDict19 setObject:@"Use the checklist below to be sure your photo meets the following approval standards. Once you have found a photo that meets these requirements you can resubmit it\n\n1 You as the Caregiver must be present in the photo.\n2 The orientation of your photo must be uploaded correctly.\n3 Please be sure you as the Caregiver cannot be confused with anyone else in the photograph. \n4 Your face should be clear and facing the camera. \n5 No sunglasses, no hats, hair, or other apparel obstructing your face. \n6 No pictures that are blurred. \n7 No group photos or photos of you cropped from a group. \n8 No photos with anything inappropriate in the background (No alcoholic beverages etc). \n9 Photo cannot contain any contact information. \n10 Everyone in the picture must be fully clothed, including children. \n11 Photos cannot be copyrighted." forKey:@"ans"];
    [tmpArr addObject:tmpDict19];
    
    NSMutableDictionary* tmpDict20 = [[NSMutableDictionary alloc] init];
    [tmpDict20 setObject:@"How do I update my profile information?" forKey:@"ques"];
    [tmpDict20 setObject:@"You can always Edit or Update your existing profile by clicking the MY ACCOUNT tab in the menu bar and then clicking CREATE/EDIT PROFILE." forKey:@"ans"];
    [tmpArr addObject:tmpDict20];
    
    NSMutableDictionary* tmpDict21 = [[NSMutableDictionary alloc] init];
    [tmpDict21 setObject:@"How do I reset my password?" forKey:@"ques"];
    [tmpDict21 setObject:@"If you have forgotten your password, just follow this link and follow the instructions on how to reset your password." forKey:@"ans"];
    [tmpArr addObject:tmpDict21];
    
    NSMutableDictionary* tmpDict22 = [[NSMutableDictionary alloc] init];
    [tmpDict22 setObject:@"How do I report a concern to MindMe.ie?" forKey:@"ques"];
    [tmpDict22 setObject:@"MindMe.ie takes the safety and standards of the website and our members very seriously. As much as we focus our energy on these efforts, the feedback we get from our members is a crucial part of improving the overall experience. If you would like to report a concern to MindMe.ie, let us know by sending an email to our support team at support@mindme.ie" forKey:@"ans"];
    [tmpArr addObject:tmpDict22];
    
    [faqArr addObject:tmpArr];
    
}

- (void) prepareDataSourceForHiringaChildcare {
    
    NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:@"Looking for childcare ? " forKey:@"ques"];
    [tmpDict setObject:@"Find the quality care you need here on MindMe.ie Ireland’s largest Care Search Website\nThere is no law governing at what age it is legal for a young person to babysit. As a parent you must decide whether someone is old enough to babysit for your children.\nBefore contacting a babysitter or a childcarer on Mindme.ie you must know what your requirements are. Do you need someone on an occasional or regular basis, what age group you are comfortable with, and are there other duties aside from looking after the children that you may wish the babysitter / child carer to perform? Your choice of babysitter / child carer should be based upon a number of factors, most importantly knowledge of your own children and knowledge of the babysitter/ child carers abilities. Once you have decided on and contacted a child carer, get to know the person before offering a job. You should arrange a meeting so that you can get to know them and they can get to know you and your children. Use this opportunity to ask as many questions as you can so that you have all the information to decide if the child carer is right for you and your family. \nIt is your responsibility to engage someone that is responsible, trustworthy and reliable and who will put the welfare and safety of your children before anything else." forKey:@"ans"];
    [tmpArr addObject:tmpDict];
    
    NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
    [tmpDict1 setObject:@"INTERVIEW" forKey:@"ques"];
    [tmpDict1 setObject:@"An interview should focus on the person's experience and childcare skills and any special training they may have. Obtain basic information from the babysitter / child carer such as full name, address and telephone number, and at least two references that you can contact. It is also prudent to ask if they have been Garda vetted. During the meeting the goal is to spark a conversation that will be useful to you both, rather than a barrage of questions. Focus on what is important to you. Make sure that you discuss any specific tasks that you would like your child carer to perform, and any special needs that your children may have." forKey:@"ans"];
    [tmpArr addObject:tmpDict1];
    
    NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
    [tmpDict2 setObject:@"Questions You May Want To Ask" forKey:@"ques"];
    [tmpDict2 setObject:@"What type of experience do you have with other children? If so, what ages were they and how long/over what period did you care for them?\nHave you any childcare or first aid training? \n What kind of interests or hobbies do you have, and do you have any other jobs? \nWhat do you like best about childcare / babysitting and being with kids, and what do you like least? \nWhat kinds of activities do you enjoy doing with children? \nDo you know what to do in an emergency? \nWhat were the difficulties, if any, you have encountered while providing childcare / babysitting? \nHow did you handle these? \nHow much do you charge and what hours are you available? \nDo you have any questions for me?" forKey:@"ans"];
    [tmpArr addObject:tmpDict2];
    
    NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
    [tmpDict3 setObject:@"PAY" forKey:@"ques"];
    [tmpDict3 setObject:@"Childcare /Babysitter rates are usually paid by the hour. Find out what other parents in your area are paying and ask the child carer / babysitter what rates they charge. You can start off by asking how much he/she charges or by indicating how much you are willing to pay. More experienced child carers will receive higher rates. Childcare providers and Babysitters with special qualifications or training may also receive higher rates. Also consider the responsibilities the job includes, how many children need to be looked after and what age is the child/children." forKey:@"ans"];
    [tmpArr addObject:tmpDict3];
    
    NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
    [tmpDict4 setObject:@"RESPONSIBILITIES" forKey:@"ques"];
    [tmpDict4 setObject:@"Always get to know your childcare provider before offering a job.\nGive the childcare provider / babysitter all the information that they need to do the job well and responsibly.\nAgree payment and hours in advance. \nPay the childcare provider / babysitter in full at the agreed time. \nCancel the childcare provider / babysitter well in advance if your child is unwell or your arrangements have changed. If a child has been unwell recently, tell the childcare provider / babysitter. \nTell the childcare provider / babysitter what time you are expected home, and contact your childcare provider / babysitter if you are going to be later than the time arranged. \nLeave written instructions about any medication needed for your child. \nMake sure that the childcare provider / babysitter knows what rooms the children are sleeping in. \nGive clear instruction on bedtime routines and household rules. \nGive your childcare provider / babysitter your contact number and address if possible where you will be contactable during the evening. \nLeave contact and telephone emergency numbers, and the name and address of the children’s doctor.\nShow the childcare provider / babysitter any fire exit, the location of the fire extinguisher and smoke alarms. \nMake sure that the childcare provider / babysitter gets home safely. " forKey:@"ans"];
     [tmpArr addObject:tmpDict4];
     
     
     [faqArr addObject:tmpArr];
     
     }
     
     
     - (void) prepareDataSourceForTopChildminderFacts {
         
         NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
         NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
         [tmpDict setObject:@"What is a Childminder?" forKey:@"ques"];
         [tmpDict setObject:@"A childminder is a person who singlehandedly minds children in his/her own home." forKey:@"ans"];
         [tmpArr addObject:tmpDict];
         
         NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
         [tmpDict1 setObject:@"What is a HSE notified Childminding Service?" forKey:@"ques"];
         [tmpDict1 setObject:@"The HSE describe a 'childminding' service in the Child Care (Pre-School Services) (No 2) Regulations 2006 as a preschool service, which may include an overnight service, offered by a person who single-handedly takes care of pre-school children, including the childminder's own children, in the childminder's home for a total of more than 2 hours per day, expect where the exemptions provided in Section 58 of the Child Care Act 1991 apply." forKey:@"ans"];
         [tmpArr addObject:tmpDict1];
         
         NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
         [tmpDict2 setObject:@"What is a HSE notified Childminder?" forKey:@"ques"];
         [tmpDict2 setObject:@"A HSE notified childminder is a childminder who is required to notify the HSE of their childminding service." forKey:@"ans"];
         [tmpArr addObject:tmpDict2];
         
         NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
         [tmpDict3 setObject:@"How many children can a Childminder take care of?" forKey:@"ques"];
         [tmpDict3 setObject:@"A childminder (a person who provides a childminding service) should look after not more than 5 pre-school children including his/her own pre-school children\nNo more than two children should be less than 15 months. Exceptions can be made if the children under 15 months are the result of multiple births e.g. triplets or if the children under 15 months are siblings." forKey:@"ans"];
          [tmpArr addObject:tmpDict3];
          
          NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
          [tmpDict4 setObject:@"What you might ask a potential childminder" forKey:@"ques"];
          [tmpDict4 setObject:@"Many parents like the personal care offered by a childminder, whether in their home with a handful of other children, or minded in your own house.\nChildminders can and do get ill, which means you could get a phone call some morning telling you that they are not well. If a childminder comes to your home, most will happily care for a sick child as part of their job, which means no interruption to your work schedule. \nThe guidelines for hiring a childminder are the same whether you plan to drop off your child in their house or expect them to come to your home." forKey:@"ans"];
          [tmpArr addObject:tmpDict4];
          
          NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
          [tmpDict5 setObject:@"View the Childminders home" forKey:@"ques"];
          [tmpDict5 setObject:@"You want to find a friendly, organised, trustworthy individual that your child will feel content and secure with. Parents move on from childminders all the time (changing job, starting maternity leave, child starting school, etc), which means there's often an experienced childminder out there looking for a new job and at MindMe.ie you're sure to find the right one." forKey:@"ans"];
          [tmpArr addObject:tmpDict5];
          
          NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
          [tmpDict6 setObject:@"Make a shortlist of local minders and arrange to meet them." forKey:@"ques"];
          [tmpDict6 setObject:@"If a childminder will be looking after your child in their home, ask to visit when they are minding children. This will give you a good sense of how they interact with the kids and whether the other children seem happy and relaxed. Also look at their hygiene and security. Finding the right childminder is key to your child's wellbeing so don't be shy about asking questions. Ask about qualifications, such as first aid and childcare studies, or they Tusla registered and what motivated them to become a childminder. \nChildminders can and do get ill, which means you could get a phone call some morning telling you that they are not well. If a childminder comes to your home, most will happily care for a sick child as part of their job, which means no interruption to your work schedule. \nA good childminder will have a routine that encompasses lots of varied activities. Find out what a typical day is. Establish how they manage holidays. Before hiring a childminder, watch how they interact with your child. If you're happy then follow up on references and registration." forKey:@"ans"];
          [tmpArr addObject:tmpDict6];
          
          NSMutableDictionary* tmpDict7 = [[NSMutableDictionary alloc] init];
          [tmpDict7 setObject:@"Essential questions " forKey:@"ques"];
          [tmpDict7 setObject:@"Are you registered?\n\nCan I see the playroom; sleep room and outdoor play space?\n\nAre you fully insured to mind children, both in the home and on outings?\n\nWhat would you do in an emergency involving yourself or one of the children?\n\nAre you Garda vetted? (It's free and a legal requirement for those minding four or more.)" forKey:@"ans"];
          [tmpArr addObject:tmpDict7];
          
          [faqArr addObject:tmpArr];
          
          }
          
          - (void) prepareDataSourceForCostofChildcare {
              
              NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
              NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
              [tmpDict setObject:@"MindMe.ie finds out how much childcare actually cost’s in Ireland?" forKey:@"ques"];
              [tmpDict setObject:@"The cost of hiring childminders, nannies and Au Pairs can vary depending on what part of the country you live in. Through research and experience, Dublin and Cork (city and suburbs) are pretty much on the same par when it comes to childcare costs, with the midlands coming in as the least expensive region. Of course there are other factors that affect the rate that a childminder charges or how much a nanny is paid, such as: qualifications, experience, food supplied by the childminder etc." forKey:@"ans"];
               [tmpArr addObject:tmpDict];
               
               NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
               [tmpDict1 setObject:@"Childminders" forKey:@"ques"];
               [tmpDict1 setObject:@"A childminder is a person who cares for children in their own home independently and can often care for several children. However guidelines must be met regarding ratios, for example: a childminder can mind up to 8 children including her own but only 5 preschool children. There should be no more than 2 toddlers/babies under 15 months, including the childminders own children. (Exceptions are made for twins). \n\nIn Dublin, Cork and most of the urban areas in Galway and Limerick , a Full time Childminder will cost approx €5-€8.50 per hour, daily rate €50 for one child\n\n• Part time / after school (incl. school collections) €5-€6.50 ph., daily rate €25\n• For a second child (sibling), most childminders offer a discount bringing the hourly rate to €8 to €10per hour.\n• A lot of childminders provide food and of course a lot don’t, there is no general rule of thumb but you should expect to pay more for a childminder who provides meals or snacks.\n• Childminders should be paid 52 weeks of the year and for bank holidays unless there is an extended break, e.g. families who don’t require their childminder for the summer months.\n• Childminders are self-employed and are therefore responsible for paying their own taxes.\n• Some childminders charge minimum wage of €9.25\nIn other parts of the country, child-minding rates can be slightly less:\n• Full time €5 per hour, however a set daily rate of €40 for one child is more common\n• Part time / after school (incl. school collections), €5 ph. daily rate €15-€20\n• Sibling discounts/rate for two children are generally €7-€7.50 per hour for two children\n• Some childminders may charge less and often families offer less but I would be reluctant to advocate this" forKey:@"ans"];
               [tmpArr addObject:tmpDict1];
               
               NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
               [tmpDict2 setObject:@"Nanny" forKey:@"ques"];
               [tmpDict2 setObject:@"A nanny is a carer who works in the family home and is therefore your employee so you must pay all relevant tax and social contributions and at least the minimum wage should be paid. It is always best to discuss salary in terms of gross pay. A full time nanny generally works Monday to Friday, 8am to 6pm. Any extra hours, overtime and additional babysitting is not included within their weekly wage. Rates vary depending on the nanny’s experience, how many children are in your family, the nanny’s qualification and location.\n\nIn Dublin, Cork and some parts of Galway, a nanny’s salary is the following: (guideline only) \n\n• Full time €10 – €15 per hour, €500-€800 gross per week\n• Part time €12 – €15 per hour, €280 – €375 gross per week (22 hour week) \n• Nannies are paid 52 weeks of the year and are entitled to statutory holidays\n• Nannies should hold a childcare certificate, minimum Fetac 5 and first aid. Many nannies with years of experience can obtain higher salaries\nIn other parts of the country, again the rates of pay are sometimes slightly less: (guideline only) \n• Full time €9.25 – €12 per hour, €400 – €480 gross per week\n• Part time €10 per hour" forKey:@"ans"];
               [tmpArr addObject:tmpDict2];
               
               NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
               [tmpDict3 setObject:@"Au Pair" forKey:@"ques"];
               [tmpDict3 setObject:@"If you're considering hiring an au pair an au pair one of the first things you’ll want to know is, what is a typical au pair salary and what are au pair costs, it’s also the question we get asked most frequently. \n\nSo, what are standard au pair wages?\nA recent court case has determined that au pairs should be regarded as employees, they are therefore legally entitled to the minimum wage. The current minimum wage stands as follows: \n\nExperienced adult worker\n€9.25 Minimum hourly rate of pay\n100% of minimum wage\n\n\nAged under 18\n€6.48 Minimum hourly rate of pay\n70% ofminimum wage\n\nFirst year from date of first employment aged over 18\n€7.40 Minimum hourly rate of pay\n80% of minimum wage\n\nSecond year from date of first employment aged over 18\n€8.33 Minimum hourly rate of pay\n90% of minimum wage" forKey:@"ans"];
               [tmpArr addObject:tmpDict3];
               
               NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
               [tmpDict4 setObject:@"Rates on or after 1 January 2017" forKey:@"ques"];
               [tmpDict4 setObject:@"The cost, per hour, for live in and live out au pairs is the same, however you may make the deductions, listed below to a live in au pair’s wages to cover food and board. \n• €54.13 for full board and lodgings per week, or €7.73 per day\n• €32.14 for full board only per week, or €4.60 per day\n• €21.85 for lodgings only per week, or €3.14 per day\n" forKey:@"ans"];
               [tmpArr addObject:tmpDict4];
               
               [faqArr addObject:tmpArr];
               
               }
               
               - (void) prepareDataSourceForElderlyCare {
                   
                   NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
                   NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
                   [tmpDict setObject:@"Senior / Elderly Care Guide" forKey:@"ques"];
                   [tmpDict setObject:@"Find the elderly care your loved ones deserve on MindMeCare.ie Whether it's your mother or father needing a helping hand, your sister recovering from a serious illness, your husband or wife showing signs of dementia or your grandmother who recently had a fall, you realize that you are now in need of a caregiver." forKey:@"ans"];
                   [tmpArr addObject:tmpDict];
                   
                   NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
                   [tmpDict1 setObject:@"Where do you start?" forKey:@"ques"];
                   [tmpDict1 setObject:@"MindMeCare.ie is a subscription service which allows you gain access to our extensive database of Carers. You can also advertise for free to evaluate if your ‘Carer position’ attracts candidates and only subscribe should you wish to make contact." forKey:@"ans"];
                   [tmpArr addObject:tmpDict1];
                   
                   NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
                   [tmpDict2 setObject:@"Safe and secure" forKey:@"ques"];
                   [tmpDict2 setObject:@"When you find a caregiver you would like to explore further. Simply use the MindmeCare.ie secure private messaging system. This allows you to ask questions and to request more information. \nOne thing that does help is to have a plan. You'll become familiar with the various types of care that can support and assist you and your loved ones, figure out what best suits your needs and know the right questions to ask. \nIt’s completely natural to have concerns about the care of parents, grandparents and loved ones as they reach old age. It is also completely normal to feel worried, stressed and even overwhelmed when considering what your care options are, ultimately you just want the best possible care for your loved one." forKey:@"ans"];
                   [tmpArr addObject:tmpDict2];
                   
                   NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
                   [tmpDict3 setObject:@"Housing & Care" forKey:@"ques"];
                   [tmpDict3 setObject:@"Our needs as humans are continuously changing, from the moment we’re born, to the end of our days. Where we live in the independent phase of our lives may not be where we live as we get older and of course our personal needs also become heightened. If you are looking for answers to the questions, “Where is mum going to live?” or “Who is going to help care for dad during the times we cannot?” then MindMeCare.ie can hopefully help. There are many possible candidates listed on MindMeCare. Explore the options here and talk over the possibilities with your elderly loved ones." forKey:@"ans"];
                   [tmpArr addObject:tmpDict3];
                   
                   NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
                   [tmpDict4 setObject:@"Hiring an Elderly Caregiver" forKey:@"ques"];
                   [tmpDict4 setObject:@"If hiring a senior caregiver on your own, use the following interview questions to narrow down the prospective candidates. First screen your applicants over the phone, then meet in person (likely a public meeting place). If they feel like a good fit for you, you will need to introduce the potential caregiver to your parent or grandparent." forKey:@"ans"];
                   [tmpArr addObject:tmpDict4];
                   
                   NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
                   [tmpDict5 setObject:@"Questions You May Want To Ask" forKey:@"ques"];
                   [tmpDict5 setObject:@"Do you have a full clean driver's license? \nDo you have reliable transportation and insurance? \nHow far from our elderly loved one do you live? \nWhat other responsibilities do you have? \nAre you flexible time wise ? \nWill other commitments you have affect you if I'm delayed getting home? \nWould you be available for respite care, or to stay over for a weekend? \nDo you smoke? (Many people say they don't smoke but they do, -offer them an outside smoking area and insist it be used).\nWhat caregiving qualifications / training do you have, if any? \nDo you have any first-aid training? \nHere is a list of expected elderly caregiving related duties. Is there anything on the list that poses a problem or concern? \nAre you comfortable with pets? \nAre you comfortable with my (grandparent/parent/spouse) having guests or other family members stopping by?\nWhen are you available to start working? After a 30-day trial period, would you be willing to commit to a long-term commitment? \nHave you ever cared for someone with (conditions relatable to your loved one's care: memory problems, elderly, wheelchair bound, etc.) before? If so, please elaborate \nAre you willing to sign a contract stating you will not accept money or gifts from my (parent/grandparent/spouse, etc) without clearing it with me?\nAre you willing to sign a declaration that you will not have guests come into our home unless I have given prior approval? \nWould you be comfortable driving my parent’s car if need be, or using your own car if we request it? \nWhat are your expectations for time off? \nAre you willing to submit to a background check? Note: We suggest that your candidate be Garda vetted and you check the certification." forKey:@"ans"];
                   [tmpArr addObject:tmpDict5];
                   
                   NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
                   [tmpDict6 setObject:@"Create possible scenarios:" forKey:@"ques"];
                   [tmpDict6 setObject:@"Ask the prospective caregiver how they would handle various care issues that could arise. \nFor instance. How would you handle it if my mother wakes up and is extremely irritable and doesn't want to get dressed, but she has a medical appointment later that morning? \nIf my father appears to have a fever and is acting lethargic and you think there's blood in his urine, what would you do? \nIf I can’t be reached, what would you do then? \nIf my Grand Dad falls, seems confused, doesn't recognize you and won't let you help him and he's argumentative, what do you do? \nOnce you have hired someone and have all of the documentation and paperwork sorted out, it helps to have a detailed plan for the first week to ensure a smooth transition." forKey:@"ans"];
                   [tmpArr addObject:tmpDict6];
                   
                   NSMutableDictionary* tmpDict7 = [[NSMutableDictionary alloc] init];
                   [tmpDict7 setObject:@"Home Safety Tips for Seniors" forKey:@"ques"];
                   [tmpDict7 setObject:@"Due to the growing popularity of in-home care for seniors, it's important to make sure you and your loved one are aware of the potential dangers present in the home for seniors living alone and prepare accordingly. You can help prevent falls and accidents by making changes to unsafe areas in the home with these tips." forKey:@"ans"];
                   [tmpArr addObject:tmpDict7];
                   
                   NSMutableDictionary* tmpDict8 = [[NSMutableDictionary alloc] init];
                   [tmpDict8 setObject:@"GENERAL HOME SAFETY" forKey:@"ques"];
                   [tmpDict8 setObject:@"The following home safety tips can help keep you and your loved ones safe:\nConsider a medical alert system.\nKeep a fire extinguisher and smoke detector on every floor.\nNever smoke when alone or in bed.\nAlways get up slowly after sitting or lying down. Take your time, and make sure you have your balance.\nWear proper fitting shoes with low heels.\nUse a correctly measured walking aid.\nRemove or secure all scatter rugs.\nRemove electrical or telephone cords from traffic areas.\nAvoid using slippery wax on floors.\nWipe up spills promptly.\nAvoid standing on ladders or chairs.\nHave sturdy rails for all stairs inside and outside the house, or, if necessary, purchase a stairlift.\nUse only non-glare 100 watt or greater incandescent bulbs \nMake sure that all stair cases have good lighting with switches at top and bottom.\nMake sure that staircase steps have a non-slip surface." forKey:@"ans"];
                   [tmpArr addObject:tmpDict8];
                   
                   NSMutableDictionary* tmpDict9 = [[NSMutableDictionary alloc] init];
                   [tmpDict9 setObject:@"BATHROOM SAFETY" forKey:@"ques"];
                   [tmpDict9 setObject:@" Leave a light on in your bathroom at night.\nUse recommended bath aids, securely installed on the walls of the bath/shower cubicle and by the sides of the toilet.\nMake sure the bath matt has a non-slip bottom.\nMark cold and hot taps clearly.\nMake sure door locks can be opened from both sides." forKey:@"ans"];
                   [tmpArr addObject:tmpDict9];
                   
                   NSMutableDictionary* tmpDict10 = [[NSMutableDictionary alloc] init];
                   [tmpDict10 setObject:@"KITCHEN SAFETY" forKey:@"ques"];
                   [tmpDict10 setObject:@" Keep floors clean and uncluttered.\nMark \"on\" and \"off\" positions on appliances clearly with bright colours.\nStore sharp knives in a knife rack.\nUse a kettle with an automatic shut-off.\nAvoid wearing long, loose clothing when cooking over the oven/hob.\nMake sure food is rotated regularly and check expiry dates." forKey:@"ans"];
                   [tmpArr addObject:tmpDict10];
                   
                   NSMutableDictionary* tmpDict11 = [[NSMutableDictionary alloc] init];
                   [tmpDict11 setObject:@"MEDICINE SAFETY" forKey:@"ques"];
                   [tmpDict11 setObject:@"Review your medicines frequently with your doctor or pharmacist .\nMake sure medicines are clearly labelled.\nRead medicine labels in good light to ensure you have the right medicine and always take the correct dose.\nDispose of any old or used medicines.\nHave medication dispensed in a convenient dispenser." forKey:@"ans"];
                   [tmpArr addObject:tmpDict11];
                   
                   
                   [faqArr addObject:tmpArr];
                   
               }
               
               - (void) prepareDataSourceForElderlyCareTopTips {
                   
                   NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
                   NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
                   [tmpDict setObject:@"Home Safety For The Elderly in Ireland" forKey:@"ques"];
                   [tmpDict setObject:@"Each year in Ireland 1 in 3 people aged 65 and over are victims of falls. Falls are estimated to generate healthcare costs of around €500 million annually, in Ireland alone. Falls in the aged population leads to an added risk of hospitalisations and are known to hasten declining health and increase mortality rates. However, there are more than just physical injuries. The psychological impact of a fall can lead to depression, anxiety, feelings of isolation and burden. The good news is that many of these falls can be prevented.\n\nHere is a checklist for securing the home. The aim is to help older people to create a safe environment while preserving their independence and feelings of well-being." forKey:@"ans"];
                   [tmpArr addObject:tmpDict];
                   
                   NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
                   [tmpDict1 setObject:@"General Safety Tips" forKey:@"ques"];
                   [tmpDict1 setObject:@"Remove any throw rugs. If they must stay; use a double-sided tape to secure mats to the floor.\n\n• Night lights are perfect for darker rooms\n• Rope lighting is a fantastic option for use in hallways that connect the bathroom, kitchen, and bedroom. \n• Organisation is essential to prevent dangerous clutter. \n• Use a \"clapper\" device to control lamps or consider motion-activated lighting or install a remote control switch. \n• Install new batteries each year for smoke detectors. \n• Medications should be stored in cabinets which are easy to access. A cabinet that is too high or too low could cause accessibility problems. \n• Use a medication organiser. " forKey:@"ans"];
                   [tmpArr addObject:tmpDict1];
                   
                   NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
                   [tmpDict2 setObject:@"Bedroom Safety Checklist" forKey:@"ques"];
                   [tmpDict2 setObject:@"• Make sure that all necessities are within reach. \n• Remove any clutter. \n• Make sure that the bed and chairs are the right height. Feet should touch the floor when sitting on the bed or chair." forKey:@"ans"];
                   [tmpArr addObject:tmpDict2];
                   
                   NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
                   [tmpDict3 setObject:@"Bathroom Safety Checklist" forKey:@"ques"];
                   [tmpDict3 setObject:@"• Add grab bars near the toilet, shower, and in the bath. \n• Place a rubber mat in the bottom of the bath. \n• Make sure the bathtub or shower is not too high. Consider installing walk-in models. \n• Add a raised seat for toilet stools. \n• Set the water thermostat so that water does not reach uncomfortable or dangerous temperature levels. \n• Make sure the water faucets are clearly labelled ‘hot and cold.’" forKey:@"ans"];
                   [tmpArr addObject:tmpDict3];
                   
                   NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
                   [tmpDict4 setObject:@"Kitchen Safety Checklist" forKey:@"ques"];
                   [tmpDict4 setObject:@"• Move items to shelves closest to counter height. \n• Use hooks for storage and accessibility to the most often used pots and pans. \n• Increase light brightness by adding more light or higher wattage bulbs. \n• Clearly, label household cleaning supplies that may pose a danger to older people. \n• Consider upgrading the flooring to a non-slip surface. \n\nFinally, don’t forget that there are dangers of eating spoiled or outdated food. Chief among these dangers is food poisoning. Remember to go through their refrigerator each week. And inspect dates on perishable food items like meat, eggs, and dairy." forKey:@"ans"];
                   [tmpArr addObject:tmpDict4];
                   
                   [faqArr addObject:tmpArr];
                   
               }
               
               - (void) prepareDataSourceForAuPairs {
                   
                   NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
                   NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
                   [tmpDict setObject:@"Au Pair" forKey:@"ques"];
                   [tmpDict setObject:@"Typically an au pair is a young, single person from overseas who wants to come to Ireland to learn English and live as a member of an Irish family.\nAu pairs can be expected to do a combination of childcare and light housework duties in exchange for board and an allowance. In Ireland, au pairs from outside the EU must have a Working Holiday Visa, placements usually last six months to comply with visa restrictions and leaves a few months at the end of the trip for the au pair to travel.\nIt is important to note that au pairs are not trained nannies and may have little or no training in childcare. They should not be left in sole charge of babies younger than 12 months. However, once both the parents and the au pair have confidence in the arrangement children older than 12 months can be looked after for a few hours at a time.\nIn families with school-aged children, au pairs are mostly used for before and after school care. Where there are young children in the family the au pair may also work a few hours during the day." forKey:@"ans"];
                   [tmpArr addObject:tmpDict];
                   
                   NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
                   [tmpDict1 setObject:@"Daily Responsibilities" forKey:@"ques"];
                   [tmpDict1 setObject:@"The responsibilities of an au pair will depend on the age of the children and the nature of the household and a daily timetable should be worked out to take into account time commitments on both sides of the relationship. More than 80 per cent of the au pair’s daily tasks should revolve around the direct care of the children in the family and the remaining 20 per cent can be used for light housekeeping duties.\nWhile each family will have a different schedule a typical daily timetable for an au pair might look something like this:\nWake children in the morning\nHelp the children wash and dress for school or day care\nHelp children make their bed and clean their room\nPrepare breakfast for the children\nPrepare lunches for the children\nDrive children to school or day care\nWhile children are at school complete light household tasks such as children’s laundry or weekly vacuuming\nPick up children from school\nPrepare a healthy afternoon snack for the children\nDrive the children to after school activities and pick them up\nHelp the children with their homework\nBathe the children and get them ready for bed\nAu pairs should be given time every day to study and pursue their own interests they should also be given a set amount of time off work each week. In Ireland, the most common arrangement is for au pairs to work 30 to 35 hours per week with weekends off work. When a family asks their au pair to work a Saturday, she (or he) should be given the following Monday off work in lieu." forKey:@"ans"];
                   [tmpArr addObject:tmpDict1];
                   
                   NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
                   [tmpDict2 setObject:@"Settling In" forKey:@"ques"];
                   [tmpDict2 setObject:@"When considering the possibility of taking in an au pair it is important to see the placement as a cross cultural experience which will be of benefit to the whole family. If you are simply looking for help around the house then an au pair is not the right choice to make.\nThe initial settling in period is a very important time for both the family and the au pair. Au pairs are often young and away from home for the first time. They are not trained house cleaners or nannies and may feel lonely and uncomfortable in the first few weeks.\nTo make this period as easy as possible, your au pair should be welcomed from the outset and included in as many family activities as possible. Be prepared to spend plenty of time in the first weeks helping your au pair become accustomed to life in their new home this may include:\nMaking the au pair feel comfortable by creating an occasion of their arrival\nMaking the au pair’s room pleasant and welcoming. \nGiving a tour of the house and clearly explaining house rules\nProviding clear instructions about the au pair’s duties and offer feedback\nOffering friendship and patience as the au pair becomes familiar with their new life\nAn important part of ensuring that your relationship with your au pair is successful is to treat them as an addition to the household. The success of the arrangement relies on flexibility and goodwill on both sides. \nYour au pair has come to Ireland to experience a new culture and improve their language skills and will appreciate being spoken to in English and having their mistakes explained. It is a relationship which will strengthen in an environment of openness and understanding.\nUse the MindMeCare.ie handy search service to find an au pair in your area. " forKey:@"ans"];
                   [tmpArr addObject:tmpDict2];
                   
                   NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
                   [tmpDict3 setObject:@"A Note on Demi Pairs" forKey:@"ques"];
                   [tmpDict3 setObject:@"Demi pairs are young people from overseas who attend language classes during the day as such they have less time to assist with child care and more basic language skills. Typically demi pairs help families with older children with after school care (from 3:00pm until 7:00pm).\nResponsibilities may include\nPicking children up from school\nDriving children to their after school activities\nPreparing afternoon snacks\nHelping children with homework\nPreparing and serving children’s dinner\nBathing children and preparing them for bed\nDemi pairs work a maximum of 20 hours per week and usually they only take four to six month placements with families because of their language courses. In Ireland, demi pairs are currently only available in the major cities." forKey:@"ans"];
                   [tmpArr addObject:tmpDict3];
                   
                   
                   [faqArr addObject:tmpArr];
                   
               }
               
               
               - (void) prepareDataSourceForPetCare {
                   
                   NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
                   NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
                   [tmpDict setObject:@"The Pet Guide: Pet Care Options" forKey:@"ques"];
                   [tmpDict setObject:@"Find the very best pet care on MindMe.ie Ireland’s largest Care Website. \nMost pet owners have to deal with the reality of pet care as soon as they come home with their new friend. So for you new pet owners, here are some of the popular pet care options you can expect." forKey:@"ans"];
                    [tmpArr addObject:tmpDict];
                    
                    NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
                    [tmpDict1 setObject:@"Dog Walking" forKey:@"ques"];
                    [tmpDict1 setObject:@"Having someone come to walk the dog, give him water, and keep him company is the obvious first choice for many. Through a service like MindMe.ie, it's easy to find pet care. Someone nearby can always come walk your dog for an hour at lunch for anywhere between €10 and €15 a day, depending on where you live. \nDifferent parts of the country will have different rates--the cost of Dublin Pet Care may be different than the cost of Cork Pet Care. It's simple once you get over the idea of a stranger in your house when you're not home and of giving them a set of your keys if that is the option you go for. \nPet caregivers who come to your home to care for your dogs or cats or lizards!! may also charge by the hour or by the job depending on the type of care needed. \nObviously most dog walkers charge an increased fee to come more than once a day. For people who are frequently away on weekends for conferences, you need to find a person who will look after your dog in your own home or alternatively in their home. There are also numerous boarding kennels throughout the country." forKey:@"ans"];
                    [tmpArr addObject:tmpDict1];
                    
                    NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
                    [tmpDict2 setObject:@"Dog and Cat Day Care" forKey:@"ques"];
                    [tmpDict2 setObject:@"There are centres particularly in urban areas that provide dog and cat day care. They will look after your pooch while you go about you daily chores. As with all care – choose carefully.\nWhichever pet care option(s) you choose, make sure they meet and anticipate your needs (and your pet's) in the long term. If you live in an urban area, pet will be readily available but at If you live in the suburbs or a more rural area, expect to have to hunt a bit more for pet care options, but once found, you'll most likely pay less for that pet care than you would in the city.\nNo matter where you live, however, remember that pets are more affected by change than humans, and need routine and structure to be the happy and healthy. Their behaviour will depend on the regularity of care and number of caregivers." forKey:@"ans"];
                    [tmpArr addObject:tmpDict2];
                    
                    
                    [faqArr addObject:tmpArr];
                    
                    }
                    
                    
                    - (void) prepareDataSourceForHousekeepers {
                        
                        NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
                        NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
                        [tmpDict setObject:@" " forKey:@"ques"];
                        [tmpDict setObject:@"Reasons to hire a Housekeeper in your local area \n\nYour life is busy enough. Hire a cleaner or housekeeper to help out." forKey:@"ans"];
                        [tmpArr addObject:tmpDict];
                        
                        NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
                        [tmpDict1 setObject:@"Housekeeper" forKey:@"ques"];
                        [tmpDict1 setObject:@"If you've ever debated hiring a housekeeper, you have probably come up with a list of reasons why you shouldn't: it's a luxury or you can't afford it or it's a sign of laziness. \nHowever have you ever thought about why you should? \nGetting a housekeeper is a way to manage your time more efficiently and it can be very affordable. \nWhether you're busy with a family and career, or just want some occasional help around the house, getting a housekeeper is very practical. \nHere are some reasons you may need to hire some help. " forKey:@"ans"];
                        [tmpArr addObject:tmpDict1];
                        
                        NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
                        [tmpDict2 setObject:@"You Work Full Time" forKey:@"ques"];
                        [tmpDict2 setObject:@"After a busy 9-5, day using your time away from work to clean the house reduces your energy and limits your time to enjoy other activities. You might not need a housekeeper every day, but having someone clean once or twice a month will give you more time to do the things you enjoy." forKey:@"ans"];
                        [tmpArr addObject:tmpDict2];
                        
                        NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
                        [tmpDict3 setObject:@"You Enjoy Entertaining" forKey:@"ques"];
                        [tmpDict3 setObject:@"Whether you're putting on a large event or just having company over, wouldn’t it be nice to leave the cleaning to someone else. Even if you're just having people over for dinner or to spend the weekend, knowing your housecleaning is taken care of takes the load off pressure and work of you, and leaves you time to enjoy the visit." forKey:@"ans"];
                        [tmpArr addObject:tmpDict3];
                        
                        NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
                        [tmpDict4 setObject:@"You Don’t Know How to Clean" forKey:@"ques"];
                        [tmpDict4 setObject:@"Remember when your mum tried to teach you how to clean? Good. Now, do you really remember anything she actually said? We didn't think so. Cleaning isn't as easy as just turning on a vacuum. There are tips and tricks you learn with time or experience. Hire a housekeeper to show you. She can clean it a few times and demonstrate the best methods. But be careful; you may like just having her do it -- and that's okay too!" forKey:@"ans"];
                        [tmpArr addObject:tmpDict4];
                        
                        NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
                        [tmpDict5 setObject:@"You Don’t Like Cleaning" forKey:@"ques"];
                        [tmpDict5 setObject:@"Who does? But some people are better at it than others. Just because cleaning isn't your forte, doesn't mean you're lazy. Why waste your time and efforts doing something you're not good at, when you can have someone else do it? If cleaning takes you hours and you hate every minute of it, hire a housekeeper and devote that time to something more productive." forKey:@"ans"];
                        [tmpArr addObject:tmpDict5];
                        
                        NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
                        [tmpDict6 setObject:@"You Have Elderly Family" forKey:@"ques"];
                        [tmpDict6 setObject:@"You might not want or need someone to clean your own home, but your aging parents or other relatives might need help. As people get older, it becomes harder to take care of daily housekeeping tasks. A disorderly home is a health hazard for the elderly. A cluttered floor can cause them to fall and eating from dirty dishes can make them ill.\nIf your aging parents need more help than just cleaning, hire an elderly care aide who can care for them, run errands and provide other duties around the home." forKey:@"ans"];
                        [tmpArr addObject:tmpDict6];
                        
                        NSMutableDictionary* tmpDict7 = [[NSMutableDictionary alloc] init];
                        [tmpDict7 setObject:@"You Have a New Baby" forKey:@"ques"];
                        [tmpDict7 setObject:@"A new baby in the house means lots of extra cleaning and laundry, more than exhausted new parents may be able to handle. A housekeeper can help pick up the slack while you get used to your new routine." forKey:@"ans"];
                        [tmpArr addObject:tmpDict7];
                        
                        NSMutableDictionary* tmpDict8 = [[NSMutableDictionary alloc] init];
                        [tmpDict8 setObject:@"Find the perfect Cleaner / Housekeeper" forKey:@"ques"];
                        [tmpDict8 setObject:@"MindMeCare.ie can take all the hassle and stress out of finding a good cleaner or housekeeper. So if you're looking for a dedicated domestic goddess to clean and care for your home, why not just register with MindMeCare.ie and search for the Cleaner / Housekeeper you need you need? \n\nWhether you want a house cleaner or house keeper to organize or deep clean your home, MindMeCare.ie have got the cleaner for you! With MindMeCare.ie you can find yourself a cleaner nationwide for a one-off, weekly or a fortnightly clean. Find a Cleaner or Housekeeper for any of the following.\n\n•	Ironing\n• Organizing\n• Deep clean\n• Student digs cleaning\n• Maintenance\n• Moving house\n• Bathroom cleaning\n•	Oven cleans\n•	End of tenancy\n• Floor cleaning\n• Mopping\n• Airbnb cleaning\n\nThe cost of housekeeping services can be based on a variety of factors and varies from one area to another. \nIt is necessary to have an in-home consultation with your prospective cleaner, so they can get a better understanding of the home, the cleaning requirements and exactly what you're expecting them to do.\nHere are some factors you should look and consider when deciding how much to pay for housekeeping.\nSize of the home (number of bedrooms/bathrooms) \nFrequency of cleaning (weekly, bimonthly) \nNumber of people and pets in the household \nLevel of clutter \nNumber of different surfaces to be cleaned \nSpecial requirements, such as cleaning windows \nWhether you will be paying by the job or by the hour " forKey:@"ans"];
                        [tmpArr addObject:tmpDict8];
                        
                        NSMutableDictionary* tmpDict9 = [[NSMutableDictionary alloc] init];
                        [tmpDict9 setObject:@"Get Estimates" forKey:@"ques"];
                        [tmpDict9 setObject:@"Look at other housekeepers and cleaners in your area on MindMeCare.ie. What do they charge? Ask people you know who have hired a cleaning service about how much they paid. \nOnce you settle on a possible range, be prepared to negotiate with prospective housekeepers in order to arrive at a fair price that reflects what the job entails. " forKey:@"ans"];
                        [tmpArr addObject:tmpDict9];
                        
                        NSMutableDictionary* tmpDict10 = [[NSMutableDictionary alloc] init];
                        [tmpDict10 setObject:@"Want to be a Housekeeper" forKey:@"ques"];
                        [tmpDict10 setObject:@"Whether you want to find full-time work as a housekeeper, or whether you just need a part-time job to supplement your income, there are several things you can do to increase your chances of being hired.\n\nFirst of all, have your CV ready. Outline your past job history and your experience as a housekeeper/Cleaner, even if your experience is limited to managing your own home. Include skills that are relevant to a housekeeping job, such as the ability to work independently, provide a quality service, and work quickly. It would also be important to have references that prospective employers can call. \n\nTo enhance your chances of being hired you can also ’Get Featured’ on www.MindMeCare.ie\n\nWhen interviewing, it would be important to show that you are a friendly person and that you have enough energy to complete the tasks that a housekeeping job requires. Do your best to be cheerful and alert. \n\nOnce you have a housekeeping job, ask for referrals. Often your employer will have friends or family who are looking for help too and could use your services." forKey:@"ans"];
                        [tmpArr addObject:tmpDict10];
                        
                        NSMutableDictionary* tmpDict11 = [[NSMutableDictionary alloc] init];
                        [tmpDict11 setObject:@"As an Employer" forKey:@"ques"];
                        [tmpDict11 setObject:@"Often in life when we are dealing with people we employ to help us in our homes, we don't take the time to be kind, or even respectful. Our excuse is haste, but in so many cases it is a lack of sensitivity, a sense of entitlement or even arrogance.\n\nAll of these attitudes are wrong, especially when they relate to how you treat people who have come to help you. Good relationships are built on mutual respect. Given this, no matter who you are interacting with, they are deserving of decent behaviour on your part. \n\nWhen you hire someone to come into your home to help clean, organize or manage, you expect polite behaviour and an honest effort from them: …you are paying them to do a job. \nTake the time to reflect on pleasantries, and show genuine interest in the person helping you; this can have huge benefits for everyone involved. \nThe cynical among you are saying, “Treat the hired help well and you get more work out of them.\nAt www.MindMeCare.ie we like to think that building a solid, friendly relationship with the people you hire motivates those working for you and creates an environment of common decency. \nIt is these exchanges that set one day apart from the next. It is those opportunities to learn something new about someone, to realize hidden talents or just to have a friendly exchange of words that enrich our lives. The fact that you have the money to hire them and they require the money that you can provide should make no difference in the respect exchanged. \n\nHow many times have you heard or experienced the situation where a person hired to clean in your home has gone above their job description by doing kind 'extras' or helping you in a time of need. " forKey:@"ans"];
                         [tmpArr addObject:tmpDict11];
                         
                         
                         [faqArr addObject:tmpArr];
                         
                         }
                         
                         
                         - (void) prepareDataSourceForChildcareTerms {
                             
                             NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
                             NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc] init];
                             [tmpDict setObject:@"Crèche /Fulltime Day Care: " forKey:@"ques"];
                             [tmpDict setObject:@"The meaning of fulltime Day Care, Crèche or Nursery care effectively means a pre-school service offering structured day care for pre-school children for more than 5 hours per day and which can include a sessional service for pre-school children not attending the full day care option.\nGenerally each facility will be broken down into various rooms e.g. baby room, wobbler room, toddler room, playschool etc and your child should be assessed and assigned a specific room depending on their ability." forKey:@"ans"];
                              [tmpArr addObject:tmpDict];
                              
                              NSMutableDictionary* tmpDict1 = [[NSMutableDictionary alloc] init];
                              [tmpDict1 setObject:@"Baby Room:" forKey:@"ques"];
                              [tmpDict1 setObject:@"A baby room as the name suggests caters for babies ageing approximately 4 months to 1 year old. \nGenerally your child’s day in a baby room should mimic the routine you have at home and should incorporate time for sleep and bottle feeds." forKey:@"ans"];
                              [tmpArr addObject:tmpDict1];
                              
                              NSMutableDictionary* tmpDict2 = [[NSMutableDictionary alloc] init];
                              [tmpDict2 setObject:@"Wobbler Room:" forKey:@"ques"];
                              [tmpDict2 setObject:@"This room is for children who are approximately 1 to 2 years of age. It is the next step up from a baby room. Your child will start in the wobbler room when they start finding their feet. The normal routine of a wobbler room will incorporate meal times, sleep times and play. Children can spend 6 to 9 months in a wobbler room before they make the next step to a toddler room." forKey:@"ans"];
                              [tmpArr addObject:tmpDict2];
                              
                              NSMutableDictionary* tmpDict3 = [[NSMutableDictionary alloc] init];
                              [tmpDict3 setObject:@"Toddler Room:" forKey:@"ques"];
                              [tmpDict3 setObject:@"This room is for children approximately 2 years to 3 years old. Advancing from the wobbler room at the age of 2 your child will be slowly introduced to more advanced learning as well as arts and crafts and a more structured schedule of activities. Staff will work with toilet-training your child when you decide the time is right. Also some toddler rooms have sleep time incorporated in the daily routine." forKey:@"ans"];
                              [tmpArr addObject:tmpDict3];
                              
                              NSMutableDictionary* tmpDict4 = [[NSMutableDictionary alloc] init];
                              [tmpDict4 setObject:@"Part Time Day Care:" forKey:@"ques"];
                              [tmpDict4 setObject:@"This means a pre-school service offering a more structured day care service for pre-school children for a total of more than 3.5 hours and less than 5 hours per day. It can include a sessional pre-school service. The premises must provide the same environment and sanitary facilities as a full day care facility. \nOther services that may be covered by the above definition include pre-schools, playgroups, crèches, Montessori pre-schools, naíonraí, notifiable childminders or services which cater for pre-school children in the up to 6 years of age. \nSome offer a 3 or 4 day week, allowing you to leave your child on a full or part time basis to suit your personal arrangements." forKey:@"ans"];
                              [tmpArr addObject:tmpDict4];
                              
                              NSMutableDictionary* tmpDict5 = [[NSMutableDictionary alloc] init];
                              [tmpDict5 setObject:@"Sessional Care:" forKey:@"ques"];
                              [tmpDict5 setObject:@"’sessional pre-school service’ is a pre-school service offering a programme to pre-school children for a total of no more than 3.5 hours per session." forKey:@"ans"];
                              [tmpArr addObject:tmpDict5];
                              
                              NSMutableDictionary* tmpDict6 = [[NSMutableDictionary alloc] init];
                              [tmpDict6 setObject:@"Drop in care:" forKey:@"ques"];
                              [tmpDict6 setObject:@"You can drop your child in for a period of time if you have something to do. You can get an hourly rate from the premises owner/manager. \nThe following are drop-in care definitions as defined by Irish Regulation for pre-school service in a drop-in centre and in a temporary drop-in centre \n’Pre-school service in a drop-in centre’ means a pre-school service offering day care which is used exclusively on an intermittent basis.\n’Pre-school service in a temporary drop-in centre’ means a pre-school service offering day care exclusively on a temporary basis. \nA pre-school service in a drop-in centre refers to a service where a pre-school child is cared for over a period of not more than two hours while the parent or guardian is availing of a service or attending an event. Such services are mainly located in shopping centres, leisure centres or other establishments as part of customer/client service. \nA pre-school service in a temporary drop-in centre refers to a service where a pre-school child is cared for while the parent or guardian is attending a once-off event such as a conference or a sports event. " forKey:@"ans"];
                              [tmpArr addObject:tmpDict6];
                              
                              NSMutableDictionary* tmpDict7 = [[NSMutableDictionary alloc] init];
                              [tmpDict7 setObject:@"Playschool:" forKey:@"ques"];
                              [tmpDict7 setObject:@"Normally for children of 3 to 4 years of age. Some facilities are playschool only and others incorporate a playschool as part of a larger centre. Similar to a toddler room, your child will be involved in play, arts and crafts and structured meal and sleep time. However, playschool also begins to prepare your child for the move to primary school and all that goes with it." forKey:@"ans"];
                              [tmpArr addObject:tmpDict7];
                              
                              NSMutableDictionary* tmpDict8 = [[NSMutableDictionary alloc] init];
                              [tmpDict8 setObject:@"Montessori:" forKey:@"ques"];
                              [tmpDict8 setObject:@"Caters for children approximately 4 to 5 years of age, Montessori emphasises learning through the five senses, not just through the normal listening, watching, or reading. Children in Montessori classes learn at their own pace and according to their own choice of activities." forKey:@"ans"];
                              [tmpArr addObject:tmpDict8];
                              
                              NSMutableDictionary* tmpDict9 = [[NSMutableDictionary alloc] init];
                              [tmpDict9 setObject:@"Naionra:" forKey:@"ques"];
                              [tmpDict9 setObject:@"Usually for children aged 3 to 5 years of age, who have sessional play in the Irish language with an Irish speaking supervisor. Naionra is preschool learning through the Irish under the guidance of well qualified Irish speaking preschool teachers." forKey:@"ans"];
                              [tmpArr addObject:tmpDict9];
                              
                              NSMutableDictionary* tmpDict10 = [[NSMutableDictionary alloc] init];
                              [tmpDict10 setObject:@"High Scope Childcare:" forKey:@"ques"];
                              [tmpDict10 setObject:@"This is an holistic approach to developmental learning around learning by activity and socialising. Teaching is based on the theory that children learn best through active experiences, the materials they encounter, events they become involved in and ideas they have." forKey:@"ans"];
                              [tmpArr addObject:tmpDict10];
                              
                              NSMutableDictionary* tmpDict11 = [[NSMutableDictionary alloc] init];
                              [tmpDict11 setObject:@"Afterschool Care:" forKey:@"ques"];
                              [tmpDict11 setObject:@"This is care for children of school going age after school has finished or until you have finished your work. It usually incorporates a snack and supervised time to do homework." forKey:@"ans"];
                              [tmpArr addObject:tmpDict11];
                              
                              NSMutableDictionary* tmpDict12 = [[NSMutableDictionary alloc] init];
                              [tmpDict12 setObject:@"Summer Camps:" forKey:@"ques"];
                              [tmpDict12 setObject:@"Day care during the summer holidays for children of school going age, usually activity filled days. Summer camps are generally specific to an activity like GAA, Rugby, or football.\nCommunity Childcare Service: Childcare in your local community for residents usually in a local hall or community centre" forKey:@"ans"];
                              [tmpArr addObject:tmpDict12];
                              
                              NSMutableDictionary* tmpDict13 = [[NSMutableDictionary alloc] init];
                              [tmpDict13 setObject:@"Childminders" forKey:@"ques"];
                              [tmpDict13 setObject:@"Childminders provide a Childcare service in their own homes and are self employed. Childminders cater for children’s physical, educational and emotional needs by providing a warm caring family environment with stimulating play and learning activities. It is the most common form of day care in Ireland with 70% of parents of a pre-school child using a Childminder." forKey:@"ans"];
                              [tmpArr addObject:tmpDict13];
                              
                              
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
