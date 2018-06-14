//
//  ChatStartViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/03/18.
//  Copyright © 2018 Stardeep. All rights reserved.
//

#import "ChatStartViewController.h"
#import "ChooseCareTypeCollectionViewCell.h"

@interface ChatStartViewController ()

@end

@implementation ChatStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self startGetAdvertsService];

}

- (void) setupInitialUI {
    
    _sendButton.layer.cornerRadius = 17.5;
    _sendButton.layer.masksToBounds = NO;
    
    [self.careTypeCollectionView registerNib:[UINib nibWithNibName:@"ChooseCareTypeCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"ChooseCareTypeCollectionViewCell"];
    
    _titleLabel.font =  _messageLabel.font = _selectActiveProfStaticLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(17.5/667)*kScreenHeight];
    
     _selectActiveProfStaticLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(17.5/667)*kScreenHeight];
    
    _messageTextField.font =  _titleTextField.font = _footerLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:(17.5/667)*kScreenHeight];
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    
    selectedCareType = @"";
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        _selectActiveProfStaticLabel.text = @"Select an Active Advert for which you want to start a conversation";
    }
    
    if ([[_advertDict valueForKey:@"first_name"] isEqual:[NSNull null]] && [[_advertDict valueForKey:@"second_name"] isEqual:[NSNull null]]) {
        _headerLabel.text = @".";
    }
    else if ([[_advertDict valueForKey:@"first_name"] isEqual:[NSNull null]]) {
        _headerLabel.text = [NSString stringWithFormat:@"%@.",[[_advertDict valueForKey:@"second_name"] substringToIndex:1]];;
    }
    else if ([[_advertDict valueForKey:@"second_name"] isEqual:[NSNull null]]) {
        _headerLabel.text = [NSString stringWithFormat:@"%@ .",[_advertDict valueForKey:@"first_name"]];
    }
    else {
        _headerLabel.text = [NSString stringWithFormat:@"Send a message to %@ %@.",[_advertDict valueForKey:@"first_name"],[[_advertDict valueForKey:@"second_name"] substringToIndex:1]];
    }
    
    
    [self registerForKeyboardNotifications];
    
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
    
    return allCareTypesArr.count;
    
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
    
    [self populateContentForFirstCollectionViewCell:cell atIndexPath:indexPath];
    
    
    return cell;
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreenWidth-28)/2., 40);
    
    
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
    
    selectedCareType = [[allCareTypesArr objectAtIndex:indexPath.row] valueForKey:@"care_type"];
    [collectionView reloadData];
    [self.view endEditing:YES];
    
}


#pragma mark - Populate Content

- (void) populateContentForFirstCollectionViewCell:(ChooseCareTypeCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = [[allCareTypesArr objectAtIndex:indexPath.row] valueForKey:@"care_type"];
    [cell.titleLabel setFont:_footerLabel.font];
    cell.titleLabel.textColor = _titleTextField.textColor;
    
    if ([[[allCareTypesArr objectAtIndex:indexPath.row] valueForKey:@"care_type"] isEqualToString:selectedCareType]) {
        cell.toggleButton.selected = YES;
    }
    else {
        cell.toggleButton.selected = NO;
    }
    
}


- (IBAction)sendButtonTapped:(id)sender {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        
        
        NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileDetailsCopy"];
        NSMutableDictionary *responseData = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData]];
        
        int mailCounter = [[responseData valueForKey:@"mail_counter"] intValue];
        
        if (mailCounter <= [[responseData valueForKey:@"free_limit"] intValue]) {
            
            mailCounter++;
            [responseData setObject:[NSNumber numberWithInt:mailCounter] forKey:@"mail_counter"];
            NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:responseData];
            [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"profileDetailsCopy"];
            
            [self startSendMessageService];
            
        }
        else {
            
            [self performSegueWithIdentifier:@"showMobileVerificationSegue" sender:nil];
            
        }

    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NSString*) isFormValid {
    if ([_titleTextField.text isEqualToString:@""]) {
        return @"Please enter message title to proceed";
    }
    else if ([_messageTextField.text isEqualToString:@""]) {
        return @"Please enter message to proceed";
    }
    else if ([selectedCareType isEqualToString:@""]) {
        return @"Please select a care type to proceed";
    }
    return nil;
}


#pragma mark - API Helpers

- (void) startGetAdvertsService {
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetPostedAdverts;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForGetPostedAdverts]];
    
}

- (void) startSendMessageService {
    
    [SVProgressHUD showWithStatus:@"Sending Message"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = SendMessage;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForSendMesssage]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:GetPostedAdverts]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Data refreshed successfully"];
        
        if ([[responseData valueForKey:@"message"] isKindOfClass:[NSArray class]]) {
            
            NSMutableArray* tempArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"message"]];
            allCareTypesArr = [[NSMutableArray alloc] init];
            
            for (NSDictionary* tmpDict in tempArr) {
                if ([[tmpDict valueForKey:@"job_ad_active"] intValue] == 1) {
                    [allCareTypesArr addObject:tmpDict];
                }
            }
            
        }
        
        _collectionViewHeightConstraint.constant = (allCareTypesArr.count/2)*40 + (allCareTypesArr.count%2)*40;
        [_careTypeCollectionView reloadData];
        
    }
    if ([requestServiceKey isEqualToString:SendMessage]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Message sent successfully"];
        //[[SharedClass sharedInstance] changeRootControllerForIdentifier:@"AdsHomeViewController" forSideMenuController:self.sideMenuController];
        
        NSMutableArray* navArr = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        [navArr removeLastObject];
        [navArr removeLastObject];
        
        [self.navigationController setViewControllers:navArr animated:YES];
        
        
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

- (NSMutableDictionary *) prepareDictionaryForGetPostedAdverts {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForSendMesssage {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"user_type"];
    }
    else {
        [dict setObject:@"parent" forKey:@"user_type"];
    }
    
    [dict setObject:[_advertDict valueForKey:@"Userid"] forKey:@"Userid"];
    [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"from"];
    [dict setObject:_messageTextField.text forKey:@"message"];
    [dict setObject:[[SharedClass sharedInstance] filterOutMobileAndEmail:_titleTextField.text] forKey:@"message_title"];
    
    if (_isOpenedFromFavorites) {
        [dict setObject:[_advertDict valueForKey:@"advert_id"] forKey:@"refer_id"];
    }
    else {
        [dict setObject:[_advertDict valueForKey:@"ID"] forKey:@"refer_id"];
    }
    
    for (NSMutableDictionary* tmpDict in allCareTypesArr) {
        if ([[tmpDict valueForKey:@"care_type"] isEqualToString:selectedCareType]) {
            [dict setObject:[tmpDict valueForKey:@"ID"] forKey:@"sender_profile_id"];
            break;
        }
    }
    
    return dict;
    
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if ([textView.text containsString:@"Type your Message"]) {
        
        textView.text = @"";
        textView.textColor = [UIColor colorWithRed:108./255. green:140./255. blue:166./255. alpha:1.];
        
    }
    
    return YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - Form scroll for Keyboard Show/Hide


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.contentScrollView.contentInset = contentInsets;
    self.contentScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    /*if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [self.loginScrollView setContentOffset:scrollPoint animated:YES];
    }*/
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.contentScrollView.contentInset = contentInsets;
    self.contentScrollView.scrollIndicatorInsets = contentInsets;
}

@end
