//
//  FBLoginHelper.m
//  MindMe
//
//  Created by InfosysDev on 07/12/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "FBLoginHelper.h"

@implementation FBLoginHelper
@synthesize emailId, socialId, firstName,loginManager;
static FBLoginHelper *singletonObject = nil;

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
    });
    return singletonObject;
}

- (id)init
{
    if (! singletonObject) {
        singletonObject = [super init];
    }
    return singletonObject;
}

-(void)initiateFBLoginFromView:(UIViewController *)viewController withCompletionBlock:(isFBDataExtracted)extracted
{
    loginManager = [[FBSDKLoginManager alloc] init];
    [self initiateLogout];
        //login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    [loginManager
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:viewController
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
             extracted(NO);
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
             extracted(NO);
         } else {
             if(result.token)   // This means if There is current access token.
             {
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                    parameters:@{@"fields": @"id, email, first_name, last_name"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id userinfo, NSError *error) {
                      if (!error) {
                          NSLog(@"%@",userinfo);
                          [self setSocialId:[userinfo objectForKey:@"id"]];
                          [self setEmailId:[userinfo objectForKey:@"email"]];
                          [self setFirstName:[userinfo objectForKey:@"first_name"]];
                          [self setLastName:[userinfo objectForKey:@"last_name"]];
                          extracted(YES);
                      }
                      else{
                          NSLog(@"%@", [error localizedDescription]);
                          extracted(NO);
                      }
                  }];
             }
             else
             {
                extracted(NO);
                NSLog(@"Login Cancel");
             }
             
         }
     }];
}

-(void)initiateLogout
{
    [loginManager logOut];
}

@end
