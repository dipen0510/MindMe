//
//  ContactUsViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 08/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "ContactUsViewController.h"
#import "ActionSheetPicker.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _sendButton.layer.cornerRadius = 20.0;
    _sendButton.layer.masksToBounds = NO;
    
    _enquiryTypeTextField.delegate = self;
    _emailTextField.delegate = self;
    _nameTextField.delegate = self;
    _contactNumberTextField.delegate = self;
    _enquireyDescTextView.delegate = self;
    
    _contactNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [_sendButton addTarget:self action:@selector(sendButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
}

- (void) sendButtonTapped {
    
    NSString* formValid = [self isFormValid];
    if (!formValid) {
        [self startContactusService];
    }
    else {
        [SVProgressHUD showErrorWithStatus:formValid];
    }

    
}

- (NSString*) isFormValid {
    if ([_nameTextField.text isEqualToString:@""]) {
        return @"Please enter full name to proceed";
    }
    else if ([_contactNumberTextField.text isEqualToString:@""]) {
        return @"Please enter contact number to proceed";
    }
    else if ([_emailTextField.text isEqualToString:@""]) {
        return @"Please enter email to proceed";
    }
    else if(![self validateEmailWithString:_emailTextField.text]) {
        return @"Please enter a valid email to proceed";
    }
    else if ([_enquireyDescTextView.text isEqualToString:@""]) {
        return @"Please enter your enquiry to proceed";
    }
    
    return nil;
}

- (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"^[a-zA-Z0-9]+(_)?([-_+.][a-zA-Z0-9_]+)*\\@[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*\\.[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _enquiryTypeTextField) {
        [self enquiryTypeFieldTapped];
        return NO;
    }
    
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField == _contactNumberTextField) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField == _contactNumberTextField) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView == _enquireyDescTextView && [textView.text containsString:@"Type your Enquiry"]) {
        textView.text = @"";
    }
    
    return YES;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (textView == _enquireyDescTextView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }

    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView == _enquireyDescTextView) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +100., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}


- (void) enquiryTypeFieldTapped {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Enquiry Type" rows:[NSArray arrayWithObjects:@"General Enquiry", @"Looking to Hire", @"Looking for a Job", @"Membership", @"Report a Problem", nil] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        _enquiryTypeTextField.text = selectedValue;
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
    
    
}

#pragma mark - API Helpers

- (void) startContactusService {
    
    [SVProgressHUD showWithStatus:@"Sending request"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = ContactUs;
    manager.delegate = self;
    [manager startPOSTingFormDataAfterLogin:[self prepareDictionaryForContactUs]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    if ([requestServiceKey isEqualToString:ContactUs]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Request sent successfully"];
        
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

- (NSMutableDictionary *) prepareDictionaryForContactUs {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:[NSString stringWithFormat:@"%@ - Carer",_nameTextField.text] forKey:@"name"];
    }
    else {
        [dict setObject:[NSString stringWithFormat:@"%@ - Parent",_nameTextField.text] forKey:@"name"];
    }
    
    [dict setObject:_enquiryTypeTextField.text forKey:@"email_topic"];
    [dict setObject:[NSString stringWithFormat:@"%@",[[SharedClass sharedInstance] userId]] forKey:@"membership_login"];
    [dict setObject:_emailTextField.text forKey:@"email"];
    [dict setObject:_contactNumberTextField.text forKey:@"contact_number"];
    [dict setObject:_enquireyDescTextView.text forKey:@"message"];
    
    return dict;
    
}

@end
