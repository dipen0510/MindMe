//
//  RegisterViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _firstNameLabelTopConstraint.constant = (90./568.)*[UIScreen mainScreen].bounds.size.height;
    
    NSRange range = [self.legalLabel.text rangeOfString:NSLocalizedString(@"Terms of Services", nil)];
    [self.legalLabel addLinkToURL:[NSURL URLWithString:@"action://ToS"] withRange:range];
    NSRange range1 = [self.legalLabel.text rangeOfString:NSLocalizedString(@"Privacy Policy", nil)];
    [self.legalLabel addLinkToURL:[NSURL URLWithString:@"action://PP"] withRange:range1];
    self.legalLabel.delegate = self;
    
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

- (IBAction)careGiverButtonTapped:(id)sender {
    
    _careGiverButton.selected = YES;
    _careNeededButton.selected = NO;
    
}

- (IBAction)careNeededButtonTapped:(id)sender {
    
    _careGiverButton.selected = NO;
    _careNeededButton.selected = YES;
    
}

- (IBAction)signInButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

#pragma mark - TTTAttributedLabel Delegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    
    if ([[url scheme] hasPrefix:@"action"]) {
        
        if ([[url host] hasPrefix:@"ToS"]) {
            
            NSLog(@"ToS");
            [self performSegueWithIdentifier:@"showToSSegue" sender:nil];
            
        } else if ([[url host] hasPrefix:@"PP"]) {
            
            NSLog(@"PP");
            [self performSegueWithIdentifier:@"showPrivacySegue" sender:nil];
            
        }
        
    }
}

@end
