//
//  SelectLanguageViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 19/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "SelectLanguageViewController.h"

@interface SelectLanguageViewController ()

@end

@implementation SelectLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _contentView.layer.cornerRadius = 5.0;
    _contentView.layer.masksToBounds = YES;
    
    [self.bgTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDrivingLicenseInfo:)]];
    self.bgTapView.userInteractionEnabled = YES;
    
    _languageTextField.font = [UIFont fontWithName:@"Montserrat-Light" size:(15./667)*kScreenHeight];
    
}

- (void) hideDrivingLicenseInfo:(id)sender {
    
    [self.view endEditing:YES];
    [self.view removeFromSuperview];
    
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

@end
