//
//  GoogleAnalyticsHelper.m
// 
//
//  Created by Dipen Sekhsaria on 26/11/15.
//  Copyright © 2015. All rights reserved.
//

#import "GoogleAnalyticsHelper.h"

@implementation GoogleAnalyticsHelper

static GoogleAnalyticsHelper *singletonObject = nil;

//+ (id) sharedInstance
//{
//    if (! singletonObject) {
//        
//        singletonObject = [[GoogleAnalyticsHelper alloc] init];
//    }
//    return singletonObject;
//}


+ (id)sharedInstance {
    //static MyManager *sharedMyManager = nil;
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
        // Uncomment the following line to see how many times is the init method of the class is called
         //NSLog(@"%s", __PRETTY_FUNCTION__);
        
        // Configure tracker from GoogleService-Info.plist.
//        NSError *configureError;
//        [[GGLContext sharedInstance] configureWithError:&configureError];
//        NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
        
        // Optional: configure GAI options.
        gai = [GAI sharedInstance];
        
        gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
        gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
        gai.dispatchInterval = 30;
        
        // May return nil if a tracker has not already been initialized with a property
        // ID.
        tracker = [gai trackerWithTrackingId:@"UA-121734279-1"];
        gai.defaultTracker = tracker;

        
    }
    return singletonObject;
}

@end
