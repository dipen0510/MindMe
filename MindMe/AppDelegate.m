//
//  AppDelegate.m
//  MindMe
//
//  Created by Dipen Sekhsaria on 04/10/17.
//  Copyright © 2017 Stardeep. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Stripe/Stripe.h>
#import <OneSignal/OneSignal.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD setMaximumDismissTimeInterval:2.0];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_rFhihoAilbwnqvKfLRRTE3c8"];
    
    [OneSignal initWithLaunchOptions:launchOptions appId:@"93689775-ff90-4eea-aec2-8cf67d1d9446"];
    
    return YES;
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
} 


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
    
    NSDate* currentDate = [NSDate date];
    NSDate* lastActiveDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"LastActiveDate"];
    
    if (lastActiveDate) {
        
        NSTimeInterval interval = [currentDate timeIntervalSinceDate:lastActiveDate];
        
        if (interval > 2*60*60) {
            
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
                
            }
            
        }
        
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"LastActiveDate"];
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
