//
//  FeaturedCarerViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 16/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FeaturedCarerViewController.h"

@interface FeaturedCarerViewController ()

@end

@implementation FeaturedCarerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    _becomeFeaturedButton.layer.cornerRadius = 20.0;
    _becomeFeaturedButton.layer.masksToBounds = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonTapped:(id)sender {
    
    [self.sideMenuController showLeftViewAnimated];
    
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
