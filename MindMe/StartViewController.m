//
//  StartViewController.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 29/11/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupInitialUi];
    
}

- (void) setupInitialUi {
    
    [[SharedClass sharedInstance] setIsFeaturedFilterApplied:NO];
    [[SharedClass sharedInstance] setIsLastMinuiteCareFilterApplied:NO];
    
    NSString* userid = [[NSUserDefaults standardUserDefaults] valueForKey:@"Userid"];
    NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    BOOL isUserCarer = [[NSUserDefaults standardUserDefaults] boolForKey:@"isUserCarer"];
    NSString* userAutId = [[NSUserDefaults standardUserDefaults] objectForKey:@"User_auth_id"];
    
    if (userid && token) {
        
        [[SharedClass sharedInstance] setUserId:userid];
        [[SharedClass sharedInstance] setAuthorizationKey:token];
        [[SharedClass sharedInstance] setIsUserCarer:isUserCarer];
        [[SharedClass sharedInstance] setUserAuthId:userAutId];
        
        [self startGetProfileDetailsService];
        
        if (isUserCarer) {
            [self carerButtonTapped:nil];
        }
        else {
            [self parentButtonTapped:nil];
        }
        
    }
    
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

- (IBAction)parentButtonTapped:(id)sender {
    
    if (![[SharedClass sharedInstance] userId]) {
        [[SharedClass sharedInstance] setIsUserCarer:NO];
        [[SharedClass sharedInstance] setIsGuestUser:YES];
    }
    
    [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
    
}

- (IBAction)carerButtonTapped:(id)sender {
    
    if (![[SharedClass sharedInstance] userId]) {
        [[SharedClass sharedInstance] setIsUserCarer:YES];
        [[SharedClass sharedInstance] setIsGuestUser:YES];
    }
    
    [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
    
}

#pragma mark - API Helpers

- (void) startGetProfileDetailsService {
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = GetUserPersonalDetails;
    manager.delegate = nil;
    [manager startPOSTingFormDataForRefreshingUserToken:[self prepareDictionaryForGetProfileDetails]];
    
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForGetProfileDetails {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if ([[SharedClass sharedInstance] isUserCarer]) {
        [dict setObject:@"carer" forKey:@"flag"];
    }
    else {
        [dict setObject:@"parent" forKey:@"flag"];
    }
    
    return dict;
    
}

@end
