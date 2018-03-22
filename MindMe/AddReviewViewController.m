//
//  AddReviewViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 19/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AddReviewViewController.h"

@interface AddReviewViewController ()

@end

@implementation AddReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _postReviewButton.layer.cornerRadius = 17.5;
    _postReviewButton.layer.masksToBounds = NO;
    
    _reviewTextView.layer.cornerRadius = 5.;
    _reviewTextView.layer.masksToBounds = NO;
    _reviewTextView.layer.borderWidth = 1.0;
    _reviewTextView.layer.borderColor = _reviewTextView.textColor.CGColor;
    
    [_firstStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_secondStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_thordStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_fourthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_fifthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    
    _reviewNameLabel.text = [NSString stringWithFormat:@"Review : %@ %@.",[_advertDict valueForKey:@"first_name"],[[_advertDict valueForKey:@"second_name"] substringToIndex:1]];
    
    _headerLabel.font = [UIFont fontWithName:@"Montserrat-SemiBold" size:(22.5/667)*kScreenHeight];
    _staticLabel1.font = _staticLabel2.font = _reviewNameLabel.font = _reviewTitleTextField.font = [UIFont fontWithName:@"Montserrat-Light" size:(20./667)*kScreenHeight];
    
    _reviewTextView.font = [UIFont fontWithName:@"Montserrat-Light" size:(20./667)*kScreenHeight];
    
    _staticLabel3.font = _reviewTitleStaticLabel.font = _reviewStaticLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:(20./667)*kScreenHeight];
    
    _postReviewButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Medium" size:(20./667)*kScreenHeight];
    
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

- (IBAction)firstStarButtonTapped:(id)sender {
    
    rating = 1;
    
    [_firstStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_secondStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_thordStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_fourthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_fifthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    
}

- (IBAction)secondStarButtonTapped:(id)sender {
    
    rating = 2;
    
    [_firstStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_secondStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_thordStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_fourthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_fifthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    
}

- (IBAction)thirStarButtonTapped:(id)sender {
    
    rating = 3;
    
    [_firstStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_secondStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_thordStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_fourthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [_fifthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    
}

- (IBAction)fourthStarButtonTapped:(id)sender {
    
    rating = 4;
    
    [_firstStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_secondStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_thordStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_fourthStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_fifthStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    
}

- (IBAction)fifthStarButtonTapped:(id)sender {
    
    rating = 5;
    
    [_firstStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_secondStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_thordStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_fourthStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    [_fifthStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateNormal];
    
}

- (IBAction)backButtonTapped:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)postReviewButtonTapped:(id)sender {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        [self startReviewService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }
    
}

- (NSString*) isFormValid {
    if (rating == 0) {
        return @"Please give at least one star to proceed";
    }
    else if ([_reviewTitleTextField.text isEqualToString:@""]) {
        return @"Please enter review title to proceed";
    }
    else if ([_reviewTextView.text isEqualToString:@""]) {
        return @"Please enter review description to proceed";
    }
    return nil;
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField == _reviewTitleTextField) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField == _reviewTitleTextField) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView == _reviewTextView && [textView.text containsString:@"Please ensure your review is correct"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (textView == _reviewTextView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -200., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView == _reviewTextView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +200., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) startReviewService {
    
    [SVProgressHUD showWithStatus:@"Updating review"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = ReviewAdvert;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForReview]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:ReviewAdvert]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Review updated successfully"];
        
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

- (NSMutableDictionary *) prepareDictionaryForReview {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"carerid"];
        [dict setObject:[_advertDict valueForKey:@"Userid"] forKey:@"parentid"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"parentid"];
        [dict setObject:[_advertDict valueForKey:@"Userid"] forKey:@"carerid"];
    }
    
    [dict setObject:[_advertDict valueForKey:@"ID"] forKey:@"advertid"];
    
    [dict setObject:_reviewTitleTextField.text forKey:@"review_title"];
    [dict setObject:_reviewTextView.text forKey:@"review_text"];
    [dict setObject:[NSString stringWithFormat:@"%d",rating] forKey:@"stars"];
    
    return dict;
    
}



@end
